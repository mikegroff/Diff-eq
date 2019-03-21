clear close all;

X1 = @(t,X) [X(2);-sin(X(1))];
X2 = @(t,X) [-sin(X(1));-X(2)*cos(X(1))];
T2 = @(t,X,h) X + h*X1(t,X) + h^2/2*X2(t,X);
hold on;
TF = 10; h = 0.1;
X = zeros(2,TF/h + 1);Y = X;
p = 0.1; q = 0;
X0 = [p;q];
 X = X0; t = 0; 



for n=1:TF/h % 1/h = N
    X(:,n+1) = T2(t(n),X(:,n),h); % 2nd order Taylor
    t(n+1) = t(n) + h;
    K1 = h*X1(t(n),Y(:,n));
    K2 = h*X1(t(n) + h,Y(:,n) + K1);
    Y(:,n+1) = Y(:,n) + 1/2*(K1 + K2);
end
plot(X(1,:),X(2,:),Y(1,:),Y(2,:),'--',X(1,end),X(2,end),'o'); axis equal

hold off;