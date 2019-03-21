function y = ab4_step(f,x,x1,x2,x3,t,h,tol)
y0 = x; k = 0; error = 1; 
f0 = f(t,y0); f1 = f(t-h,x1); f2 = f(t-2*h,x2); f3 = f(t-3*h,x3);

v = y0 + h/24*(55*f0 - 59*f1 + 37*f2 - 9*f3); v0=v;

while error > tol || k <= 10
    k = k+1;
    v = y0 + h/24*(9*f(t+h,v) + 19^f0 + - 5*f1 + f2);
    error = abs(v-v0);
    v0=v;
end
y = v;