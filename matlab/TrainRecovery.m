function [A1, A2, Loss] = TrainRecovery(s1, s2, s3)
%% �ָ�֮ǰ�Ľ�������Ž���ѵ��.
% s1,s2,s3: ������Ԫ�ĸ���.
% ��������Ȩ��A1, A2 �� Loss.

m1 = dir('Matrix1_s*.mat');
m2 = dir('Matrix2_s*.mat');
if s1 == 28*28 && ~isempty(m1) && ~isempty(m2)
    % ����һ�εĽ������ѵ��
    load(m1(end).name);
    load(m2(end).name);
    fprintf('Load [%s] and [%s] succeed.\n', m1(end).name, m2(end).name);
    if exist('Loss.mat', 'file')
        load('Loss.mat');
    else
        Loss = [];
    end
else
    % ��ͷ��ʼѵ��
    A1 = [ones(s2, 1), rand(s2, s1)] - 0.5;
    A2 = [ones(s3, 1), rand(s3, s2)] - 0.5;
    Loss = [];
end
end
