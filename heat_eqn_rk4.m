clear; close all
N = 21; a =0; b=1; h = (b-a)/(N+1); k = 0.1/2^3; 
%A = (-2*diag(ones(N,1)) + diag(ones(N-1,1),-1) + diag(ones(N-1,1),1))/(h^2);
A = -5/2*diag(ones(N,1)) + ...
    4/3*diag(ones(N-1,1),-1) + 4/3*diag(ones(N-1,1),1)-...
    1/12*diag(ones(N-2,1),2) - 1/12*diag(ones(N-2,1),-2);
A(1,N) = 1/12; A(N,1) = 1/12; A = A/(h^2);
f = @(t,u) A*u;
u = zeros(N,1/k+1); x = h:h:b-h; u(:,1) = sin(pi*x); t = 0; plot(x,u); hold


for n=1:1/k+1 % 1/h = N
    u(:,n+1) = rk4_step(f,t(n),u(:,n),k);
    t(n+1) = t(n)+k;
    if max(u(:,n+1)) > 1; t(n+1), return; end
    exact(:,n+1) = exp(-pi^2*t(n+1))*sin(pi*x);
end

J = n;
for n = 1:round(J/50):J
    plot(x,u(:,n+1),x(1:(N-1)/5:N),exact(1:(N-1)/5:N,n+1),'ro'); pause(0.1)
end

hold