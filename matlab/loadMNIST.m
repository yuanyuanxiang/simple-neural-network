function [Train, Label] = loadMNIST(train_file, label_file)
% MNIST���ݶ�ȡ�뱣��.
% train_file = '../data/train-images.idx3-ubyte';
% label_file = '../data/train-labels.idx1-ubyte';
% ����ʱ������ת�ã��������ÿһ����һ�����.

if ~exist('train-images.mat', 'file')
    FID = fopen(train_file,'r');
    if FID == -1
        Train = [];
        Label = [];
        fprintf('File [%s] does not exist.\n', train_file);
        return
    end
    MagicNumber=readint32(FID);
    NumberofImages=readint32(FID);
    rows=readint32(FID);
    colums=readint32(FID);
    
    Train = zeros(NumberofImages,rows*colums);
    for i = 1:NumberofImages
        temp = fread(FID,(rows*colums), 'uchar');
        Train(i,:) = temp';
    end
    Train = Train';
    save('train-images.mat','Train');
else
    load('train-images.mat');
end

if ~exist('train-labels.mat', 'file')
    FID = fopen(label_file,'r');
    if FID == -1
        Train = [];
        Label = [];
        fprintf('File [%s] does not exist.\n', label_file);
        return
    end
    MagicNumber=readint32(FID);
    NumberofImages=readint32(FID);
    
    Label = zeros(NumberofImages,10);
    for i = 1:NumberofImages
        temp = fread(FID,1);
        Label(i,temp+1) = 1;
    end
    Label = Label';
    save('train-labels.mat','Label');
else
    load('train-labels.mat');
end
end

function [getdata]=readint32(FID)

data = [];
for i = 1:4
    f=fread(FID,1);
    data = strcat(data,num2str(dec2base(f,2,8)));
end
getdata = bin2dec(data);

end

%{
���ߣ���̩ɽ
��Դ��CSDN
ԭ�ģ�https://blog.csdn.net/u010936286/article/details/80667138
��Ȩ����������Ϊ����ԭ�����£�ת���븽�ϲ������ӣ�
%}