function [Train, Label] = loadMNIST(train_file, label_file)
% MNIST数据读取与保存.
% train_file = '../data/train-images.idx3-ubyte';
% label_file = '../data/train-labels.idx1-ubyte';

if ~exist('train.mat')
    FID = fopen(train_file,'r');
    if FID == -1
        Train = []
        Label = []
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
    save('train.mat','Train')
else
    load('train.mat')
end

if ~exist('Label.mat')
    FID = fopen(label_file,'r');
    if FID == -1
        Train = []
        Label = []
        return
    end
    MagicNumber=readint32(FID);
    NumberofImages=readint32(FID);

    Label = zeros(NumberofImages,10);
    for i = 1:NumberofImages
        temp = fread(FID,1);
        Label(i,temp+1) = 1;
    end
    save('label.mat','Label')
else
    load('Label.mat')
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
作者：东泰山
来源：CSDN
原文：https://blog.csdn.net/u010936286/article/details/80667138
版权声明：本文为博主原创文章，转载请附上博文链接！
%}