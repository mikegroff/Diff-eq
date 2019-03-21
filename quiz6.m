clear; clf
L = 5;
N = 101; a =0; b=1; h = (b-a)/(N+1); k = (0.5)^L; 
A = -2*diag(ones(N,1)) + diag(ones(N-1,1),-1) + diag(ones(N-1,1),1);
I = diag(ones(N,1));
D1 = I - (k/(2*h^2))*A;
D2 = I + (k/(2*h^2))*A;
D1 = D1^(-1);
u = zeros(N,1/k+1); x = h:h:b-h; u(:,1) = x.*(1-x); t = 0;
f = @(t,u) D1*D2*u;
hold
plot(x,u); 
%
for n=1:1/k+1 
    u(:,n+1) = rk4_step(f,t(n),u(:,n),k);
    t(n+1) = t(n) + k;
end

J = n;
for n=1:round(J/50):J
    plot(x,u(:,n));
end
hold
