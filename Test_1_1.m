f = @(t,x) sin(t)/t; 
f1 = @(t,x) cos(t)/t - (f(t,x))/t; 
f2 = @(t,x) -f(t,x) - 2/t*f1(t,x);
f3 = @(t,x) -f1(t,x) - 2/t*f2(t,x)+ f1(t,x)/t^2;
g = @(t,x) 1;

h = 0.01; x0 = 0; y1 = x0; y2 = x0; n =1; t = 0;


y1(2) = t4_step(g,g,g,g,t,y1,h);
y2(2) = rk4_step(g,t,y2,h);
y1(2) = y2(2); %approximations are much closer if we use the rk4 step for
%both on the first step
t(2) = t + h;

for n=2:1/h % 1/h = N
    y1(n+1) = t4_step(f,f1,f2,f3,t(n),y1(n),h);
    y2(n+1) = rk4_step(f,t(n),y2(n),h);
    t(n+1) = t(n)+h;
end

subplot(2,1,1), plot(t,y1,t,y2,'o')
title('The Solutions')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(y1-y2))
title('The Errors')
xlabel('t'); ylabel('x(t)')