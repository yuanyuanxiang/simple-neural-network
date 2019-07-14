% trainMNIST:
% ����㣺��д����28*28����Ԫ
% ���ز㣺n����Ԫ������n=28
% ����㣺10����Ԫ�����������ͼƬ�������ĸ�����
% ���磺Out = Sigmoid(A2 * Sigmoid(A1*In))
% Ԭ���飬2019-7

clear;clc;
%% MNIST���ݶ�ȡ�뱣��.
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

% ������Ԫ����
sz = size(Train, 1);    %��һ����Ԫ����
n = 28;                 %�ڶ�����Ԫ����
m = size(Label, 1);     %��������Ԫ����

%{
% һ���򵥵Ĳ������ݣ��Ա���Ŀpython��������
sz = 2;
n = 2;
m = 2;
Train = [0.05, 0.10]';
Label = [0.01, 0.99]';
Test = [];
Tag = [];
%}

%% ��ʼֵ
alpha = 1e-2; % ��ʼѧϰ��
iter = 1000; % ��������
[A1, A2, Loss] = TrainRecovery(sz, n, m);% �ָ�ѵ��
start = size(Loss, 2);
fprintf('�ӵ�[%g]����ʼ����.\n', start);
p = alpha * 0.99^start;
lr = p * 0.99.^(0:iter); % ѧϰ�����������˥��
b1 = 0.35; b2 = 0.60; % ƫ����

%profile on;
%profile clear;
%% ��ʼ����
num = size(Train, 2);
% ��һ�д�����ڶ������д��׼ȷ��
errs = zeros(3, iter);
for i = 1:iter
    tic;
    alpha = lr(i);
    % �����
    total = zeros(m, num);
    for k = 1 : num % ����Ԫ��
        In = Train(:, k);
        Out = Label(:, k);
        % ǰ�򴫲�
        middle = reLU(A1 * [1; In]); % �м��/���ز�
        output = reLU(A2 * [1; middle]); % �����
        err = output - Out;
        
        B1=A1; B2=A2;
        % BP-���򴫲�
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
    % ����Ȩ��
    if t >= 0
        Loss = SaveResult(A1, A2, Loss, errs, i, 10);
    end
    fprintf('%g err=%g lr=%g acc=%g %g use %gs\n',i+start,e,alpha,s,t,toc);
end
%profile viewer;
