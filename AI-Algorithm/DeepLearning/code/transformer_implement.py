import torch
from d2l import torch as d2l
import matplotlib
from torch import nn
import math
import os

matplotlib.use('TkAgg')

# 修复 d2l read_data_nmt 的编码问题
def _read_data_nmt_utf8():
    data_dir = d2l.download_extract('fra-eng')
    with open(os.path.join(data_dir, 'fra.txt'), 'r', encoding='utf-8') as f:
        return f.read()
d2l.read_data_nmt = _read_data_nmt_utf8


def sequence_mask(X, valid_len, value=0.0):
    """
    功能：将序列中的无效位置，替换为指定值 value

    X：2D张量，形状为 (batch_size * num_queries, num_keys)

    valid_len：1D张量，形状为 (batch_size * num_queries,)

    核心逻辑：
    - max_len 即为 X 的 num_keys，我们以 max_len = 5、valid_len = [1,2,3,4,1,1,1,1] 为例
    - [None, :]进行行扩展，将 [0,1,2,3,4] -> [[0,1,2,3,4]]
    - [:, None]进行列扩展，将 [1,2,3,4,1,1,1,1] -> [[1],[2],[3],[4],[1],[1],[1],[1]]
    - 广播比较得到mask
      [[0,1,2,3,4],         [[1,1,1,1,1],              [[True,False,False,False,False],
       [0,1,2,3,4],          [2,2,2,2,2],               [True,True,False,False,False],
       [0,1,2,3,4],          [3,3,3,3,3],               [True,True,True,False,False],
       [0,1,2,3,4],    <     [4,4,4,4,4],     --->      [True,True,True,True,False],
       [0,1,2,3,4],          [1,1,1,1,1],               [True,False,False,False,False],
       [0,1,2,3,4],          [1,1,1,1,1],               [True,False,False,False,False],
       [0,1,2,3,4],          [1,1,1,1,1],               [True,False,False,False,False],
       [0,1,2,3,4]]          [1,1,1,1,1]]               [True,False,False,False,False]]
    - X.masked_fill(~mask, value) 就是将 mask=False 的位置替换为 value

    """

    max_len = X.size(1)
    mask = torch.arange(max_len, dtype=torch.float32, device=X.device)[None, :] < valid_len[:, None]
    return X.masked_fill(~mask, value)


def masked_softmax(X, valid_lens):
    """
    功能：通过在最后一个轴上掩蔽元素来执行softmax操作。对注意力分数矩阵做 softmax，
    但对无效位置（padding）先填入极大负数 -1e6，使其 softmax 后趋近于0，相当于"屏蔽"掉这些位置。
    使用 -1e6 而不是 -inf 的原因是，-inf 在某些情况下会产生 nan（如全行都是 -inf 时），所以 -1e6 数值更稳定。

    X：注意力矩阵，形状为 (batch_size, num_queries, num_keys)

    valid_lens：形状为 1D 或 2D
    - 1D：形状 (batch_size,)，例如 [2, 3] 代表 batch0 的每个 Query 仅有效2列、batch1 的每个 Query 仅有效3列
    - 2D：形状 (batch_size, num_queries)，例如 [[1,2,3,4],[1,1,1,1]] 代表
          batch0 的每个 Query 分别生效1、2、3、4列
          batch1 的每个 Query 分别生效1、1、1、1列

    返回值：与输入 X 形状完全相同，但每行和为1，形状 (batch_size, num_queries, num_keys)

    """
    if valid_lens is None:
        return nn.functional.softmax(X, dim=-1)
    else:
        shape = X.shape
        if valid_lens.dim() == 1:
            # 展平，例如 valid_lens = [2,3]，X 的 num_queries=4，那么就会展平成 [2,2,2,2,3,3,3,3]
            valid_lens = torch.repeat_interleave(valid_lens, shape[1])
        else:
            # 例如 valid_lens = [[1,2,3,4],[1,1,1,1]]，就会变成 [1,2,3,4,1,1,1,1]
            valid_lens = valid_lens.reshape(-1)
        # 最后一轴上被掩蔽的元素使用一个非常大的负值替换，从而其softmax输出为0
        X = sequence_mask(X.reshape(-1, shape[-1]), valid_lens, value=-1e6)
        return nn.functional.softmax(X.reshape(shape), dim=-1)


