function [A1, A2, Loss] = LoadNN(s1, s3)
%% ��������������.
% s1,s2,s3: ������Ԫ�ĸ���.
% s1Ϊ����,s3Ϊ���,s2Ϊ���ز�.
% ��������Ȩ��A1, A2 �� Loss.

m1 = dir('Matrix1_s*.mat');
m2 = dir('Matrix2_s*.mat');
if s1 > 2 && ~isempty(m1) && ~isempty(m2)
    % ������ѵ����������
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
