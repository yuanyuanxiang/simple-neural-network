% train
% ����㣺��д����28*28����Ԫ
% ���ز㣺n����Ԫ������n=28
% ����㣺10����Ԫ�����������ͼƬ�������ĸ�����

clear;clc;
% MNIST���ݶ�ȡ�뱣��.
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

% ��ʼֵ
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
        % ǰ�򴫲�
        middle = reLU(A1 * [1; In]);
        output = reLU(A2 * [1; middle]);

        % ���򴫲�
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
