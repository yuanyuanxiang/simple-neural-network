function [p, s] = Identify(file)
% 对给定的图像文件进行识别.
% 返回识别结果p及其得分s.
m = double(rgb2gray(imread(file)));
m = imresize(255-m, [28, 28], 'bicubic');
v = max(max(m));
if v == 0
    p = -1; s = 0;
    return
else
    [A1, A2, loss] = LoadNN(28*28, 10);
    m = m / v;
    In = reshape(m, 28*28, 1);
    hidden = reLU(A1 * [1; In]);
    Out = reLU(A2 * [1; hidden]);
    [s, p] = max(Out);
    p = p - 1;
    imshow(m);
    xlabel(num2str(p));
    ylabel(num2str(s));
end
end
