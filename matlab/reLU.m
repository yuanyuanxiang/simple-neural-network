function m = reLU(m)
% �������reLU,S�������������Ӿ������������
% y = f(x): x-Input

%i=m<=0; m(i)=0; %reLU
m = 1./(1+exp(-m)); %Sigmoid
%a = exp(m); b = exp(-m); m = (a-b)./(a+b); %tanh
end
