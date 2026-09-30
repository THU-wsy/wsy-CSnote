import torch
from torch import nn

from custom_data_set import vocab_x_size, vocab_y_size
from hyper_param import DIMENSION, MAX_LEN, N_LAYERS
from mask import mask_pad, mask_triangle
from util import FeedForwardNetwork, MultiHead, PositionalEncoding


class EncoderLayer(nn.Module):
    def __init__(self):
        super().__init__()
        # 标准pre-norm结构：每个子层配一个LayerNorm，x = x + 子层(norm(x))
        self.norm1 = nn.LayerNorm(DIMENSION)
        self.mh = MultiHead()
        self.norm2 = nn.LayerNorm(DIMENSION)
        self.fc = FeedForwardNetwork()

    def forward(self, x, mask):
        # 自注意力：Q/K/V都来自同一个归一化结果  [b, 50, 32] -> [b, 50, 32]
        h = self.norm1(x)
        x = x + self.mh(h, h, h, mask)

        # 全连接输出  [b, 50, 32] -> [b, 50, 32]
        x = x + self.fc(self.norm2(x))

        return x


class Encoder(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.ModuleList([EncoderLayer() for _ in range(N_LAYERS)])
        # final norm：pre-norm的残差流逐层累加，末尾统一归一化一次，稳定输出尺度
        self.norm = nn.LayerNorm(DIMENSION)

    def forward(self, x, mask):
        for layer in self.layers:
            x = layer(x, mask)
        return self.norm(x)


class DecoderLayer(nn.Module):
    def __init__(self):
        super().__init__()
        # 标准pre-norm结构：每个子层配一个LayerNorm
        self.norm1 = nn.LayerNorm(DIMENSION)
        self.mh1 = MultiHead()
        self.norm2 = nn.LayerNorm(DIMENSION)
        self.mh2 = MultiHead()
        self.norm3 = nn.LayerNorm(DIMENSION)
        self.fc = FeedForwardNetwork()

    def forward(self, x, y, mask_pad_x_cross, mask_triangle_y, state=None):
        """
        y的自注意力 + y对x的交叉注意力 + FFN
        - 训练(全量)：state=None，自注意力Q/K/V都来自当前输入y（配合causal mask）
        - 预测(增量)：state非None
            1. 自注意力的K/V=历史缓存拼接当前token（KV cache），Q只来自当前token
            2. 交叉注意力的K/V始终用传入的encoder最终输出x（预测时encoder只跑一次，x固定），无需缓存
        """
        # y的自注意力
        h = self.norm1(y)
        if state is None:
            # 训练(全量)：Q/K/V都来自同一个归一化结果  [b, 100, 32]
            attn_out = self.mh1(h, h, h, mask_triangle_y)
        else:
            # 预测(增量)：KV cache，缓存未投影的token表示，拼接当前token作为K/V，由MultiHead内部统一投影
            if 'kv' in state:
                kv = torch.cat([state['kv'], h], dim=1)
            else:
                kv = h
            state['kv'] = kv
            attn_out = self.mh1(h, kv, kv, mask_triangle_y)
        y = y + attn_out

        # y对x的交叉注意力：Q=归一化后的y，K/V用encoder的最终输出（已含final norm）
        h = self.norm2(y)
        y = y + self.mh2(h, x, x, mask_pad_x_cross)

        # 全连接输出
        y = y + self.fc(self.norm3(y))

        return y


class Decoder(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.ModuleList([DecoderLayer() for _ in range(N_LAYERS)])
        # final norm：同Encoder
        self.norm = nn.LayerNorm(DIMENSION)

    def forward(self, x, y, mask_pad_x_cross, mask_triangle_y, state=None):
        """
        state=None走全量路径(训练)；
        state非None走增量路径(预测)，KV cache在state里逐层累积；
        state: list，长度=N_LAYERS，每个元素是该层自注意力的cache字典，预测时由调用方初始化为[{}]*N_LAYERS
        """
        for i, layer in enumerate(self.layers):
            layer_state = state[i] if state is not None else None
            y = layer(x, y, mask_pad_x_cross, mask_triangle_y, layer_state)
        return self.norm(y)


class Transformer(nn.Module):
    def __init__(self):
        super().__init__()
        # 词嵌入：x/y各自一份
        self.embed_x = nn.Embedding(vocab_x_size, DIMENSION)
        self.embed_y = nn.Embedding(vocab_y_size, DIMENSION)
        nn.init.normal_(self.embed_x.weight, mean=0.0, std=0.1)
        nn.init.normal_(self.embed_y.weight, mean=0.0, std=0.1)
        # 位置编码：encoder/decoder共用一份足够大的固定矩阵，按需切片即可
        self.pos = PositionalEncoding(MAX_LEN)
        # 编码器 解码器
        self.encoder = Encoder()
        self.decoder = Decoder()
        # 不带bias的输出投影
        self.fc_out = nn.Linear(DIMENSION, vocab_y_size, bias=False)
        # 权重绑定（tied embeddings）：输出投影直接复用目标词嵌入矩阵（GPT-2等的标准做法）
        self.fc_out.weight = self.embed_y.weight

    def forward(self, x, y):
        # 掩码
        # 1. encoder自注意力用的pad掩码 [b, 1, 50, 50]
        mask_pad_x = mask_pad(x)
        # 2. decoder交叉注意力用的pad掩码：Q来自y，K/V来自x，形状 [b, 1, 100, 50]
        mask_pad_x_cross = mask_pad(x, q_len=y.shape[1])
        # 3. decoder自注意力用的causal掩码 [b, 1, 100, 100]
        mask_triangle_y = mask_triangle(y)

        # 词嵌入 + 位置编码
        # x [b, 50] -> [b, 50, 32]
        # y [b, 100] -> [b, 100, 32]
        x = self.pos(self.embed_x(x))
        y = self.pos(self.embed_y(y))

        # encoder  [b, 50, 32] -> [b, 50, 32]
        x = self.encoder(x, mask_pad_x)

        # decoder  [b, 100, 32] -> [b, 100, 32]
        y = self.decoder(x, y, mask_pad_x_cross, mask_triangle_y)

        # 全连接输出 [b, 100, 32] -> [b, 100, vocab_y_size]
        y = self.fc_out(y)

        return y
