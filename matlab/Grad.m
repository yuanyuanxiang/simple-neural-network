function m = Grad(m)
%m(m<=0) = 0;
%m(m>0) = 1;
m = m .* (1-m);
end
