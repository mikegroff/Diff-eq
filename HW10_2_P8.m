clear; close all;
f = @(t,x) x+t; g = @(t,x) x-t;

h = 0.1; h2 = 0.09; x0 = 1; y1 = x0; y2 = x0; n =1; t = -1; t2 = -1;
e = exp(t+1) - (t+1); e2 = exp(t2+1) - (t2+1);

for n=1:1/h %    
    y1(n+1) = rk4_steps(f,t(n),y1(n),h);
    t(n+1) = t(n)+h;
    e(n+1) = exp(t(n+1)+1) - (t(n+1)+1);
end
    
for n=1:1/h2   
    y2(n+1) = rk4_steps(f,t2(n),y2(n),h2);
    t2(n+1) = t2(n)+h2;
    e2(n+1) = exp(t2(n+1)+1) - (t2(n+1)+1);
end
    
for n=1/h+1:2/h  
    y1(n+1) = rk4_steps(g,t(n),y1(n),h);
    t(n+1) = t(n)+h;
    e(n+1) = exp(t(n+1)+1) - 2*exp(t(n+1)) + (t(n+1)+1);
end
   
for n=12:2/h2
    y2(n+1) = rk4_steps(g,t2(n),y2(n),h2);
    t2(n+1) = t2(n)+h2;
    e2(n+1) = exp(t2(n+1)+1) - 2*exp(t2(n+1)) + (t2(n+1)+1);
end

subplot(2,1,1), plot(t2,e2,t,y1,'o',t2,y2,'x')
title('The solutions')
xlabel('t'); ylabel('x(t)');
legend('f(t)','h = 0.1', 'h = 0.09');
subplot(2,1,2), semilogy(t,abs(e-y1),'o',t2,abs(e2-y2),'x')
title('The errors')
xlabel('t'); ylabel('x(t)');
legend('h = 0.1', 'h = 0.09');


function rk = rk4_steps(f,t,x,h)
k1 = h*f(t,x);
k2 = h*f(t+h/2, x +k1/2);
k3 = h*f(t+h/2, x +k2/2);
k4 = h*f(t+h, x +k3);
rk = x+1/6*(k1+2*k2+2*k3+k4);
end
