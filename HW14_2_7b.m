%Using the shooring method solv x'' = -x^2, x(0) = 1, x(1) = 1
%exact soln given by x(t) = cost + 2 sin t
%stat with 2 guess for x'(0): z(1) and z(2) resply and define using linear approx
%z(k+1) = z(k) + (xb - phi(k) )/(phi(k) - phi(k-1) z(k) -z(k-1)
clear; close all;

for kk=1:3
    
    epsilon = 10^(-kk);
    f = @(t,x) [x(2); (1-x(2)^2)/epsilon];
    a = 0; b = 1; N = 100; h = (b-a)/N; x = zeros(2,N+1);
    z = [0 1]; xa = 0; xb = 1; tol = 1d-5; k =0; x0 = 1; t0 = 0; phi = zeros(11,1);
    
    for y=z
        x = [xa;y]; t = t0;
        for n=1:N
            x(:,n+1) = rk4_step(f,t(n),x(:,n),h);
            t(n+1) = t(n)+h;
        end
        k = k+1; phi(k) = x(1,N+1); clear t x;
        
    end
    
    for k = 2:10
        z(k+1) = z(k) + (xb - phi(k) )/(phi(k) - phi(k-1))*(z(k) -z(k-1));
        y = z(k+1); x(:,1) = [xa;y]; t(1) = t0;
        for n=1:N
            x(:,n+1) = rk4_step(f,t(n),x(:,n),h);
            t(n+1) = t(n)+h;
        end
        phi(k+1) = x(1,N+1);
        if abs(phi(k+1) - xb) < tol || k == 10; break; end
        clear t x
    end
    
    exact = 1+epsilon.*log(cosh((t-0.745)./epsilon));
    it = 1:5:length(t);
    figure;
    subplot(2,1,1), plot(t,x(1,:),t(it),exact(it),'ro');
    title(sprintf('Solution after %g trials for epsilon = %g',k+1,epsilon));
    legend('Approx','Exact');
    subplot(2,1,2), semilogy(t,abs( x(1,:) - exact));
    title('The Errors');
    
end
