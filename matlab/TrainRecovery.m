function [A1, A2, Loss] = TrainRecovery(s1, s2, s3)
%% 恢复之前的结果，接着进行训练；或者加载现有神经网络.
% s1,s2,s3: 各层神经元的个数.
% s1为输入,s2为隐藏层,s3为输出.
% 返回网络权重A1, A2 和 Loss.

if datenum(version('-date')) > datenum('Jan 01, 2013')
    assert(nargin == 3);
end

[A1, A2, Loss] = LoadNN(s1, s3);

if isempty(A1) || isempty(A2)
    % 从头开始训练
    A1 = [ones(s2, 1), rand(s2, s1)] - 0.5;
    A2 = [ones(s3, 1), rand(s3, s2)] - 0.5;
    Loss = [];
end
end
