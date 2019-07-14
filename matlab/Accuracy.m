function s = Accuracy(A1, A2, Test, Tag)
%% 计算准确率
% A1:第一层网络参数（输入层和隐藏层之间的权值）
% A2:第二层网络参数（隐藏层和输出层之间的权值）
% Test:数据集
% Tag:数据集标签
% 网络：Out = Sigmoid(A2 * Sigmoid(A1*In))

if isempty(Test) || isempty(Tag)
    s = -1;
    return
end

num = size(Test, 2);
Hidden = reLU(A1 * [ones(1, num); Test]);
Output = reLU(A2 * [ones(1, size(Hidden, 2)); Hidden]);
[~, p] = max(Output);
[~, tag] = max(Tag);
s = sum(p == tag);
s = s / num;
