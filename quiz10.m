clear; clf; close all; 
% in the book the lax scheme is slightly different as has each alpha^2 term
% multiplied by the constant (pulse step), also you asked us to use a pulse step (c) of
% 1/2 i might be missing something but it doesnt make sense in the scope of this 
% problem as out uo(x) is based around having a constant value of either 1 or 0, 
% if i change the pulse step (c) to 1/2 the scheme fails very quickly but when 
% the pulse step (c) is 1 it works perfecty for k=h  same as the lax scheme with 
% some interesting behavior when the value of k is changed with the lax wendroff
% scheme not starightening out nearly as quickly as the lax 
N = 100; a = 0; b = 12; h = (b-a)/(N+1); k = h; x = h:h:b-h; aa = 1; c = 1; alpha = c*k/h;
%if we increase N the error disappears almost completely when h = k
A = (diag(zeros(N,1)/k) + (1+k/h)*diag(ones(N-1,1),-1) + (1-k/h)*diag(ones(N-1,1),1))/2;

B = (1-alpha^2)*diag(ones(N,1)) + (alpha^2 + alpha)*diag(ones(N-1,1),-1)/2 + (alpha^2 - alpha)*diag(ones(N-1,1),1)/2;
u = zeros(N,round(1/k)); t = 0; u(:,1) = u0(aa,t,x); exact = u; v = u;

m=1;
hold on;
for n=1:round((b-a-1)/k)
    u(:,n+1) = A*u(:,n);
    v(:,n+1) = B*v(:,n);
    t(n+1) = t(n) + k;
    exact(:,n+1) = u0(aa,t(n+1),x);
    if(abs(t(n+1)-1) < k/2 || abs(t(n+1)-4) < k/2 ||  abs(t(n+1)-8) < k/2 ||  abs(t(n+1)-10) < k/2 )
    figure(1);
    subplot(2,2,m), plot(x,u(:,n),'x',x,v(:,n),'g',x,exact(:,n),'ro');
    title('Lax Scheme Approx');legend('Lax','Lax-Wendroff','Exact');
    ylim([-1 2])
    xlim([t(n+1)-2*k 1+t(n+1)+k]);
    %figure(2);
    %subplot(2,2,m), plot(x,abs(u(:,n)-exact(:,n)),x,abs(v(:,n)-exact(:,n)));
    %title('The errors');
    m = m+1;
    end
end
hold off;
%

function y = u0(a,t,x)
y = ones(length(x),1);
l = 0+a*t; m = 1+a*t;
y(x<=l) = 0;
y(x>=m) = 0;
end
