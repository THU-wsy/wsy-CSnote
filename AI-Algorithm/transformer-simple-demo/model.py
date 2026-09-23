from util import *
from mask import *
from hyper_param import *

class EncoderLayer(nn.Module):
    def __init__(self):
        super().__init__()
        self.mh = MultiHead()
        self.fc = FeedForwardNetwork()

    def forward(self, x, mask):
        # 计算自注意力，维度不变  [b, 50, 32] -> [b, 50, 32]
        score = self.mh(x, x, x, mask)
        # 全连接输出，维度不变    [b, 50, 32] -> [b, 50, 32]
        out = self.fc(score)
        return out

class Encoder(nn.Module):
    def __init__(self):
        super().__init__()
        self.layer_1 = EncoderLayer()
        self.layer_2 = EncoderLayer()
        self.layer_3 = EncoderLayer()

    def forward(self, x, mask):
        x = self.layer_1(x, mask)
        x = self.layer_2(x, mask)
        x = self.layer_3(x, mask)
        return x

class DecoderLayer(nn.Module):
    def __init__(self):
        super().__init__()
        self.mh1 = MultiHead()
        self.mh2 = MultiHead()
        self.fc = FeedForwardNetwork()

    def forward(self, x, y, mask_pad_x, mask_triangle_y):
        # 计算y的自注意力，维度不变 [b, 50, 32] -> [b, 50, 32]
        y = self.mh1(y, y, y, mask_triangle_y)

        # 计算y对于x的注意力，Q=y，K=x，V=x，维度不变  [b, 50, 32] -> [b, 50, 32]
        y = self.mh2(y, x, x, mask_pad_x)

        # 全连接输出，维度不变  [b, 50, 32] -> [b, 50, 32]
        y = self.fc(y)

        return y

class Decoder(nn.Module):
    def __init__(self):
        super().__init__()
        self.layer_1 = DecoderLayer()
        self.layer_2 = DecoderLayer()
        self.layer_3 = DecoderLayer()

    def forward(self, x, y, mask_pad_x, mask_triangle_y):
        y = self.layer_1(x, y, mask_pad_x, mask_triangle_y)
        y = self.layer_2(x, y, mask_pad_x, mask_triangle_y)
        y = self.layer_3(x, y, mask_pad_x, mask_triangle_y)
        return y

class Transformer(nn.Module):
    def __init__(self):
        super().__init__()
        self.embed_x = PositionalEncoding(vocab_x_size)
        self.embed_y = PositionalEncoding(vocab_y_size)
        self.encoder = Encoder()
        self.decoder = Decoder()
        self.fc_out = nn.Linear(DIMENSION, vocab_y_size)

    def forward(self, x, y):
        # 掩码 [b, 1, 50, 50]
        mask_pad_x = mask_pad(x)
        mask_triangle_y = mask_triangle(y)

        # 编码，添加位置信息
        # x [b, 50] -> [b, 50, 32]
        # y [b, 50] -> [b, 50, 32]
        x = self.embed_x(x)
        y = self.embed_y(y)

        # encoder  [b, 50, 32] -> [b, 50, 32]
        x = self.encoder(x, mask_pad_x)

        # decoder  [b, 50, 32] -> [b, 50, 32]
        y = self.decoder(x, y, mask_pad_x, mask_triangle_y)
        
        # 全连接输出 [b, 50, 32] -> [b, 50, 39]
        y = self.fc_out(y)

        return y