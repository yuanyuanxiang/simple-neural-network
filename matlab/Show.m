function m = Show(M, i)
% 显示手写字库的某个图片.
% 返回的是28*28的矩阵.

[r,c] = size(M);
if i <= c && 28*28 <= r
    m = reshape(M(:, i), 28, 28);
    imshow(m);
else
    m = [];
end
