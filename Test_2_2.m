clear; close all;

N = 100; tl = 0; tr = 2; xl = 1; xr = 0; h = (tr-tl)/(N+1);
u = @(t) exp(-2*t); w = -4; v = w;
a = -1*ones(N-1,1)*(1+h/2*w); 
c = -1*ones(N-1,1)*(1-h/2*w); 
d = (2 + h^2*v)*ones(N,1);
t = (1:N)*h; t = t(:); 
b = -h^2*u(t);
b(1) = b(1) - a(1)*xl;
b(N) = b(N) + (1-h^2/2)*xr;
x = tri(a,b,c,d)';
t = [tl;t;tr];
it = 1:5:length(t);

exact = exp(-2.*t).*(1+-3.*t/2 + t.^2/2); exact = exact(:);
subplot (2,1,1), plot(t,[xl;x;xr],t(it),exact(it),'o')
legend('Approx', 'Exact');
xlabel('Time'); ylabel('X(t)');
subplot (2,1,2), semilogy(t,abs( [xl;x;xr] -exact))
xlabel('Time'); ylabel('Error');

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

end