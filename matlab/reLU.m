function m = reLU(m)
% �������reLU��S�������Ӿ������������

%m(m<=0) = 0;
m = 1./(1+exp(-m));
end