class DotProductAttention(nn.Module):
    """
    功能：缩放点积注意力。引入 dropout 的目的是让模型不能过度依赖某几个固定的Key，
    训练时每次看到的注意力分布都略有不同，迫使模型学到更鲁棒的表示。

    - queries的形状：(batch_size, num_queries, d)
    - keys的形状：(batch_size, num_keys, d)
    - values的形状：(batch_size, num_keys, value_dim)
    - valid_lens的形状：(batch_size,) 或者 (batch_size, num_queries)
    注意：keys和values的个数要相同(均为num_keys)，点积注意力中queries和keys的维度数要相同(均为d)

    输出形状：(batch_size, num_queries, value_dim)

    """

    def __init__(self, dropout, **kwargs):
        super().__init__(**kwargs)
        self.dropout = nn.Dropout(dropout)
        self.attention_weights = None

    def forward(self, queries, keys, values, valid_lens=None):
        d = queries.shape[-1]
        # QK^T/sqrt{d} -> (batch_size, num_queries, num_keys)
        scores = torch.bmm(queries, keys.transpose(1, 2)) / math.sqrt(d)
        # 形状仍为 (batch_size, num_queries, num_keys) 且每行和为1
        self.attention_weights = masked_softmax(scores, valid_lens)
        # 结果形状 (batch_size, num_queries, value_dim)
        # dropout对注意力矩阵的每个元素独立以概率p置为0，相当于训练过程中会忽略部分 key-value 对，推理时会自动关闭 dropout
        return torch.bmm(self.dropout(self.attention_weights), values)


class MultiHeadAttention(nn.Module):
    """
    多头注意力。Transformer中，投影后的特征维度会保持相同(num_hiddens)，然后拆分多个头(num_heads)进行并行计算，
    每个头的特征维度为 num_hiddens / num_heads，最终再将多个头合并。
    """

    def __init__(self, query_size, key_size, value_size, num_hiddens, num_heads, dropout, **kwargs):
        """
        Transformer 架构中 query_size、key_size、value_size、num_hiddens 必须取相同值 (d_model)
        :param query_size: query的特征维度
        :param key_size: key的特征维度
        :param value_size: value的特征维度
        :param num_hiddens: 投影后的特征维度
        :param num_heads: 注意力头数
        :param dropout: dropout
        """

        super().__init__(**kwargs)
        self.num_heads = num_heads
        self.attention = DotProductAttention(dropout)
        self.W_q = nn.Linear(query_size, num_hiddens, bias=False)
        self.W_k = nn.Linear(key_size, num_hiddens, bias=False)
        self.W_v = nn.Linear(value_size, num_hiddens, bias=False)
        self.W_o = nn.Linear(num_hiddens, num_hiddens, bias=False)

    def forward(self, queries, keys, values, valid_lens):
        """
        :param queries: (batch_size, num_queries, query_size)
        :param keys: (batch_size, num_keys, key_size)
        :param values: (batch_size, num_keys, value_size)
        :param valid_lens: (batch_size,) 或 (batch_size, num_queries)
        :return: (batch_size, num_queries, num_hiddens)
        """

        queries = transpose_qkv(self.W_q(queries), self.num_heads)
        keys = transpose_qkv(self.W_k(keys), self.num_heads)
        values = transpose_qkv(self.W_v(values), self.num_heads)
        if valid_lens is not None:
            """
            在轴0，将第一项（标量或者矢量）复制num_heads次，然后如此复制第二项，依次类推。
            - 1D情况：假设 num_heads=4，形状 (batch_size,) -> (batch_size * num_heads,)
              [2,3] -> [2,2,2,2,3,3,3,3]
            - 2D情况：假设 num_heads=4，形状 (batch_size, num_queries) -> (batch_size * num_heads, num_queries)
              [[1,2,3],  ->  [[1,2,3],
               [2,3,4]]       [1,2,3],
                              [1,2,3],
                              [1,2,3],
                              [2,3,4],
                              [2,3,4],
                              [2,3,4],
                              [2,3,4]]
            """
            valid_lens = torch.repeat_interleave(valid_lens, repeats=self.num_heads, dim=0)

        # output的形状: (batch_size * num_heads, num_queries, num_hiddens / num_heads)
        output = self.attention(queries, keys, values, valid_lens)
        # output_concat的形状: (batch_size, num_queries, num_hiddens)
        output_concat = transpose_output(output, self.num_heads)
        return self.W_o(output_concat)


