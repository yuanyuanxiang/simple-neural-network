function m = Grad(m)
% �������ݶȣ��ɼ����������
% y' = f'(y): y-Input

%m(m<=0) = 0; m(m>0) = 1; %reLU
m = m .* (1-m); %Sigmoid
%m = 1 - m .* m; %tanh
end
