function m = Grad(m)
% 激活层的梯度：采用reLU函数或S函数。

%m(m<=0) = 0;
%m(m>0) = 1;
m = m .* (1-m);
end