def transpose_qkv(X, num_heads):
    """
    将输入 X 拆分多头，为了多注意力头的并行计算而变换形状
    - 输入 X 形状 (batch_size, seq_len, num_hiddens)
    - 输出 X 形状 (batch_size * num_heads, seq_len, num_hiddens / num_heads)
    """
    X = X.reshape(X.shape[0], X.shape[1], num_heads, -1)
    X = X.permute(0, 2, 1, 3)
    return X.reshape(-1, X.shape[2], X.shape[3])


def transpose_output(X, num_heads):
    """
    合并多头，逆转transpose_qkv函数的操作
    - 输入 X 形状 (batch_size * num_heads, seq_len, num_hiddens / num_heads)
    - 输出 X 形状 (batch_size, seq_len, num_hiddens)
    """
    X = X.reshape(-1, num_heads, X.shape[1], X.shape[2])
    X = X.permute(0, 2, 1, 3)
    return X.reshape(X.shape[0], X.shape[1], -1)


class PositionalEncoding(nn.Module):
    """位置编码"""

    def __init__(self, num_hiddens, dropout, max_len=1000):
        super().__init__()
        self.dropout = nn.Dropout(dropout)
        # 创建一个足够长的位置矩阵，max_len个位置，每个位置是 num_hiddens 维的向量
        self.register_buffer('P', torch.zeros((1, max_len, num_hiddens)))
        # 根据论文中的位置编码公式进行计算
        X = torch.arange(max_len, dtype=torch.float32).reshape(-1, 1) / torch.pow(
            10000, torch.arange(0, num_hiddens, 2, dtype=torch.float32) / num_hiddens)
        self.P[:, :, 0::2] = torch.sin(X)
        self.P[:, :, 1::2] = torch.cos(X)

    def forward(self, X):
        # X 形状 (batch_size, seq_len, num_hiddens)
        X = X + self.P[:, :X.shape[1], :]
        return self.dropout(X)


class PositionWiseFFN(nn.Module):
    """基于位置的前馈网络"""

    def __init__(self, ffn_num_input, ffn_num_hiddens, ffn_num_outputs, **kwargs):
        super().__init__(**kwargs)
        self.dense1 = nn.Linear(ffn_num_input, ffn_num_hiddens)
        self.relu = nn.ReLU()
        self.dense2 = nn.Linear(ffn_num_hiddens, ffn_num_outputs)

    def forward(self, X):
        # 通常 ffn_num_outputs 与 ffn_num_input 保持一致
        # (batch_size, seq_len, ffn_num_input) -> (batch_size, seq_len, ffn_num_outputs)
        return self.dense2(self.relu(self.dense1(X)))


class AddNorm(nn.Module):
    """
    残差连接后进行层规范化

    normalized_shape
    - 通常是一个单元素列表，等于 [num_hiddens]，表示对最后一维做归一化
    - 也可以是一个双元素列表(很少用)，等于 [seq_len, num_hiddens]，表示对最后两维一起做归一化

    """

    def __init__(self, normalized_shape, dropout, **kwargs):
        super().__init__(**kwargs)
        self.dropout = nn.Dropout(dropout)
        self.ln = nn.LayerNorm(normalized_shape)

    def forward(self, X, Y):
        # X和Y的形状要相同
        return self.ln(self.dropout(Y) + X)


class EncoderBlock(nn.Module):
    """Transformer编码器块"""

    def __init__(self, num_hiddens, ffn_num_hiddens, num_heads, dropout, **kwargs):
        super().__init__(**kwargs)
        self.attention = MultiHeadAttention(num_hiddens, num_hiddens, num_hiddens, num_hiddens, num_heads, dropout)
        self.add_norm1 = AddNorm([num_hiddens], dropout)
        self.ffn = PositionWiseFFN(num_hiddens, ffn_num_hiddens, num_hiddens)
        self.add_norm2 = AddNorm([num_hiddens], dropout)

    def forward(self, enc_X, enc_valid_lens):
        Y = self.add_norm1(enc_X, self.attention(enc_X, enc_X, enc_X, enc_valid_lens))
        return self.add_norm2(Y, self.ffn(Y))


