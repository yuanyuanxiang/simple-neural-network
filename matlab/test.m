%% MNIST数据读取与保存.
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
[A1, A2, Loss] = LoadNN(28*28, 10);
if isempty(A1)
    return;
end

%% 测试
k = 8;
if datenum(version('-date')) > datenum('Jan 01, 2013')
    n = randperm(size(Test, 2), k * k);
else
    a = randperm(size(Test, 2));
    n = a(1 : (k * k));
end
count = 1;
right = 0;

figure;
for i = 1:k
    for j = 1:k
        subplot(k, k, count);
        In = Test(:, n(count));
        hidden = reLU(A1 * [1; In]);
        Out = reLU(A2 * [1; hidden]);
        [s, p] = max(Out);
        p = p - 1;
        fprintf('图片%g为数字[%g],准确度%g\n', n(count), p, s);
        [a, tag] = max(Tag(:, n(count)));
        imshow(reshape(In, 28, 28));
        if tag-1 == p
            xlabel(num2str(p));
            ylabel(num2str(s));
            right = right + 1;
        else
            xlabel(num2str(p), 'Color', 'r');
            ylabel(num2str(s), 'Color', 'r');
        end
        count = count + 1;
    end
end
fprintf('一共%g个图片，预测正确个数：%g\n', k*k, right);
set(gcf, 'Position', get(0,'ScreenSize'));

%% 计算准确率
tic;
s = Accuracy(A1, A2, Train, Label);
fprintf('训练集准确率：%g using %gs.\n', s, toc);

tic;
s = Accuracy(A1, A2, Test, Tag);
fprintf('测试集准确率：%g using %gs.\n', s, toc);
