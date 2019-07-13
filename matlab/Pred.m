function [s, p] = Pred(A1, A2, M)
% ��������Out = Sigmoid(A2 * Sigmoid(A1*In))����Ԥ��.
% ����ֵA1,A2Ϊ����Ȩ�أ�MΪ28*28�ľ���.
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
fprintf('��ͼƬΪ����[%g],׼ȷ��%g\n', p, s);
end
