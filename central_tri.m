%Apply a central discretization to the derivatives and solve a system
% of linear eguations to solve x'' = -x, x(0) = 1; x(pi/2) = 2
%
N = 100; tl = 0; tr = pi/2; xl = 1; xr = 2; h = (tr-tl)/(N+1);
a = ones(N-1); c = a; d = (-2 + h^2)*ones(N,1);
b = zeros(N,1); b(1) = -xl; b(N) = -xr;
x = tri(a,b,c,d);
t = 0:h:pi/2;
exact = cos(t) + xr*sin(t); exact = exact(:);
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