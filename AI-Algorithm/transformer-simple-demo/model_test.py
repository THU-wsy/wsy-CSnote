import os
import torch

from custom_data_set import BATCH_SIZE, eval_data_loader, vocab_x_list, vocab_y, vocab_y_list
from hyper_param import SEQ_LEN_Y
from mask import mask_pad
from model import Transformer

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")


def predict(model, x):
    """
    带KV cache的增量解码：每步只算新token的前向，不重算整个decoder（复杂度O(n)而非O(n²)）
    - encoder：输入固定，整个解码过程只跑一次
    - 自注意力：通过state累积历史K/V，新token只算自己的K/V并追加
    - 交叉注意力：K/V始终用encoder输出（固定），每步直接用，无需缓存
    训练和预测共用同一个decoder.forward，由state是否为None区分全量/增量路径
    """
    with torch.no_grad():
        # x [1, 50]
        x_ids = x.to(device)

        # encoder自注意力用的pad掩码 [1, 1, 50, 50]
        mask_pad_x = mask_pad(x_ids)

        # encoder 只算一次，得到 [1, 50, 32]
        x = model.encoder(model.pos(model.embed_x(x_ids)), mask_pad_x)

        # decoder交叉注意力用的pad掩码：Q是单步新token（q_len=1），K/V是x，形状 [1, 1, 1, 50]
        mask_cross = mask_pad(x_ids, q_len=1)

        # state：每层一个空dict，预测时逐层累积自注意力的K/V缓存
        state = [{} for _ in model.decoder.layers]

        # 自回归生成：第0个词<SOS>已作为初始token，循环最多生成SEQ_LEN_Y-1个词
        # 第i步：新token带着自己的位置编码进入decoder，输出softmax后得到下一个词
        token = vocab_y['<SOS>']
        outputs = [token]
        for i in range(SEQ_LEN_Y - 1):
            # 新token的词向量 [1, 1, 32]，加上位置i的编码（pos_offset=i）
            pos = torch.tensor([[token]], dtype=torch.long, device=device)
            y_new = model.pos(model.embed_y(pos), pos_offset=i)

            # decoder自注意力掩码：第i个词能看到第0~i个词；这些都是<SOS>或生成出的非pad词，所以全部可见。
            mask_self = torch.zeros(1, 1, 1, i + 1, dtype=torch.bool, device=device)

            # decoder增量一步（state非None触发KV cache路径）[1, 1, 32]
            dec = model.decoder(x, y_new, mask_cross, mask_self, state)

            # 全连接输出 [1, 1, 32] -> [1, 1, vocab_y_size]，取最后一位（即当前步）的分类结果
            token = model.fc_out(dec)[:, -1, :].argmax(dim=1).item()
            outputs.append(token)

            if token == vocab_y['<EOS>']:
                break

        # 预测结果是变长的（遇<EOS>即止），无需补pad对齐
        return torch.tensor(outputs, dtype=torch.long)


def main():
    model = Transformer()
    # 从脚本所在目录加载模型（绝对路径），与model_train.py的保存位置对应
    model_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'model.pth')
    model.load_state_dict(torch.load(model_path, map_location=device, weights_only=True))
    model.to(device)
    model.eval()  # 推理模式

    # 取一个batch的验证数据
    x_test, y_test = next(iter(eval_data_loader))

    for i in range(BATCH_SIZE):
        print('=' * 50)
        print('输入：', ''.join([vocab_x_list[j] for j in x_test[i].tolist()]))
        print('真实：', ''.join([vocab_y_list[j] for j in y_test[i].tolist()]))
        pred = predict(model, x_test[i].unsqueeze(0)).cpu().numpy()
        print('预测：', ''.join([vocab_y_list[j] for j in pred]))


if __name__ == '__main__':
    main()
