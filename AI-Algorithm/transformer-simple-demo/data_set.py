import numpy as np
import torch
from torch.utils import data
from hyper_param import *


# 源语句词汇表
vocab_x_str = '<SOS>,<EOS>,<PAD>,0,1,2,3,4,5,6,7,8,9,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m'
vocab_x_list = vocab_x_str.split(',')
vocab_x_size = len(vocab_x_list)
vocab_x = {word: i for i, word in enumerate(vocab_x_list)}

# 目标语句词汇表
vocab_y_str = vocab_x_str.upper()
vocab_y_list = vocab_y_str.split(',')
vocab_y_size = len(vocab_y_list)
vocab_y = {word: i for i, word in enumerate(vocab_y_list)}


def get_data():
    # 自定义每个词的采样概率
    choice_words = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
    choice_words_probability = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])
    choice_words_probability = choice_words_probability / choice_words_probability.sum()

    # 每个sequence随机选n个词 (25 <= n < 49)，replace=True 表示可以重复选同一个词
    n = np.random.randint(SEQ_LEN // 2, SEQ_LEN - 1)
    x = np.random.choice(choice_words, size=n, replace=True, p=choice_words_probability)
    x = x.tolist()

    # y是对x变换得到的 (字母大写，数字取与9互补数，重复最后一位后逆序，所以y的长度会比x多一位)
    def f(i):
        i = i.upper()
        if not i.isdigit():
            return i
        i = 9 - int(i)
        return str(i)
    y = [f(i) for i in x]
    y = y + [y[-1]]
    y = y[::-1]

    # 添加首尾标志符号，补齐pad (x长度固定为50，y长度固定为51)
    x = ['<SOS>'] + x + ['<EOS>']
    y = ['<SOS>'] + y + ['<EOS>']
    x = x + ['<PAD>'] * SEQ_LEN
    y = y + ['<PAD>'] * (SEQ_LEN + 1)
    x = x[:SEQ_LEN]
    y = y[:SEQ_LEN + 1]

    # 编码成最终数据(整数索引)
    x = torch.LongTensor([vocab_x[word] for word in x])
    y = torch.LongTensor([vocab_y[word] for word in y])

    return x, y


# 定义数据集 (注意：里面并不是真的保存了10万条数据，而是每次被访问时才调用get_data()实时生成数据)
class DataSet(data.Dataset):
    def __init__(self):
        super().__init__()
    def __len__(self):
        return 100000
    def __getitem__(self, idx):
        return get_data()


"""
数据加载器 (每次取8个数据，使用 for x,y in data_loader 的方式访问即可)
- x 形状为 [8, 50]
- y 形状为 [8, 51]
- shuffle=True 表示每轮训练前把数据顺序彻底打乱
- drop_last=True 表示如果最后剩下不足 8 个数据则直接丢掉
- collate_fn=None 表示用 PyTorch 默认方式把数据打包成 batch，也就是自动把多条数据拼成 [batch_size, ...] 的张量
"""
data_loader = data.DataLoader(dataset=DataSet(), batch_size=BATCH_SIZE, shuffle=True, drop_last=True, collate_fn=None)


if __name__ == '__main__':
    print(f'vocab_x_list: {vocab_x_list}')
    print(f'vocab_x: {vocab_x}')
    print(f'vocab_y_list: {vocab_y_list}')
    print(f'vocab_y: {vocab_y}')
    for x, y in data_loader:
        print(f'x: {x}')
        print(f'y: {y}')
        print(f'x.shape: {x.shape}')
        print(f'y.shape: {y.shape}')
        break