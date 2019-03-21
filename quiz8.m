clear; clf; close all;
N = 200; a = 0; b = 5; h = (b-a)/(N+1); k = h; x = h:h:b-h; aa = 1;
%if we increase N the error disappears almost completely when h = k
A = (diag(zeros(N,1)/k) + (1+k/h)*diag(ones(N-1,1),-1) + (1-k/h)*diag(ones(N-1,1),1))/2;
%A = k*(2*h*diag(zeros(N,1)/k)/k + (-1)*diag(ones(N-1,1),-1) + (-1)*diag(ones(N-1,1),1))/(2*h);
u = zeros(N,round(1/k)); t = 0; u(:,1) = u0(aa,t,x); exact = u;
subplot(2,1,1), plot(x,u); 
ylim([-1 2]);
xlim([-k 1+k]);

for n=1:round((b-a-1)/k)
    u(:,n+1) = A*u(:,n);
    t(n+1) = t(n) + k;
    exact(:,n+1) = u0(aa,t(n+1),x);
    subplot(2,1,1), plot(x,u(:,n),'b',x,exact(:,n),'ro');
    title('Lax Scheme Approx');legend('Lax','Exact');
    ylim([-1 2])
    xlim([t(n+1)-2*h 1+t(n+1)+h]);
    subplot(2,1,2), plot(x,abs(u(:,n)-exact(:,n)));
    title('The error');
    pause(0.00000001);

end
%


function y = u0(a,t,x)
y = ones(length(x),1);
l = 0+a*t; m = 1+a*t;
y(x<=l) = 0;
y(x>=m) = 0;
end
