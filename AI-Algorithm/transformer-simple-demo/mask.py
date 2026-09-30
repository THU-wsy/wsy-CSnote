import torch

from custom_data_set import vocab_x, vocab_y


# mask_pad用于屏蔽句子x里的pad
# q_len：query的长度，不传则默认等于x的长度（用于自注意力）。交叉注意力时Q来自y，必须显式传y的长度，否则Q和K长度不同会静默算错。
def mask_pad(x: torch.Tensor, q_len: int | None = None):
    # 判断每个词是不是<PAD>
    mask = x == vocab_x['<PAD>']

    # [b, k_len] -> [b, 1, 1, k_len]
    mask = mask.unsqueeze(1).unsqueeze(1)

    # 注意力矩阵形状是 [batch, heads, q_len, k_len]
    # 任何词对pad的注意力都是0，但pad对其他词的注意力不是0
    # 所以pad列为true，而pad行为false
    # 所以只需将原来的这一行复制q_len行即可
    # [b, 1, 1, k_len] -> [b, 1, q_len, k_len]
    k_len = x.shape[1]
    if q_len is None:
        q_len = k_len
    mask = mask.expand(-1, 1, q_len, k_len)

    return mask


# mask_triangle用于屏蔽目标句子y里的pad、以及未来词
def mask_triangle(y: torch.Tensor):
    # 每个词只能看到它自己和它之前的词，所以"未来词"对应的掩码为true。
    # triangle 形状为 [1, seq_len, seq_len]，上三角(不含对角线)为true
    seq_len = y.shape[1]
    triangle = torch.ones(1, seq_len, seq_len, dtype=torch.bool, device=y.device).triu(1)

    # 判断y中的每个词是不是pad，如果是pad则不可见
    mask = y == vocab_y['<PAD>']

    # [b, seq_len] -> [b, 1, seq_len]
    mask = mask.unsqueeze(1)

    # mask 和 triangle 取并集   [b, 1, seq_len] | [1, seq_len, seq_len] -> [b, seq_len, seq_len]
    mask = mask | triangle

    # 变成多头需要的形状 [b, 1, seq_len, seq_len]
    mask = mask.unsqueeze(1)

    return mask
