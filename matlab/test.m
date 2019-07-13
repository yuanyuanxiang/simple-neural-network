%% MNIST数据读取与保存.
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
k = 10;
i = randperm(size(Train, 2), k);
for j = 1:k
    figure(j);
    [s, p] = Pred(A1, A2, Show(Train, i(j)));
    xlabel(int2str(p));
end
