clear; close all;
hold;
f1 = @(t,x) x^2 -t;
f2 = @(t,x) 2*x*f1(t,x) -1;
f3 = @(t,x) 2*(f2(t,x).^2) + 2*x*f1(t,x);
T3 = @(t,x,h) x + h*f1(t,x) + h^2/2*f2(t,x) + h^3/6*f3(t,x);
a = 0; t = a; x = -3.5; N = 10; h = 0.01; k = 0;


while t < N
    k = k +1;
    t(k+1) = t(k) + h;
    x(k+1) = T3(t(k),x(k),h);
end
    
plot(t,x);
clear t x;



for l = -2.5:-0.1:-3
    a = -2; t = a; x = l; k = 0;
while t < N
    k = k +1;
    if x(k) > 4 ; break; end
    t(k+1) = t(k) + h;
    x(k+1) = T3(t(k),x(k),h);
end
plot(t,x);
clear t x;

end

hold;