function [A1, A2, Loss] = LoadNN(s1, s3)
%% 加载现有神经网络.
% s1,s2,s3: 各层神经元的个数.
% s1为输入,s3为输出,s2为隐藏层.
% 返回网络权重A1, A2 和 Loss.

m1 = dir('Matrix1_s*.mat');
m2 = dir('Matrix2_s*.mat');
if s1 > 2 && ~isempty(m1) && ~isempty(m2)
    % 加载已训练的神经网络
    load(m1(end).name);
    load(m2(end).name);
    if datenum(version('-date')) > datenum('Jan 01, 2013')
        assert((size(A1,2)==(s1+1)) && (size(A2,1)==s3));
    end
    fprintf('Load [%s] and [%s] succeed.\n', m1(end).name, m2(end).name);
    if exist('Loss.mat', 'file')
        load('Loss.mat');
    else
        Loss = [];
    end
else
    fprintf('Load Neural Networks failed.\n');
    A1 = [];
    A2 = [];
    Loss = [];
end
end
