%% MNIST数据读取与保存.
clc;
test_file = '../test/t10k-images.idx3-ubyte';
test_label = '../test/t10k-labels.idx1-ubyte';
[Test, Tag] = loadMNIST(test_file, test_label, true);
if isempty(Test) || isempty(Tag)
    return
end

%% 加载网络
[A1, A2, Loss] = LoadNN(28*28, 10);

%% 测试
k = 8;
n = randperm(size(Test, 2), k * k);
count = 1;
right = 0;

figure;
for i = 1:k
    for j = 1:k
        subplot(k, k, count);
        [s, p] = Pred(A1, A2, Show(Test, n(count)));
        xlabel(num2str(p));
        ylabel(num2str(s));
        fprintf('图片%g为数字[%g],准确度%g\n', n(count), p, s);
        [~, tag] = max(Tag(:, n(count)));
        if tag-1 == p
            right = right + 1;
        end
        count = count + 1;
    end
end
fprintf('一共%g个图片，预测正确个数：%g\n', k*k, right);
set(gcf, 'Position', get(0,'ScreenSize'));
