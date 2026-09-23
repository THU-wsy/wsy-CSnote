import math
import torch
from torch import nn
from hyper_param import *


def attention(Q, K, V, mask):
    """
    注意力计算函数
    :param Q: [batch, heads, seq_len, d_k]  示例 [b, 4, 50, 8]
    :param K: [batch, heads, seq_len, d_k]  示例 [b, 4, 50, 8]
    :param V: [batch, heads, seq_len, d_k]  示例 [b, 4, 50, 8]
    :param mask: [batch, 1, seq_len, seq_len]
    :return: [batch, seq_len, heads * d_k]  示例 [b, 50, 32]
    """

    # 1. QK^T/sqrt{d_k}   score 形状为 [batch, heads, seq_len, seq_len]
    score = torch.matmul(Q, K.permute(0, 1, 3, 2))
    score /= D_K ** 0.5

    # 2. 掩码 (mask为true的地方都替换为-inf，这样做softmax时-inf会被压缩到0)
    # mask 的形状为 [batch, 1, seq_len, seq_len]
    score = score.masked_fill_(mask, -float('inf'))

    # 3. softmax 得到注意力分数
    score = torch.softmax(score, dim=-1)

    # 4. 乘以V得到最终的注意力结果  [b, 4, 50, 50] * [b, 4, 50, 8] = [b, 4, 50, 8]
    score = torch.matmul(score, V)

    # 5. 合并多个头 [b, 4, 50, 8] -> [b, 50, 32]
    score = score.permute(0, 2, 1, 3).reshape(-1, SEQ_LEN, DIMENSION)

    return score


# 多头注意力计算层
class MultiHead(nn.Module):
    def __init__(self):
        super().__init__()
        self.WQ = nn.Linear(DIMENSION, DIMENSION)
        self.WK = nn.Linear(DIMENSION, DIMENSION)
        self.WV = nn.Linear(DIMENSION, DIMENSION)
        self.WO = nn.Linear(DIMENSION, DIMENSION)
        # 词向量维度做归一化
        self.norm = nn.LayerNorm(normalized_shape=DIMENSION)
        self.dropout = nn.Dropout(p=DROPOUT)

    def forward(self, query, key, value, mask):
        # query key value 的形状为 [b, 50, 32], mask 形状为 [b, 1, 50, 50]
        batch_size = query.shape[0]

        # 保留原始query，后面做残差连接用
        clone_query = query.clone()

        # layer norm  (这个写法好像有点问题，共用了一个 layerNorm 学习参数，后续看看怎么调整)
        query = self.norm(query)
        key = self.norm(key)
        value = self.norm(value)

        # 线性运算，且维度不变
        Q = self.WQ(query)
        K = self.WK(key)
        V = self.WV(value)

        # 拆分多头  [b, 50, 32] -> [b, 4, 50, 8]
        Q = Q.reshape(batch_size, SEQ_LEN, HEADS, D_K).permute(0, 2, 1, 3)
        K = K.reshape(batch_size, SEQ_LEN, HEADS, D_K).permute(0, 2, 1, 3)
        V = V.reshape(batch_size, SEQ_LEN, HEADS, D_K).permute(0, 2, 1, 3)

        # 计算注意力  [b, 4, 50, 8] -> [b, 50, 32]
        score = attention(Q, K, V, mask)

        # 计算输出  [b, 50, 32] -> [b, 50, 32]
        score = self.WO(score)
        score = self.dropout(score)
        score = clone_query + score

        return score


# 位置编码层
class PositionalEncoding(nn.Module):
    def __init__(self, vocab_size):
        super().__init__()

        def get_pe(pos, dim_idx, d_model):
            i = dim_idx // 2
            base = 1e4 ** (2 * i / d_model)
            if dim_idx % 2 == 0:
                return math.sin(pos / base)
            else:
                return math.cos(pos / base)

        # 初始化位置编码矩阵
        pe = torch.empty(SEQ_LEN, DIMENSION)
        for pos in range(SEQ_LEN):
            for dim_idx in range(DIMENSION):
                pe[pos, dim_idx] = get_pe(pos, dim_idx, DIMENSION)
        pe = pe.unsqueeze(0)  # [1, 50, 32]

        # 将PE矩阵定义为不会更新的常量
        self.register_buffer('pe', pe)

        # 词编码层
        self.embed = nn.Embedding(vocab_size, DIMENSION)
        self.embed.weight.data.normal_(0, 0.1)

    def forward(self, sample):
        # [b, 50] -> [b, 50, 32]
        embed = self.embed(sample)
        # 加入位置编码  [b, 50, 32] + [1, 50, 32] -> [b, 50, 32]
        embed = embed + self.pe
        return embed


# 全连接输出层
class FeedForwardNetwork(nn.Module):
    def __init__(self):
        super().__init__()
        self.norm = nn.LayerNorm(normalized_shape=DIMENSION)
        self.fc = nn.Sequential(
            nn.Linear(in_features=DIMENSION, out_features=DIMENSION * 4),
            nn.ReLU(),
            nn.Linear(in_features=DIMENSION * 4, out_features=DIMENSION),
            nn.Dropout(p=DROPOUT),
        )

    def forward(self, x):
        clone_x = x.clone()
        x = self.norm(x)
        out = self.fc(x)
        out = clone_x + out
        return out