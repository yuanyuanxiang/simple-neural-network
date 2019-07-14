function s = Accuracy(A1, A2, Test, Tag)
%% ����׼ȷ��
% A1:��һ��������������������ز�֮���Ȩֵ��
% A2:�ڶ���������������ز�������֮���Ȩֵ��
% Test:���ݼ�
% Tag:���ݼ���ǩ
% ���磺Out = Sigmoid(A2 * Sigmoid(A1*In))

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