class TransformerEncoder(nn.Module):
    """Transformer编码器"""

    def __init__(self, src_vocab_size, num_hiddens, ffn_num_hiddens, num_heads, num_layers, dropout, **kwargs):
        super().__init__(**kwargs)
        self.num_hiddens = num_hiddens
        self.embedding = nn.Embedding(src_vocab_size, num_hiddens)
        self.pos_encoding = PositionalEncoding(num_hiddens, dropout)
        self.blks = nn.Sequential()
        for i in range(num_layers):
            self.blks.add_module("block" + str(i),
                                 EncoderBlock(num_hiddens, ffn_num_hiddens, num_heads, dropout))
        self.attention_weights = [None] * len(self.blks)

    def forward(self, enc_X, enc_valid_lens):
        # 因为位置编码值在-1和1之间，
        # 因此嵌入值乘以嵌入维度的平方根进行缩放，
        # 然后再与位置编码相加。
        # 输入 X (batch_size, src_num_steps) -> 输出 X (batch_size, src_num_steps, num_hiddens)
        enc_X = self.pos_encoding(self.embedding(enc_X) * math.sqrt(self.num_hiddens))
        self.attention_weights = [None] * len(self.blks)
        for i, blk in enumerate(self.blks):
            enc_X = blk(enc_X, enc_valid_lens)
            self.attention_weights[i] = blk.attention.attention.attention_weights
        return enc_X


class DecoderBlock(nn.Module):
    """解码器中第i个块"""

    def __init__(self, num_hiddens, ffn_num_hiddens, num_heads, dropout, i, **kwargs):
        super().__init__(**kwargs)
        self.i = i
        self.attention1 = MultiHeadAttention(num_hiddens, num_hiddens, num_hiddens, num_hiddens, num_heads, dropout)
        self.add_norm1 = AddNorm([num_hiddens], dropout)
        self.attention2 = MultiHeadAttention(num_hiddens, num_hiddens, num_hiddens, num_hiddens, num_heads, dropout)
        self.add_norm2 = AddNorm([num_hiddens], dropout)
        self.ffn = PositionWiseFFN(num_hiddens, ffn_num_hiddens, num_hiddens)
        self.add_norm3 = AddNorm([num_hiddens], dropout)

    def forward(self, dec_X, state):
        # 训练时，dec_X shape (batch_size, tgt_num_steps, num_hiddens)
        # 预测时，dec_X shape (1, 1, num_hiddens)

        # 1. 从 state 中取出 Encoder 信息
        # enc_outputs  (batch_size, src_num_steps, num_hiddens)
        # enc_valid_lens  (batch_size,)
        enc_outputs, enc_valid_lens = state[0], state[1]

        # 2. KV Cache处理
        # 训练阶段，state[2][i] is None，直接用当前输入，shape (batch_size, tgt_num_steps, num_hiddens)
        # 预测阶段，词元是一个接着一个解码的，每步把新 token 拼到历史后面
        #   - 第1步：state[2][i]=None, cat dec_X[t=0] -> (batch_size, 1, num_hiddens)
        #   - 第2步：state[2][i]=(batch_size, 1, num_hiddens), cat dec_X[t=1] -> (batch_size, 2, num_hiddens)
        #   - 第3步：state[2][i]=(batch_size, 2, num_hiddens), cat dec_X[t=2] -> (batch_size, 3, num_hiddens)
        if state[2][self.i] is None:
            key_values = dec_X
        else:
            key_values = torch.cat((state[2][self.i], dec_X), dim=1)
        state[2][self.i] = key_values

        # 3. 构造 Causal Mask（仅训练时）
        # dec_valid_lens 形状 (batch_size, tgt_num_steps)，其中每一行是[1,2,...,tgt_num_steps]
        # 例如 batch_size = 2, tgt_num_steps = 5 时，dec_valid_lens 就如下所示
        # [[1, 2, 3, 4, 5],
        #  [1, 2, 3, 4, 5]]
        if self.training:
            batch_size, tgt_num_steps, _ = dec_X.shape
            dec_valid_lens = torch.arange(1, tgt_num_steps + 1, device=dec_X.device).repeat(batch_size, 1)
        else:
            dec_valid_lens = None

        # 4. Masked Self-Attention
        # 训练时：
        #   - Q、K、V相同，均为 dec_X，即整个目标序列，配合 Causal Mask，可以保证位置 p 只能看到 0~p 位置的 token
        #     注意：Decoder 自注意力并没有 Padding Mask，因为有 Causal Mask，所以真实 token 不会注意到 <pad>。
        #          而 <pad> 可以注意到真实 token，这是没有影响的，因为 loss 计算时会被标签 Y_valid_lens 忽略掉，所以不参与梯度更新。
        # 预测时：
        #   - Q 为 dec_X (1,1,num_hiddens) 也就是仅有这一步输入的单个 token
        #   - K、V 为 key_values，包含当前+所有历史 token，所以不需要 Causal Mask（当前 token 天然看不到未来）
        X2 = self.attention1(dec_X, key_values, key_values, dec_valid_lens)
        Y = self.add_norm1(dec_X, X2)

        # 5. Cross-Attention（关键：与 Encoder 交互）
        # Q 来自于 Decoder，而 K、V 均来自于 Encoder，每个 Decoder 位置从 Encoder 的有效位置中提取相关信息
        # enc_valid_lens 屏蔽 Encoder 的 padding
        Y2 = self.attention2(Y, enc_outputs, enc_outputs, enc_valid_lens)
        Z = self.add_norm2(Y, Y2)

        # 6. FFN
        return self.add_norm3(Z, self.ffn(Z)), state


