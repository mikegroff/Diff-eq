function y = t2_step(f,f1,t,x,h)
y = x + h*f(t,x) + h^2/2*f1(t,x);

