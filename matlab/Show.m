function m = Show(M, i)
% M:28*28�еľ���.
% i:ָ��ȡ�þ����ĳһ��.
% ��ʾ��д�ֿ��ĳ��ͼƬ.
% ���ص���28*28�ľ���.

[r,c] = size(M);
if i <= c && 28*28 <= r
    m = reshape(M(:, i), 28, 28);
    imshow(m);
else
    m = [];
end