class TransformerDecoder(nn.Module):
    def __init__(self, tgt_vocab_size, num_hiddens, ffn_num_hiddens, num_heads, num_layers, dropout, **kwargs):
        super().__init__(**kwargs)
        self.num_hiddens = num_hiddens
        self.num_layers = num_layers
        self.embedding = nn.Embedding(tgt_vocab_size, num_hiddens)
        self.pos_encoding = PositionalEncoding(num_hiddens, dropout)
        self.blks = nn.Sequential()
        for i in range(num_layers):
            self.blks.add_module("block" + str(i),
                                 DecoderBlock(num_hiddens, ffn_num_hiddens, num_heads, dropout, i))
        self.dense = nn.Linear(num_hiddens, tgt_vocab_size)
        self.attention_weights = None

    def init_state(self, enc_outputs, enc_valid_lens):
        """
        初始化 state，构造三元组
        - state[0]：Encoder输出，形状 (batch_size, src_num_steps, num_hiddens)
        - state[1]：Encoder有效长度，形状 (batch_size,)
        - state[2]：每个块的 KV Cache，初始化为 [None, None, ..., None] 共 num_layers 个，推理时逐步填入各块的历史 KV
        """
        return [enc_outputs, enc_valid_lens, [None] * self.num_layers]

    def forward(self, dec_X, state):
        # 1. 输入处理，与 Encoder 一样
        dec_X = self.pos_encoding(self.embedding(dec_X) * math.sqrt(self.num_hiddens))

        # 2. 逐层通过 DecoderBlock
        # attention_weights 是一个 2 × num_layers 的列表
        #   - attention_weights[0]  → 每层的 Masked Self-Attention 权重
        #   - attention_weights[1]  → 每层的 Cross-Attention 权重
        self.attention_weights = [[None] * len(self.blks) for _ in range(2)]
        for i, blk in enumerate(self.blks):
            dec_X, state = blk(dec_X, state)
            self.attention_weights[0][i] = blk.attention1.attention.attention_weights
            self.attention_weights[1][i] = blk.attention2.attention.attention_weights

        # 3. 投影到词表
        return self.dense(dec_X), state


class EncoderDecoder(nn.Module):
    """encoder-decoder架构"""

    def __init__(self, encoder, decoder, **kwargs):
        super().__init__(**kwargs)
        self.encoder = encoder
        self.decoder = decoder

    def forward(self, enc_X, dec_X, enc_valid_lens, *args):
        # 1. 执行 encoder
        enc_outputs = self.encoder(enc_X, enc_valid_lens, *args)
        # 2. 初始化 state
        dec_state = self.decoder.init_state(enc_outputs, enc_valid_lens)
        # 3. 执行 decoder
        return self.decoder(dec_X, dec_state)


# ============================= 训练&预测 =============================

# 超参数
num_hiddens = 32  # 模型维度 d_model。Transformer 中 query_size、key_size、value_size 必须都等于 d_model，否则无法进行残差连接。
num_layers = 2    # Encoder/Decoder块各2个
num_heads = 4     # 4个注意力头，每头维度=32/4=8
ffn_num_hiddens = 2 * num_hiddens  # FFN 中间隐藏层是 d_model 的2倍（通常是4倍，这里较小）
dropout = 0.1
batch_size = 64
lr = 0.005
num_epochs = 200
src_num_steps = 10  # 源句子(英语)最大长度，超过10则截断，不足10则填充<pad>
tgt_num_steps = 10  # 目标句子(法语)最大长度，超过10则截断，不足10则填充<pad>
# |            |          训练时          |                 预测时                  |
# | source_seq | 截断/填充到 src_num_steps | 截断/填充到 src_num_steps               |
# | target_seq | 截断/填充到 tgt_num_steps | 逐步生成，遇<eos>或达到tgt_num_steps时停止 |

