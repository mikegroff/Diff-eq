function rk = rk2_step(f,t,x,h)
k1 = h*f(t,x);
k2 = h*f(t+h, x +k1);
rk = x+1/2*(k1+k2);
