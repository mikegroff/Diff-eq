%clear; close all
p=1;
N = 128*p; h = 2*pi/N; x = h*(1:N)'; t = 0; dt = h/4;
c = .2 + sin(x-1).^2;
v = exp(-100*(x-1).^2); vold = exp(-100*(x-.2*dt-1).^2);
d = zeros(1,N); a = ones(1,N-1);
D = diag(d) + diag(-a,-1) + diag(a,1);
% Time-stepping by leap frog formula:
tmax = 8; tplot = .15; clf, drawnow, set(gcf,'renderer','zbuffer')
plotgap = round(tplot/dt); dt = tplot/plotgap;
nplots = round(tmax/tplot);
data = [v'; zeros(nplots,N)]; tdata = t;
for i = 1:nplots
    for n = 1:plotgap
        t = t+dt;
        w = D*v;
        vnew = vold - dt*c.*w/h; vold = v; v = vnew;
    end
    data(i+1,:) = v; tdata = [tdata; t];
end
figure(p)
waterfall(x,tdata,data), %view(10,70), colormap(1e-6*[1 1 1]);
%axis([0 2*pi 0 tmax 0 5]), ylabel t, zlabel u, grid off
