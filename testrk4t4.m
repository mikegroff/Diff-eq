f = @(t,x) x + t; 
f1 = @(t,x) f(t,x) + 1; 
f2 = @(t,x) f1(t,x);
f3 = @(t,x) f2(t,x);

h = 0.01; x0 = 0; y1 = x0; y2 = x0; n =1; t = 0;


for n=1:1/h % 1/h = N
    y1(n+1) = t4_step(f,f1,f2,f3,t(n),y1(n),h);
    y2(n+1) = rk4_step(f,t(n),y2(n),h);
    t(n+1) = t(n)+h;
end
e = - t - 1 + exp(t);
subplot(2,1,1), plot(t,e,'r--',t,y1,t,y2)
title('The solutions')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(e-y1),t,abs(e-y2),'o')
title('The errors')
xlabel('t'); ylabel('x(t)')