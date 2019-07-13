%% score: �����ģ���ڲ��Լ��ϵ�׼ȷ��.
clc;
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
num = size(Test, 2);
s = 0;
for i = 1:num
    In = Test(:, i);
    hidden = reLU(A1 * [1; In]);
    r = reLU(A2 * [1; hidden]);
    [~, p] = max(r);
    [~, tag] = max(Tag(:, i));
    if p == tag
        s = s + 1;
    end
end
fprintf('���Լ�������%g ׼ȷ�ʣ�%g.\n', num, s/num);
