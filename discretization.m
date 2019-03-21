clear; close all;

N = 100; tl = 0; tr = pi; xl = 0; xr = pi; h = (tr-tl)/(N+1);
a = ones(N-1)*(1+h^2/2); c = ones(N-1)*(1-h^2/2); d = (-2 + h^2)*ones(N,1);
t = (1:N)*h; t = t(:); b = -2*h^3*t.*cos(t); b(N) = b(N) - (1-h^2/2)*xr;
x = tri(a,b,c,d);
t = 0:h:pi;
exact = t + 2*sin(t); exact = exact(:);
subplot (2,1,1), plot(t,[xl:x:xr],t,exact,'o')
subplot (2,1,2), semilogy(t,abs( [xl:x:xr] -exact))

function x = tri(a,b,c,d)

n = length(d);

for k=2:n
    m = a(k-1)/d(k-1);
    d(k) = d(k) - m*c(k-1);
    b(k) = b(k)- m*b(k-1);
end

x(n) = b(n)/d(n);

for k=n-1:-1:1
    x(k) = (b(k)-c(k)*x(k+1))/d(k);
end
x = x(:);
end