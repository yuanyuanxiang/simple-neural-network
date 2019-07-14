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
[A1, A2, Loss] = LoadNN(28*28, 10);

%% ����׼ȷ��
tic;
s = Accuracy(A1, A2, Train, Label);
fprintf('ѵ����׼ȷ�ʣ�%g using %gs.\n', s, toc);

tic;
s = Accuracy(A1, A2, Test, Tag);
fprintf('���Լ�׼ȷ�ʣ�%g using %gs.\n', s, toc);
