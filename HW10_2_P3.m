clear; close all;
f = @(t,x) x; 
x = 1; n = 1; t = 0; h = 0.01;

while t < 10
    x(n+1) = x(n) + h*f(t(n),x(n)) + h^2/2*f(t(n),x(n)) + h^3/6*f(t(n),x(n))+ ...
             h^4/24*f(t(n),x(n))+h^5/120*f(t(n),x(n))+h^6/720*f(t(n),x(n))+ ... 
             h^7/5040*f(t(n),x(n))+ h^8/40320*f(t(n),x(n))+h^9/362880*f(t(n),x(n))+...
             h^10/3628800*f(t(n),x(n));
    t(n+1) = t(n) + h;
    n = n+1;
end
e = exp(t);
subplot(2,1,1), plot(t,e,t,x,'r--');
subplot(2,1,2), semilogy(t,abs(e-x));