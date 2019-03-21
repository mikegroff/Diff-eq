
function rk = rk4_step(f,t,x,h)
k1 = h*f(t,x);
k2 = h*f(t+h/2, x +k1/2);
k3 = h*f(t+h/2, x +k2/2);
k4 = h*f(t+h, x +k3);
rk = x+1/6*(k1+2*k2+2*k3+k4);
end
