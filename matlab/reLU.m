function m = reLU(m)
% 激活函数：reLU或S函数，视具体情况而定。

%m(m<=0) = 0;
m = 1./(1+exp(-m));
end
