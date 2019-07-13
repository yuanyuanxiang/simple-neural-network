% train
% ����㣺��д����28*28����Ԫ
% ���ز㣺n����Ԫ������n=28
% ����㣺10����Ԫ�����������ͼƬ�������ĸ�����
% ���磺Out = Sigmoid(A2 * Sigmoid(A1*In))

clear;clc;
% MNIST���ݶ�ȡ�뱣��.
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

% ��ʼֵ
alpha = 1e-7; % ѧϰ��
iter = 30; % ��������
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
% ��ʼ����
num = size(Train, 2);
errs = zeros(1, iter);
for i = 1:iter
    tic;
    % ����Ԫ��
    total_err = 0;
    for j = 1 : num
        In = Train(:, j);
        Out = Label(:, j);
        % ǰ�򴫲�
        middle = reLU(A1 * [1; In]);
        output = reLU(A2 * [1; middle]);
        err = output-Out;
        total_err = total_err + norm(err);
        
        % ���򴫲�
        B1=A1; B2=A2;
        
        middle_t = middle';
        t = err .* Grad(output);
        diff = t * middle_t;
        B2(:, 2:end) = A2(:, 2:end) - alpha * diff;
        
        s = t * Grad(middle_t);
        diff = sum(s)' * In';
        B1(:, 2:end) = A1(:, 2:end) - alpha * diff;
        
        A1=B1; A2=B2;
    end
    errs(i) = sqrt(total_err) / num;
    fprintf('i = %g, err=%g, using=%gs\n', i, errs(i), toc);
end
% ��������Ȩ�غͲв�
save('Matrix1.mat','A1');
save('Matrix2.mat','A2');
Loss = [Loss, errs];
save('Loss.mat','Loss');
%profile viewer;