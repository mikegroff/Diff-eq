
f = @(t,x) 1-2*t*x;
f1 = @(t,x) 2*t*f(t,x)-2*x;
f2 = @(t,x) 2*t*f1(t,x);
h = 2./100;
k = 0; x(1) = 0; t(1) = 0;
while t < 2
        k = k + 1; 
        t(k + 1) = t(k) + h;
        x(k + 1) = x(k) + h*f(t(k),x(k)) + h^2/2*f1(t(k),x(k))+...
            h^3/6*f2(t(k),x(k));
end
y = linspace(0,2);
    plot(t,x,'r--',t,dawson(t))
    legend('Taylor approx','Exact Solution')
    disp(length(t));
clear t x;