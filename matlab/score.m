%% score: 计算该模型在测试集上的准确率.
clc;
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

%% 加载网络
if exist('Matrix1.mat', 'file') && exist('Matrix2.mat', 'file')
    load('Matrix1.mat');
    load('Matrix2.mat');
else
    fprintf('File [Matrix1.mat] or [Matrix2.mat] does not exist.\n');
    return
end
%% 计算准确率
tic;
s = Accuracy(A1, A2, Train, Label);
fprintf('训练集准确率：%g using %gs.\n', s, toc);

tic;
s = Accuracy(A1, A2, Test, Tag);
fprintf('测试集准确率：%g using %gs.\n', s, toc);
