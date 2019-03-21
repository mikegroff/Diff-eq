function y = t4_step(f, f1, f2, f3 ,t,x,h)
y = x + h*f(t,x) + h^2/2*f1(t,x) + h^3/6*f2(t,x) + h^4/24*f3(t,x);