from model import *
from mask import *
from data_set import *

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = Transformer()
model.load_state_dict(torch.load('./model.pth', map_location=device))
model.to(device)
model.eval()  # 推理模式


def predict(x):
    with torch.no_grad():
        # x [1, 50]
        x = x.to(device)

        # [1, 1, 50, 50]
        mask_pad_x = mask_pad(x)

        # 初始化目标序列 <SOS> 开头 [[0, 2, 2, 2, ...]]  形状 [1, 51]
        target = [vocab_y['<SOS>']] + [vocab_y['<PAD>']] * SEQ_LEN
        target = torch.LongTensor(target).unsqueeze(0).to(device)

        # encoder 得到 [1, 50, 32]
        x = model.embed_x(x)
        x = model.encoder(x, mask_pad_x)

        # 循环生成第1个词到第50个词，注意第0个词已经初始化为<SOS>
        # i=0时，根据target的第0个词<SOS>进行预测，输出out的第0个词就是预测的词，将它填入target的第1个词进行下一步预测
        # i=1时，根据target的第0、1个词进行预测，输出out的第1个词就是预测的词，将它填入target的第2个词进行下一步预测
        # i=49时，根据target的第0、1、...、49个词进行预测，输出out的第49个词就是预测的词，将它填入target的第50个词后终止
        for i in range(SEQ_LEN):
            # [1, 50]
            y = target[:, :-1]

            # [1, 1, 50, 50]
            mask_triangle_y = mask_triangle(y)

            # decoder 得到 [1, 50, 32]
            y = model.embed_y(y)
            y = model.decoder(x, y, mask_pad_x, mask_triangle_y)

            # 全连接输出，39分类 [1, 50, 32] -> [1, 50, 39]
            out = model.fc_out(y)

            # 取出当前词的输出 [1, 50, 39] -> [1, 39]
            out = out[:, i, :]

            # 取出分类结果 [1, 39] -> [1]
            out = out.argmax(dim=1).detach()

            # 以当前词预测下一个词，填到结果中
            target[:, i + 1] = out

            if out.item() == vocab_y['<EOS>']:
                break

        return target


if __name__ == '__main__':
    x_test, y_test = None, None
    for i, (x, y) in enumerate(data_loader):
        x_test = x
        y_test = y
        break

    for i in range(BATCH_SIZE):
        print('=' * 50)
        print(f'输入：', ''.join([vocab_x_list[j] for j in x_test[i].tolist()]))
        print(f'真实：', ''.join([vocab_y_list[j] for j in y_test[i].tolist()]))
        # 预测
        pred = predict(x_test[i].unsqueeze(0))
        pred = pred.cpu().numpy()[0]  # 转回CPU
        print(f'预测：', ''.join([vocab_y_list[j] for j in pred]))