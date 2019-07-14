% trainMNIST:
% 输入层：手写数字28*28个神经元
% 隐藏层：n个神经元，假设n=28
% 输出层：10个神经元，代表输入的图片属于是哪个数字
% 网络：Out = Sigmoid(A2 * Sigmoid(A1*In))
% 袁沅祥，2019-7

clear;clc;
%% MNIST数据读取与保存.
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);
if isempty(Train) || isempty(Label)
    return
end
test_file = '../test/t10k-images.idx3-ubyte';
test_label = '../test/t10k-labels.idx1-ubyte';
[Test, Tag] = loadMNIST(test_file, test_label, true);
if isempty(Test) || isempty(Tag)
    return
end

% 各层神经元数量
sz = size(Train, 1);    %第一层神经元个数
n = 28;                 %第二层神经元个数
m = size(Label, 1);     %第三层神经元个数

%{
% 一个简单的测试数据：对本项目python问题的求解
sz = 2;
n = 2;
m = 2;
Train = [0.05, 0.10]';
Label = [0.01, 0.99]';
Test = [];
Tag = [];
%}

%% 初始值
alpha = 1e-2; % 初始学习率
iter = 1000; % 迭代次数
[A1, A2, Loss] = TrainRecovery(sz, n, m);% 恢复训练
start = size(Loss, 2);
fprintf('从第[%g]步开始迭代.\n', start);
p = alpha * 0.99^start;
lr = p * 0.99.^(0:iter); % 学习率随迭代次数衰减
b1 = 0.35; b2 = 0.60; % 偏置量

%profile on;
%profile clear;
%% 开始迭代
num = size(Train, 2);
% 第一行存放误差，第二、三行存放准确率
errs = zeros(3, iter);
for i = 1:iter
    tic;
    alpha = lr(i);
    % 总误差
    total = zeros(m, num);
    for k = 1 : num % 遍历元素
        In = Train(:, k);
        Out = Label(:, k);
        % 前向传播
        middle = reLU(A1 * [1; In]); % 中间层/隐藏层
        output = reLU(A2 * [1; middle]); % 输出层
        err = output - Out;
        
        B1=A1; B2=A2;
        % BP-误差反向传播
        err1 = err;
        diff = (err1 .* Grad(output)) * middle';
        B2(:, 2:end) = A2(:, 2:end) - alpha * diff;
        
        err2 = B2(:, 2:end)' * err1;
        diff = (err2 .* Grad(middle)) * In';
        B1(:, 2:end) = A1(:, 2:end) - alpha * diff;
        
        A1=B1; A2=B2;
        total(:, k) = err;
    end
    e = mean(sqrt(sum(total.*total)));
    s = Accuracy(A1, A2, Train, Label);
    t = Accuracy(A1, A2, Test, Tag);
    errs(1, i) = e; errs(2, i) = s; errs(3, i) = t;
    % 保存权重
    if t >= 0
        Loss = SaveResult(A1, A2, Loss, errs, i, 10);
    end
    fprintf('%g err=%g lr=%g acc=%g %g use %gs\n',i+start,e,alpha,s,t,toc);
end
%profile viewer;
