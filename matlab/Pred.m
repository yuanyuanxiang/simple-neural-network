function [s, p] = Pred(A1, A2, M)
% 调用网络Out = Sigmoid(A2 * Sigmoid(A1*In))进行预测.
% 输入值A1,A2为网络权重，M为28*28的矩阵.
if isempty(M)
    s = [];
    p = [];
    return
end

In = reshape(M, 28*28, 1);
hidden = reLU(A1 * [1; In]);
r = reLU(A2 * [1; hidden]);
[s, p] = max(r);
p = p - 1;
fprintf('该图片为数字[%g],准确度%g\n', p, s);
end
