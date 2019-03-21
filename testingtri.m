% testing tri
% Let b = A*ones(N,1)
% using tri should spit back a column of ones

for N=1:1000
a = rand(N-1,1)+1; c = rand(N-1,1)+1; d = rand(N,1)+1;
A = diag(d) + diag(a,-1)+diag(c,1);
b = A*ones(N,1);
x = tri(a,b,c,d);
if norm(x - ones(N,1)) > 1d-10; N, break; end
end

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