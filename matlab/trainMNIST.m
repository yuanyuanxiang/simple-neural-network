% trainMNIST:
% 输入层：手写数字28*28个神经元
% 隐藏层：n个神经元，假设n=28
% 输出层：10个神经元，代表输入的图片属于是哪个数字
% 网络：Out = Sigmoid(A2 * Sigmoid(A1*In))

clear;clc;
%% MNIST数据读取与保存.
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);
if isempty(Train)
    return
end

sz = size(Train, 1);
n = 28;
t = size(Label, 1);

%{
sz = 2;
n = 2;
t = 2;
Train = [0.05, 0.10]';
Label = [0.01, 0.99]';
%}

%% 初始值
alpha = 1e-2; % 学习率
iter = 40; % 迭代次数
b1 = 0.35; b2 = 0.60;
if exist('Matrix1.mat', 'file') && exist('Matrix2.mat', 'file')
    load('Matrix1.mat');
    load('Matrix2.mat');
    if exist('Loss.mat', 'file')
        load('Loss.mat');
    else
        Loss = [];
    end
else
    A1 = [ones(n, 1), rand(n, sz)] - 0.5;
    A2 = [ones(t, 1), rand(t, n)] - 0.5;
    Loss = [];
end

%profile on;
%profile clear;
%% 开始迭代
num = size(Train, 2);
errs = zeros(1, iter);
for i = 1:iter
    tic;
    % 总误差
    total = 0;
    for k = 1 : num % 遍历元素
        In = Train(:, k);
        Out = Label(:, k);
        % 前向传播
        middle = reLU(A1 * [1; In]); % 中间层/隐藏层
        output = reLU(A2 * [1; middle]); % 输出层
        
        B1=A1; B2=A2;
        % BP-误差反向传播
        err1 = output - Out;
        diff = (err1 .* Grad(output)) * middle';
        B2(:, 2:end) = A2(:, 2:end) - alpha * diff;
        
        err2 = B2(:, 2:end)' * err1;
        diff = (err2 .* Grad(middle)) * In';
        B1(:, 2:end) = A1(:, 2:end) - alpha * diff;
        
        A1=B1; A2=B2;
        total = total + norm(err1);
    end
    errs(i) = total / num;
    fprintf('i=%g err=%g using=%gs rate=%g\n', i, errs(i), toc, alpha);
end
%% 更新网络权重和残差
save('Matrix1.mat','A1');
save('Matrix2.mat','A2');
Loss = [Loss, errs];
save('Loss.mat','Loss');
plot(Loss);
%profile viewer;
