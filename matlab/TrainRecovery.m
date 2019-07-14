function [A1, A2, Loss] = TrainRecovery(s1, s2, s3)
%% 恢复之前的结果，接着进行训练.
% s1,s2,s3: 各层神经元的个数.
% 返回网络权重A1, A2 和 Loss.

m1 = dir('Matrix1_s*.mat');
m2 = dir('Matrix2_s*.mat');
if s1 == 28*28 && ~isempty(m1) && ~isempty(m2)
    % 从上一次的结果继续训练
    load(m1(end).name);
    load(m2(end).name);
    fprintf('Load [%s] and [%s] succeed.\n', m1(end).name, m2(end).name);
    if exist('Loss.mat', 'file')
        load('Loss.mat');
    else
        Loss = [];
    end
else
    % 从头开始训练
    A1 = [ones(s2, 1), rand(s2, s1)] - 0.5;
    A2 = [ones(s3, 1), rand(s3, s2)] - 0.5;
    Loss = [];
end
end
