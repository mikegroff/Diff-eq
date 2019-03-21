clear; close all; 

f = @(t,x) [x(3);  x(4);  -x(1).*(x(1).^2+x(2).^2).^(-3/2);  -x(2).*(x(1).^2+x(2).^2).^(-3/2)];
steps = 128;
h = 2*pi/steps; X = [1;0;0;1]; t = 0;

for n=1:steps
    X(:,n+1) = rk4_step(f,t(n),X(:,n),h);
    t(n+1) = t(n)+h;
end


subplot(2,1,1), plot(X(1,:), X(2,:));
axis([-2 2 -1.5 1.5]);
title('The Solutions')
xlabel('x1(t)'); ylabel('x2(t)');

subplot(2,1,2), plot(X(3,:), X(4,:));
axis([-2 2 -1.5 1.5]);
title('The Solutions')
xlabel('x3(t)'); ylabel('x4(t)');