# 数据处理 (注意 d2l.load_data_nmt 只支持源语句和目标语句切分成相同的最大长度，而其他的数据集可以支持 src_num_steps 与 tgt_num_steps 不同)
# 1. 加载并预处理原始文本（英法翻译数据集）
# 2. 构建词表：分别为英文和法文建立词表，统计词频，低频词替换为 <unk>
#    - src_vocab（英文）: {'<pad>':0, '<bos>':1, '<eos>':2, 'i':3, 'go':4, ...}
#    - tgt_vocab（法文）: {'<pad>':0, '<bos>':1, '<eos>':2, 'je':3, 'va':4, ...}
# 3. 生成批次迭代器：每条数据截断/填充到 num_steps，记录 valid_lens，打包成 batch。train_iter 每次返回一个 batch，包含：
#    - X：英文 token 索引 (batch_size, num_steps)
#    - X_valid_lens：英文有效长度 (batch_size,)
#    - Y：法文 token 索引 (batch_size, num_steps)
#    - Y_valid_lens：法文有效长度 (batch_size,)
train_iter, src_vocab, tgt_vocab = d2l.load_data_nmt(batch_size, src_num_steps)

# 搭建模型
encoder = TransformerEncoder(len(src_vocab), num_hiddens, ffn_num_hiddens, num_heads, num_layers, dropout)
decoder = TransformerDecoder(len(tgt_vocab), num_hiddens, ffn_num_hiddens, num_heads, num_layers, dropout)
net = EncoderDecoder(encoder, decoder)

# 训练
# 注意：训练时会采用 Teacher Forcing，调整并传入整个目标句子作为 decoder 的输入，便于并行计算、提升训练速度，也就是每个 batch 只会执行一次 decoder。具体而言：
#   - train_iter 中取出的 Y 中只有 <eos>，没有 <bos>，例如 Y = [10, 17, 21, 2, 0, 0, 0, 0, 0, 0]
#   - 这个 Y 会作为 dec_target 进行损失计算，即 dec_target = Y
#   - 而 decoder 的输入会在 Y 前面拼上一个 <bos> 并去掉最后一位，即 dec_input = [1, 10, 17, 21, 2, 0, 0, 0, 0, 0]
device = torch.device('cuda')
d2l.train_seq2seq(net, train_iter, lr, num_epochs, tgt_vocab, device)

# 预测
# 1. encoder 的输入是源语言(英语)，会拼上 <eos>，并填充/截断到长度为10，并设置batch_size=1
# 2. 预测时 decoder 的输入与训练时不同，采用逐步生成，也就是每个 batch 会执行 tgt_num_steps 次 decoder（遇到 <eos> 则提前终止）：
#    - 第一步输入是 [[<bos>]]，shape: (1,1)，通过 decoder 预测到概率最大的token
#    - 第二步输入是上一步预测到的token，shape: (1, 1)，通过 decoder 预测下一个词
#    - 一直循环 tgt_num_steps 步（如果预测到 <eos> 则提前终止）
#    示例：以 'go .' -> 'va !' 为例
#    step1: dec_X = '<bos>'   ->  Y = 'va'      state[2]缓存<bos>的KV
#    step2: dec_X = 'va'      ->  Y = '!'       state[2]缓存<bos>,'va'的KV
#    step3: dec_X = '!'       ->  Y = '<eos>'   break
engs = ['go .', 'i lost .', 'he\'s calm .', 'i\'m home .']
fras = ['va !', 'j\'ai perdu .', 'il est calme .', 'je suis chez moi .']
for eng, fra in zip(engs, fras):
    translation, dec_attention_weight_seq = d2l.predict_seq2seq(
        net, eng, src_vocab, tgt_vocab, tgt_num_steps, device, True)
    print(f'{eng} => {translation}, bleu {d2l.bleu(translation, fra, k=2):.3f}')

d2l.plt.show()
