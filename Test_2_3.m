
f = @(t,x) [x(2); exp(x(1))]; 
a = 0; b = 1/5; N = 100; h = (b-a)/N; x = zeros(2,N+1);
z = [-25/2 -23/2]; xa = log(8*pi^2); xb = log(8*pi^2) - 2*log(cos(2*pi/5)); tol = 1d-10; k =0; x0 = xa; t0 = 0; phi = zeros(1001,1);

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
    if abs(phi(k+1) - xb) < tol; break; end
    clear t x 
end

c1 = 8*pi^2; c2 = 0; 
exact = log(c1) - 2.*log(cos( (c1/2)^(1/2).*t + c2 ));
subplot(2,1,1), plot(t,x(1,:),t,exact, 'r--')
%ylim([0 15]); xlim([0 1+h]);
legend('Approx', 'Exact');
xlabel('Time'); ylabel('X(t)');
title(sprintf('Solution after %g trials',k+1));
subplot(2,1,2), semilogy(t,abs(x(1,:)-exact))
%xlim([0 1+h]); xlabel('Time'); ylabel('Error');


