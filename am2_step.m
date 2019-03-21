function y = am2_step(f,x,t,h,tol)
y0 = x; v = y0; v0 = v; k = 0; error = 1; f0 = f(t,y0);

while error > tol || k <= 10
    k = k+1;
    v = y0 + h/2*(f0 + f(t+h,v) );
    error = abs(v-v0);
    v0=v;
end
y = v;

k
