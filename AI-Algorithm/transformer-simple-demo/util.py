import math
import torch
from torch import nn

from hyper_param import D_K, DIMENSION, DROPOUT, HEADS


def attention(Q, K, V, mask, dropout=None):
    """
    注意力计算函数
    :param Q: [batch, heads, q_len, d_k]  示例 [b, 4, 50, 8]
    :param K: [batch, heads, k_len, d_k]  示例 [b, 4, 50, 8]  (q_len可以不等于k_len)
    :param V: [batch, heads, k_len, d_k]  示例 [b, 4, 50, 8]
    :param mask: [batch, 1, q_len, k_len]
    :param dropout: 作用在注意力分数上的Dropout（eval模式下自动失效）
    :return: [batch, q_len, heads * d_k]  示例 [b, 50, 32]
    """

    # 1. QK^T/sqrt{d_k}   score 形状为 [batch, heads, q_len, k_len]
    score = torch.matmul(Q, K.permute(0, 1, 3, 2)) / D_K ** 0.5

    # 2. 掩码 (mask为true的地方替换为一个极小值，softmax后注意力权重趋近0)。注意不要用-float('inf')，因为如果某一行恰好全被mask，-inf会让softmax产生NaN。
    score = score.masked_fill(mask, torch.finfo(score.dtype).min)

    # 3. softmax 得到注意力分数
    score = torch.softmax(score, dim=-1)

    # 4. 注意力分数上的dropout（标准Transformer做法）
    if dropout is not None:
        score = dropout(score)

    # 5. 乘以V得到最终的注意力结果  [b, 4, q_len, k_len] * [b, 4, k_len, 8] = [b, 4, q_len, 8]
    score = torch.matmul(score, V)

    # 6. 合并多个头 [b, 4, q_len, 8] -> [b, q_len, 32]
    score = score.permute(0, 2, 1, 3).reshape(-1, Q.shape[2], DIMENSION)

    return score


# 多头注意力计算层（纯注意力：LayerNorm和残差连接由外层的Layer统一负责，这才是标准pre-norm结构）
class MultiHead(nn.Module):
    def __init__(self):
        super().__init__()
        self.WQ = nn.Linear(DIMENSION, DIMENSION)
        self.WK = nn.Linear(DIMENSION, DIMENSION)
        self.WV = nn.Linear(DIMENSION, DIMENSION)
        self.WO = nn.Linear(DIMENSION, DIMENSION)
        self.attn_dropout = nn.Dropout(p=DROPOUT) # 注意力分数上的dropout
        self.wo_dropout = nn.Dropout(p=DROPOUT)   # 输出层的dropout

    def forward(self, query, key, value, mask):
        # Q/K/V分别投影后算注意力（q_len可以不等于k_len）
        batch_size = query.shape[0]

        # 投影
        Q = self.WQ(query)
        K = self.WK(key)
        V = self.WV(value)

        # 拆分多头  [b, seq_len, 32] -> [b, 4, seq_len, 8]
        Q = Q.reshape(batch_size, -1, HEADS, D_K).permute(0, 2, 1, 3)
        K = K.reshape(batch_size, -1, HEADS, D_K).permute(0, 2, 1, 3)
        V = V.reshape(batch_size, -1, HEADS, D_K).permute(0, 2, 1, 3)

        # 计算注意力
        score = attention(Q, K, V, mask, dropout=self.attn_dropout)

        # 输出投影  [b, q_len, 32] -> [b, q_len, 32]
        return self.wo_dropout(self.WO(score))


# 位置编码层（接收未缩放的词向量：先乘sqrt(d_model)让词义信息和位置信息量级匹配，再加位置编码，最后过dropout）
class PositionalEncoding(nn.Module):
    def __init__(self, max_len):
        super().__init__()

        # 初始化位置编码矩阵
        position = torch.arange(max_len, dtype=torch.float).unsqueeze(1)
        div_term = 1e4 ** (torch.arange(0, DIMENSION, 2, dtype=torch.float) / DIMENSION)
        pe = torch.empty(max_len, DIMENSION)
        pe[:, 0::2] = torch.sin(position / div_term)
        pe[:, 1::2] = torch.cos(position / div_term)
        pe = pe.unsqueeze(0)  # [1, max_len, 32]

        # 将PE矩阵定义为不会更新的常量
        self.register_buffer('pe', pe)

        # embedding + PE 之后的dropout（标准Transformer做法，eval模式下自动失效）
        self.dropout = nn.Dropout(p=DROPOUT)

    def forward(self, x, pos_offset=0):
        # x [b, seq, 32]
        # 1. 乘sqrt(d_model)是原论文做法，让词义信息和位置信息量级匹配
        x = x * math.sqrt(DIMENSION)
        # 2. 加位置编码：第j个词使用位置(pos_offset + j)的编码
        #    全量输入时pos_offset=0；KV cache增量解码时每次只进一个新token，必须传它自己的绝对位置，否则所有新token都会拿到pe[0]
        x = x + self.pe[:, pos_offset:pos_offset + x.shape[1]]
        # 3. dropout
        return self.dropout(x)


# 前馈神经网络层（纯FFN：LayerNorm和残差连接由外层的Layer统一负责）
class FeedForwardNetwork(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc = nn.Sequential(
            nn.Linear(in_features=DIMENSION, out_features=DIMENSION * 4),
            nn.ReLU(),
            nn.Linear(in_features=DIMENSION * 4, out_features=DIMENSION),
            nn.Dropout(p=DROPOUT),
        )

    def forward(self, x):
        return self.fc(x)
