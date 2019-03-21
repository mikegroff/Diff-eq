clear; close all;
f = @(t,x) (x+t)^2;
f1 = @(t,x) 2*(x+t)*(f(t,x) + 1);
f2 = @(t,x) 2*(f(t,x) + 1)^2*f1(t,x);
f3 = @(t,x) 2*(f(t,x) + 1)^2*f1(t,x)^2*f2(t,x);

T1 = @(t,x,h) x + h*f(t,x);
T2 = @(t,x,h) x + h*f(t,x) + h^2/2*f1(t,x);
T3 = @(t,x,h) x + h*f(t,x) + h^2/2*f1(t,x) + h^3/6*f2(t,x);
T4 = @(t,x,h) x + h*f(t,x) + h^2/2*f1(t,x) + h^3/6*f2(t,x) + h^4/24*f3(t,x);

x0 = 0; k = 0; h = 0.01; 
s1 = x0; s2 = x0; s3 = x0; s4 = x0; t = 0;
    while t <= 1
        k = k+1;
        s1(k+1) = T1(t(k),s1(k),h);
        s2(k+1) = T2(t(k),s2(k),h);
        s3(k+1) = T3(t(k),s3(k),h);
        s4(k+1) = T4(t(k),s4(k),h);
        t(k+1) = t(k) + h;
    end

    plot(t,s1,'--',t,s2,'-o',t,s3,'o',t,s4);
    legend('1st Order', '2nd Order','3rd Order','4th Order');
    