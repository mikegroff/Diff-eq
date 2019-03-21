clear; close all; 

f = @(t,x) [x(2);  x(1)^2 - x(3) + exp(t); x(4);  x(1) - x(3)^2 - exp(t)];

h = 2^(-5); X = [1;0;1;-2]; t = 0;
X1 = X; t1 = t;
for n=1:1/h
    X1(:,n+1) = rk4_step(f,t1(n),X1(:,n),h);
    t1(n+1) = t1(n)+h;
end

h = 2^(-6);
X2 = X;t2 = t;
for n=1:1/h
    X2(:,n+1) = rk4_step(f,t2(n),X2(:,n),h);
    t2(n+1) = t2(n)+h;
end

h = 2^(-7);
X3 = X;t3 = t;
for n=1:1/h
    X3(:,n+1) = rk4_step(f,t3(n),X3(:,n),h);
    t3(n+1) = t3(n)+h;
end

plot(X1(1,:), X1(3,:),X2(1,:), X2(3,:),X3(1,:),X3(3,:));
legend('k = 5', 'k = 6','k = 7');
title('The Solutions')
xlabel('x'); ylabel('y');

