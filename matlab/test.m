%% MNIST���ݶ�ȡ�뱣��.
clc;
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);
if isempty(Train) || isempty(Label)
    return
end

%% ��������
if exist('Matrix1.mat', 'file') && exist('Matrix2.mat', 'file')
    load('Matrix1.mat');
    load('Matrix2.mat');
else
    fprintf('File [Matrix1.mat] or [Matrix2.mat] does not exist.\n');
    return
end

%% ����
k = 8;
n = randperm(size(Train, 2), k * k);
count = 1;

figure;
for i = 1:k
    for j = 1:k
        subplot(k, k, count);
        [s, p] = Pred(A1, A2, Show(Train, n(count)));
        xlabel(num2str(p));
        ylabel(num2str(s));
        count = count + 1;
        fprintf('��ͼƬΪ����[%g],׼ȷ��%g\n', p, s);
    end
end

set(gcf, 'Position', get(0,'ScreenSize'));
