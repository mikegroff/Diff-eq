%Using the shooring method solv x'' = -x, x(0) = 1, x(pi/2) = 2
%exact soln given by x(t) = cost + 2 sin t
%stat with 2 guess for x'(0): z(1) and z(2) 
%define lambda so x(t) = lambda x1(t) + (1-lambda) x2(t)
% satisfires right hand boundary equations
%also uses and augemented system to compute x1 and x2 all at once


f = @(t,x) [x(2); -x(1); x(4); -x(3)]; 
a = 0; b = pi/2; N = 100; h = (b-a)/N; x = zeros(4,N+1);
z = [0 1]; xa = 1; xb = 2; tol = 1d-5; t = 0;
x = [xa; z(1) ; xa ;z(2)];

for n=1:N
    x(:,n+1) = rk4_step(f,t(n),x(:,n),h);
    t(n+1) = t(n)+h;
end

lambda = (xb - x(3,end))/(x(1,end)-x(3,end));
soln = lambda*x(1,:) + (1-lambda)*x(3,:);

%
exact = cos(t) + xb*sin(t);
subplot(2,1,1), plot(t,soln,t(1:5:end),exact(1:5:end),'o')

subplot(2,1,2), semilogy(t,abs(soln-exact))

