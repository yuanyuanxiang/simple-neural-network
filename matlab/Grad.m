function m = Grad(m)
% �������ݶȣ�����reLU������S������

%m(m<=0) = 0;
%m(m>0) = 1;
m = m .* (1-m);
end
