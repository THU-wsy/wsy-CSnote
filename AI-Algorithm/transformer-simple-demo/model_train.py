from model import *
from data_set import *
import torch
from torch import nn

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = Transformer().to(device)
loss_func = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(model.parameters(), lr=2e-3)
scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=3, gamma=0.5)

for epoch in range(1):
    for i, (x, y) in enumerate(data_loader):
        # x [8, 50]
        # y [8, 51]
        x, y = x.to(device), y.to(device)

        # 训练时，是拿y的每个字符，预测下一个字符，所以不需要y的最后一个字符
        # [8, 50, 39]
        predict: torch.Tensor = model(x, y[:, :-1])

        # reshape 便于计算损失
        # 预测值 [400, 39]  标签[400]
        # 注意：标签y中的第0个字符要剔除，因为预测的是第1~50个字符
        predict = predict.reshape((-1, vocab_y_size))
        y = y[:, 1:].reshape(-1)

        # 忽略pad
        select = y != vocab_y['<PAD>']
        predict = predict[select]
        y = y[select]

        loss = loss_func(predict, y)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if (i % 200) == 0:
            predict = predict.argmax(1)
            correct = (predict == y).sum().item()
            accuracy = correct / len(predict)
            lr = optimizer.param_groups[0]['lr']
            print(epoch, i, lr, loss.item(), accuracy)

    scheduler.step()

torch.save(model.state_dict(), './model.pth')