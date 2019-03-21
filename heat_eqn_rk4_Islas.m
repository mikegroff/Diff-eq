%
% Solve x' = f(t,x) = x + t, x(0) = 0, 0 < t <= 1
% with solution x(t) = - t - 1 + exp(t)
% using the 2nd order Taylor approximation, y1,
% the 2nd order Runge-Kutta, y2, and
% the 2nd order Adams-Bashford, y3.
% graph the error
%
clear; clf;
N = 21; a = 0; b = 1; h = (b-a)/(N+1); k = 0.1/2^7; x = h:h:b-h;
A = ( -2*diag(ones(N,1)) + diag(ones(N-1,1),-1) + diag(ones(N-1,1),1) )/h^2;
% A = -5/2*diag(ones(N,1)) + ...
% 4/3*diag(ones(N-1,1),-1) + 4/3*diag(ones(N-1,1),1) - ...
% 1/12*diag(ones(N-2,1),2) - 1/12*diag(ones(N-2,1),-2);
% A(1,N) = 1/12; A(N,1) = 1/12; A = A/h^2;

f = @(t,u) A*u;
u = zeros(N,1/k+1); u(:,1) = sin(pi*x); t = 0;
plot(x,u); hold
%
for n=1:1/k+1 
    u(:,n+1) = rk4_step(f,t(n),u(:,n),k);
    t(n+1) = t(n) + k;
    if max(u(:,n+1)) > 1; t(n+1), hold; return; end
    exact(:,n+1) = exp(-pi^2*t(n+1))*sin(pi*x);
end
%
J = n;
for n=1:round(J/50):J
    plot(x,u(:,n),x(1:(N-1)/5:N),exact(1:(N-1)/5:N,n),'ro');
end
hold