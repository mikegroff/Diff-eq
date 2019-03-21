clear; clf;
N = 100; a = 0; b = 1; h = (b-a)/(N+1); k = h; x = h:h:b-h;
A = (diag(zeros(N,1)/k) + (1+k/h)*diag(ones(N-1,1),-1) + (1-k/h)*diag(ones(N-1,1),1))/2;
%A = k*(2*h*diag(zeros(N,1)/k)/k + (-1)*diag(ones(N-1,1),-1) + (-1)*diag(ones(N-1,1),1))/(2*h);
u = zeros(N,1/k+1); t = 0; u(:,1) = u0(t,x); exact = u;
subplot(2,1,1), plot(x,u); hold
ylim([-1 2]);

for n=1:1/k 
    u(:,n+1) = A*u(:,n);
    t(n+1) = t(n) + k;
    %if max(u(:,n+1)) > 1; t(n+1), hold; return; end
    exact(:,n+1) = u0(t(n+1),x);
    subplot(2,1,1), plot(x,u(:,n),x,exact(:,n),'o');
    ylim([-1 2])
    subplot(2,1,2), plot(x,abs(u(:,n)-exact(:,n)));
    pause(0.01);

end
%
hold

function y = u0(t,x)
y = ones(length(x),1);
l = 0+t; m = 1+t;
y(x<=l) = 0;
y(x>=m) = 0;
end
