function [Train, Label] = loadMNIST(train_file, label_file, force)
% MNIST���ݶ�ȡ�뱣��.
% train_file = '../data/train-images.idx3-ubyte';
% label_file = '../data/train-labels.idx1-ubyte';
% ����ʱ������ת�ã��������ÿһ����һ�����.
% �����3����������forceΪtrue����ǿ�ƴ��ļ���ȡ����.
% �ú����ο��˻����������д��룬���������Դ��δָ����������.

if nargin < 3
    force = false;
end

if ~exist('train-images.mat', 'file') || force
    FID = fopen(train_file, 'rb');
    if FID == -1
        Train = [];
        Label = [];
        fprintf('File [%s] does not exist.\n', train_file);
        return
    end
    magic = fread(FID, 1, 'int32', 0, 'ieee-be');
    assert(magic == 2051, ['Bad magic number in ', train_file, '']);
    
    numImages = fread(FID, 1, 'int32', 0, 'ieee-be');
    numRows = fread(FID, 1, 'int32', 0, 'ieee-be');
    numCols = fread(FID, 1, 'int32', 0, 'ieee-be');
    
    Train = fread(FID, inf, 'unsigned char');
    Train = reshape(Train, numCols, numRows, numImages);
    Train = permute(Train,[2 1 3]);
    
    fclose(FID);
    % Reshape to #pixels x #examples
    Train = reshape(Train, size(Train, 1) * size(Train, 2), size(Train, 3));
    % Convert to double and rescale to [0,1]
    % https://blog.csdn.net/weixin_41503009/article/details/83420189
    Train = double(Train) * (0.999 / 255) + 0.001;
    if ~force
        save('train-images.mat', 'Train');
    end
else
    % �Ѵ���mat��ʽ�ļ�����ֱ�Ӽ���
    load('train-images.mat');
end

if ~exist('train-labels.mat', 'file') || force
    FID = fopen(label_file,'r');
    if FID == -1
        Train = [];
        Label = [];
        fprintf('File [%s] does not exist.\n', label_file);
        return
    end
    magic=readint32(FID);
    assert(magic == 2049, ['Bad magic number in ', train_file, '']);
    NumberofImages=readint32(FID);
    assert(NumberofImages == size(Train, 2));
    Label = zeros(NumberofImages,10);
    for i = 1:NumberofImages
        temp = fread(FID,1);
        Label(i,temp+1) = 1;
    end
    
    fclose(FID);
    Label = Label';
    Label(Label==0) = 0.001;
    if ~force
        save('train-labels.mat','Label');
    end
else
    % �Ѵ���mat��ʽ�ļ�����ֱ�Ӽ���
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
