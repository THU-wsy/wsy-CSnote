from data_set import *
from hyper_param import *


# mask_pad用于屏蔽输入句子x里的pad
def mask_pad(x: torch.Tensor):
    # 判断每个词是不是<PAD>
    mask = x == vocab_x['<PAD>']

    # [b, 50] -> [b, 1, 1, 50]
    mask = mask.unsqueeze(1).unsqueeze(1)

    # 在计算注意力时，是计算50个词和50个词相互之间的注意力，所以是个 50 * 50 的矩阵
    # 任何词对pad的注意力都是0，但pad对其他词的注意力不是0
    # 所以pad列为true，而pad行为false
    # 所以只需将原来的这一行复制50行即可
    # [b, 1, 1, 50] -> [b, 1, 50, 50]
    mask = mask.expand(-1, 1, SEQ_LEN, SEQ_LEN)

    return mask


# mask_triangle用于屏蔽目标句子y里的pad、以及未来词
def mask_triangle(y: torch.Tensor):
    # 每个词只能看到它自己和它之前的词，所以该50*50矩阵的上三角部分（不含对角线）都应该为true
    # [1, 50, 50]
    triangle = torch.tril(torch.ones(1, SEQ_LEN, SEQ_LEN, device=y.device)) == 0

    # 判断y中的每个词是不是pad，如果是pad则不可见
    mask = y == vocab_y['<PAD>']

    # [b, 50] -> [b, 1, 50]
    mask = mask.unsqueeze(1)

    # mask 和 triangle 取并集   [b, 1, 50] + [1, 50, 50] -> [b, 50, 50]
    mask = mask | triangle

    # 变成多头需要的形状 [b, 1, 50, 50]
    mask = mask.unsqueeze(1)

    return mask