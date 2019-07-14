function m = Show(M, i)
% M:28*28行的矩阵.
% i:指明取该矩阵的某一列.
% 显示手写字库的某个图片.
% 返回的是28*28的矩阵.

[r,c] = size(M);
if i <= c && 28*28 <= r
    m = reshape(M(:, i), 28, 28);
    imshow(m);
else
    m = [];
end
