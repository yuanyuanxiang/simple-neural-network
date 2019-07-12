% train
% 输入层：手写数字28*28个神经元
% 隐藏层：n个神经元，假设n=28
% 输出层：10个神经元，代表输入的图片属于是哪个数字

clear;clc;
% MNIST数据读取与保存.
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);


sz = size(Train, 2);
n = 28;
t = size(Label, 2);

%{
sz = 2;
n = 2;
t = 2;
Train = [0.05, 0.10];
Label = [0.01, 0.99];
%}

% 初始值
alpha = 1e-7;
b1 = 0.35; b2 = 0.60;
A1=[ones(n, 1), rand(n, sz)] - 0.5;
A2=[ones(t, 1), rand(t, n)] - 0.5;
num = size(Train, 1);
for i = 1:100
    tic;
    for j = 1 : num
        In = Train(j, :)';
        Out = Label(j, :)';
        % 前向传播
        middle = reLU(A1 * [1; In]);
        output = reLU(A2 * [1; middle]);

        % 反向传播
        B1=A1; B2=A2;

        diff = (output-Out) .* Grad(output) * middle';
        B2(:, 2:end) = A2(:, 2:end) - alpha * diff;

        s = (output-Out) .* Grad(output) * Grad(middle)';
        diff = sum(s)' * In';
        B1(:, 2:end) = A1(:, 2:end) - alpha * diff;

        A1=B1; A2=B2;
    end
    fprintf('i = %g, err=%g, using=%g\n', i, sqrt(norm(output-Out)), toc);
end
