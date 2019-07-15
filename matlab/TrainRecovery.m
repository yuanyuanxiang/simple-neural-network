function [A1, A2, Loss] = TrainRecovery(s1, s2, s3)
%% �ָ�֮ǰ�Ľ�������Ž���ѵ�������߼�������������.
% s1,s2,s3: ������Ԫ�ĸ���.
% s1Ϊ����,s2Ϊ���ز�,s3Ϊ���.
% ��������Ȩ��A1, A2 �� Loss.

if datenum(version('-date')) > datenum('Jan 01, 2013')
    assert(nargin == 3);
end

[A1, A2, Loss] = LoadNN(s1, s3);

if isempty(A1) || isempty(A2)
    % ��ͷ��ʼѵ��
    A1 = [ones(s2, 1), rand(s2, s1)] - 0.5;
    A2 = [ones(s3, 1), rand(s3, s2)] - 0.5;
    Loss = [];
end
end
