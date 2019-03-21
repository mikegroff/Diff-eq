function y = ab2_step(f,t,x0,x1,h)
y = x1 + h/2*(3*f(t,x1) - f(t-h,x0));

