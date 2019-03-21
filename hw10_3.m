clear; close all;

f = @(t,x) -1/t*exp(-1/t); %x'(t) of approximation of problem 12
k = 0.47047;
g = @(t,x) 2/sqrt(pi)*exp(-t^2);%(2*t + k/(1+k*t))*(1-x); %x'(t) of approximation of problem 13
h = @(t,x) sin(t)/t; %x'(t) of of approximation of problem 15

hh = 0.01; x0 = 1; x1 = 0;%1-(0.3084284*(1/(1+k))-0.0849713*(1/(1+k))^2+0.6627698*(1/(1+k))^2)*2/(sqrt(pi));
x2 = 1;
y1 = x0; y2 = x0; z1 = x1; z2 = x1; w1 = x2; w2 = x2;
t = 0.01; tol = 1d-6;


for n=1:1/hh % 1/h = N
    y1(n+1) = rk4_steps(f,t(n),y1(n),hh);
    z1(n+1) = rk4_steps(g,t(n),z1(n),hh);
    w1(n+1) = rk4_steps(h,t(n),w1(n),hh);
    t(n+1) = t(n)+hh;
end
for k=1:3
    y2(k+1) = y1(k+1);
    z2(k+1) = z1(k+1);
    w2(k+1) = w1(k+1);
end
for l=4:1/hh
    y2(l+1) = ab4_steps(f,y2(l),y2(l-1),y2(l-2),y2(l-3),t(l),hh,tol);
    z2(l+1) = ab4_steps(g,z2(l),z2(l-1),z2(l-2),z2(l-3),t(l),hh,tol);
    w2(l+1) = ab4_steps(h,w2(l),w2(l-1),w2(l-2),w2(l-3),t(l),hh,tol);
end

figure (12);
subplot(2,1,1), plot(t,y1,t,y2,'o')
title('The solutions')
legend('RK4','ABM4')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(y1-y2))
title('The errors')
xlabel('t'); ylabel('x(t)')

figure (13);
subplot(2,1,1), plot(t,z1,t,z2,'o')
title('The solutions')
legend('RK4','ABM4')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(z1-z2))
title('The errors')
xlabel('t'); ylabel('x(t)')

figure (15);
subplot(2,1,1), plot(t,w1,t,w2,'o')
title('The solutions')
legend('RK4','ABM4')
xlabel('t'); ylabel('x(t)');
subplot(2,1,2), semilogy(t,abs(w1-w2))
title('The errors')
xlabel('t'); ylabel('x(t)')

function rk = rk4_steps(f,t,x,h)
k1 = h*f(t,x);
k2 = h*f(t+h/2, x +k1/2);
k3 = h*f(t+h/2, x +k2/2);
k4 = h*f(t+h, x +k3);
rk = x+1/6*(k1+2*k2+2*k3+k4);
end


function y = ab4_steps(f,x,x1,x2,x3,t,h,tol)
y0 = x; k = 0; error = 1; 
f0 = f(t,y0); f1 = f(t-h,x1); f2 = f(t-2*h,x2); f3 = f(t-3*h,x3);

v = y0 + h/24*(55*f0 - 59*f1 + 37*f2 - 9*f3); v0=v;

while error > tol || k <= 10
    k = k+1;
    v = y0 + h/24*(9*f(t+h,v) + 19*f0 + - 5*f1 + f2);
    error = abs(v-v0);
    v0=v;
end
y = v;
end