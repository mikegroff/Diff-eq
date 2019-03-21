clear; close all;

f = @(t,x) [x(2); -x(1)+t*x(2)- 2*t*cos(t)]; 
a = 1; b = pi+1; N = 100; h = (b-a)/N; x = zeros(2,N+1);
z = [0 1]; xb = pi; tol = 1d-10; k =0; x0 = 0; t0 = 0;

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
clear t

g = @(t,x) [x(2); -x(1)+t*x(2)- 2*t*cos(t); x(4); -x(3)+t*x(4)- 2*t*cos(t)]; 
a = 0; b = pi; N = 100; h = (b-a)/N; xx = zeros(4,N+1);
z = [0 1]; xa = 0; xb = pi; tol = 1d-5; t = 0;
xx = [xa; z(1) ; xa ;z(2)];

for n=1:N
    xx(:,n+1) = rk4_step(g,t(n),xx(:,n),h);
    t(n+1) = t(n)+h;
end

lambda = (xb - xx(3,end))/(xx(1,end)-xx(3,end));
soln = lambda*xx(1,:) + (1-lambda)*xx(3,:);
it = 1:5:length(t);
exact = t + 2*sin(t);
subplot(2,1,1), plot(t,x(1,:),t,soln,t(it),exact(it), 'o')
title(sprintf('Solution after %g trials',k+1));
legend('Approx','Exact');
subplot(2,1,2), semilogy(t,abs(x(1,:)-exact),t,abs(soln - exact))
title('The Errors');
