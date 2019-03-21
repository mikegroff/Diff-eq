%Using the shooring method solv x'' = ((2-t)*e^(2*x) + 1/(1+t))/3, x(0) = 0,
%x(1) = -log(2)
%exact soln given by x(t) = -log(1+t)
%start with 2 guess for x'(0): z(1) and z(2) resply and define using linear approx 
%z(k+1) = z(k) + (xb - phi(k) )/(phi(k) - phi(k-1) z(k) -z(k-1)
clear; close all;

f = @(t,x) [x(2); ((2-t)*exp(2*x(1)) + 1/(1+t))/3]; 
a = 0; b = 1; N = 100; h = (b-a)/N; x = zeros(2,N+1);
z = [0 1]; xb = -log(2); tol = 1d-10; k =0; x0 = 0; t0 = 0;

for y=z
    x = [x0;y]; t = t0;
    for n=1:N
        x(:,n+1) = rk4_step(f,t(n),x(:,n),h);
        t(n+1) = t(n)+h;
    end
    k = k+1; phi(k) = x(1,N+1);
    clear t x;
    
end

for k = 2:10
    z(k+1) = z(k) + (xb - phi(k) )/(phi(k) - phi(k-1))*(z(k) -z(k-1));
    y = z(k+1); x = [x0;y]; t = t0;
    for n=1:N
        x(:,n+1) = rk4_step(f,t(n),x(:,n),h);
        t(n+1) = t(n)+h;
    end
    phi(k+1) = x(1,N+1);
    if abs(phi(k+1) - xb) < tol; break; end
    clear t x 
end
%
exact = -log(1+t);
subplot(2,1,1), plot(t,x(1,:),t,exact, 'o')
title(sprintf('Solution after %g trials',k+1));
legend('Approx','Exact');
subplot(2,1,2), semilogy(t,abs(x(1,:)-exact))
title('The Errors');


