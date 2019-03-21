clear; close all;
f = @(t,x) 1+x/t; 
f1 = @(t,x) f(t,x)/t - x/(t^2); 
f2 = @(t,x) f1(t,x)/t - 2*f(t,x)/(t^2) + 2*x/(t^3);
f3 = @(t,x) f2(t,x)/t - 3*f1(t,x)/(t^2) + 6*f(t,x)/(t^3)-6*x/(t^4);

h = 0.01; x0 = 1; y1 = x0; y2 = x0; n =1; t = 1;


for n=1:1/h % 1/h = N
    y1(n+1) = t4_steps(f,f1,f2,f3,t(n),y1(n),h);
    y2(n+1) = rk4_steps(f,t(n),y2(n),h);
    t(n+1) = t(n)+h;
end
e = t+ t.*log(t);
subplot(2,1,1), plot(t,e,t,y1,'o',t,y2,'x')
title('The solutions')
xlabel('t'); ylabel('x(t)');
legend('f(t)','t4_approx', 'rk4_approx');
subplot(2,1,2), semilogy(t,abs(e-y1),t,abs(e-y2),'o')
title('The errors')
xlabel('t'); ylabel('x(t)');
legend('t4_approx', 'rk4_approx');


function rk = rk4_steps(f,t,x,h)
k1 = h*f(t,x);
k2 = h*f(t+h/2, x +k1/2);
k3 = h*f(t+h/2, x +k2/2);
k4 = h*f(t+h, x +k3);
rk = x+1/6*(k1+2*k2+2*k3+k4);
end

function y = t4_steps(f, f1, f2, f3 ,t,x,h)
y = x + h*f(t,x) + h^2/2*f1(t,x) + h^3/6*f2(t,x) + h^4/24*f3(t,x);
end