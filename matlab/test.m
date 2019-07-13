%% MNIST数据读取与保存.
clc;
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);
if isempty(Train)
    return
end

%% 加载网络
if exist('Matrix1.mat', 'file') && exist('Matrix2.mat', 'file')
    load('Matrix1.mat');
    load('Matrix2.mat');
end

%% 测试
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
        fprintf('该图片为数字[%g],准确度%g\n', p, s);
    end
end

set(gcf, 'Position', get(0,'ScreenSize'));
