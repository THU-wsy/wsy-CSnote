import os
import numpy as np
import torch
from torch import nn

from custom_data_set import data_loader, eval_data_loader, vocab_y, vocab_y_size
from hyper_param import EPOCHS
from model import Transformer

# 固定随机种子，保证实验可复现
torch.manual_seed(42)
np.random.seed(42)

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")


@torch.no_grad()
def evaluate(model, n_batches=50):
    """在 n_batches 个新鲜 batch 上用独立的 eval_data_loader 算 token 准确率"""
    correct, total = 0, 0
    for i, (x, y) in enumerate(eval_data_loader):
        if i >= n_batches:
            break
        x, y = x.to(device), y.to(device)
        logits = model(x, y[:, :-1])
        label = y[:, 1:]
        select = label != vocab_y['<PAD>']
        pred = logits.argmax(2)[select]
        gold = label[select]
        correct += (pred == gold).sum().item()
        total += len(pred)
    return correct / total


def main():
    print('device:', device)

    model = Transformer().to(device)
    # ignore_index自动忽略标签中的PAD位置，只对有效 token 计算损失
    loss_func = nn.CrossEntropyLoss(ignore_index=vocab_y['<PAD>'])
    optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)
    scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=3, gamma=0.5)

    # 模型保存到脚本所在目录（绝对路径）
    model_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'model.pth')

    best_acc = 0.0
    for epoch in range(EPOCHS):
        for i, (x, y) in enumerate(data_loader):
            # x [8, 50]   y [8, 100]
            x, y = x.to(device), y.to(device)

            # 训练时，decode是拿y的每个token，预测下一个token，所以不需要y的最后一个token（y的最后一个token只在计算损失时用到）
            # logits [8, 99, vocab_y_size]
            logits = model(x, y[:, :-1])

            # reshape 便于计算损失
            # 预测值 [8×99, vocab_y_size]  标签 [8×99]
            # 注意：标签y中的第0个token要剔除，因为预测的是第1~99个token
            logits = logits.reshape((-1, vocab_y_size))
            label = y[:, 1:].reshape(-1)

            loss = loss_func(logits, label)
            optimizer.zero_grad()
            loss.backward()
            # 梯度裁剪，防止训练不稳定
            nn.utils.clip_grad_norm_(model.parameters(), 1.0)
            optimizer.step()

            if (i % 200) == 0:
                # 训练token准确率（只统计非PAD位置）
                select = label != vocab_y['<PAD>']
                accuracy = (logits.argmax(1)[select] == label[select]).float().mean().item()
                lr = optimizer.param_groups[0]['lr']
                print(f'epoch={epoch}\t i={i:5d}\t lr={lr}\t loss={loss.item():.4f}\t accuracy={accuracy:.4f}')

        # 每个epoch结束后验证，保存最优模型（eval模式关闭dropout，验证完切回train）
        model.eval()
        val_acc = evaluate(model)
        model.train()
        print(f'epoch {epoch} done, val_acc = {val_acc:.4f}')
        if val_acc > best_acc:
            best_acc = val_acc
            torch.save(model.state_dict(), model_path)
            print(f'best model saved to {model_path}')

        scheduler.step()

    print(f'training finished, best val_acc = {best_acc:.4f}')


if __name__ == '__main__':
    main()
