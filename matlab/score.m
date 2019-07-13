%% score: 计算该模型在测试集上的准确率.
clc;
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
num = size(Test, 2);
s = 0;
for i = 1:num
    In = Test(:, i);
    hidden = reLU(A1 * [1; In]);
    r = reLU(A2 * [1; hidden]);
    [~, p] = max(r);
    [~, tag] = max(Tag(:, i));
    if p == tag
        s = s + 1;
    end
end
fprintf('测试集个数：%g 准确率：%g.\n', num, s/num);
