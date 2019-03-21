function y = u0(t,x)
y = ones(length(x),1);
l = 0+t; m = 1+t;
y(x<=l) = 0;
y(x>=m) = 0;