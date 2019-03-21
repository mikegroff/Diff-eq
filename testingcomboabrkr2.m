f = @(t,x) x + t; 
f1 = @(t,x) f(t,x) + 1; % x'' = x' = f1 = x' + 1 = f + 1;

h = 0.1; x0 = 0; y1 = x0; y2 = x0; y3 = x0; y4 = x0; n =1; t = 0;

y1(n+1) = t2_step(f,f1,t(n),y1(n),h);
y2(n+1) = rk2_step(f,t(n),y2(n),h);
y3(n+1) = y1(n+1);
y4(n+1) = am2_step(f,y4(n),t(n),h,1d-5);
t(n+1) = t(n)+h;
for n=2:1/h % 1/h = N
    y1(n+1) = t2_step(f,f1,t(n),y1(n),h);
    y2(n+1) = rk2_step(f,t(n),y2(n),h);
    y3(n+1) = ab2_step(f, t(n), y3(n-1), y3(n), h);
    y4(n+1) = am2_step(f,y4(n),t(n),h,1d-5);
    t(n+1) = t(n)+h;
end
e = - t - 1 + exp(t);
subplot(2,1,1), plot(t,e,'r--',t,y1,t,y2,t,y3,t,y4)
title('The solutions')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(e-y1),t,abs(e-y2),'o', t, abs(e-y3),t,abs(e-y4))
title('The errors')
xlabel('t'); ylabel('x(t)')