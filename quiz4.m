f = @(t,x) x + t*exp(-t); %10.3.9b
%f_x = e^x >0 \forall t
% Solution should diverge  \forall t
g = @(t,x) cos(t) - exp(x); %10.3.9e
%f_x = -e^x <0 \forall 
%Solution should converge \forall t

h = 0.01; t = 0; x1 = 1; x2 = 0; y1 = 1; y2 = -1;


for n=1:100/h 
    x1(:,n+1) = rk4_step(f,t(n),x1(:,n),h);
    x2(:,n+1) = rk4_step(f,t(n),x2(:,n),h);
    y1(:,n+1) = rk4_step(g,t(n),y1(:,n),h);
    y2(:,n+1) = rk4_step(g,t(n),y2(:,n),h);
    t(n+1) = t(n)+h;
end
figure(1);

subplot(2,1,1), plot(t,x1,t,x2);
title('Divergent Solutions');
xlabel('t'); ylabel('x(t)');
legend('IC_1','IC_2');
subplot(2,1,2), semilogy( t, abs(x1-x2));
title('Solutions Difference');
figure(2);

subplot(2,1,1), plot(t,y1,t,y2);
title('Convergent Solutions');
xlabel('t'); ylabel('x(t)');
legend('IC_1','IC_2');
subplot(2,1,2), semilogy( t, abs(y1-y2));
title('Solutions Difference');

