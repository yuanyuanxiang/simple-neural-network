%% score: �����ģ���ڲ��Լ��ϵ�׼ȷ��.
clc;
train_file = '../data/train-images.idx3-ubyte';
label_file = '../data/train-labels.idx1-ubyte';
[Train, Label] = loadMNIST(train_file, label_file);
if isempty(Train) || isempty(Label)
    return
end
test_file = '../test/t10k-images.idx3-ubyte';
test_label = '../test/t10k-labels.idx1-ubyte';
[Test, Tag] = loadMNIST(test_file, test_label, true);
if isempty(Test) || isempty(Tag)
    return
end

%% ��������
if exist('Matrix1.mat', 'file') && exist('Matrix2.mat', 'file')
    load('Matrix1.mat');
    load('Matrix2.mat');
else
    fprintf('File [Matrix1.mat] or [Matrix2.mat] does not exist.\n');
    return
end
%% ����׼ȷ��
tic;
s = Accuracy(A1, A2, Train, Label);
fprintf('ѵ����׼ȷ�ʣ�%g using %gs.\n', s, toc);

tic;
s = Accuracy(A1, A2, Test, Tag);
fprintf('���Լ�׼ȷ�ʣ�%g using %gs.\n', s, toc);
