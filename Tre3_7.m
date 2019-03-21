clear; close all;
% Grid, variable coefficient, and initial data:
steps = 1; dt1=zeros(1,steps); dt2=zeros(1,steps);
for p=1:steps
    N = 256; h = 2*pi/N; x = h*(1:N); t = 0; dt = h/4;
    c = .2 + sin(x-1).^2;
    v = exp(-100*(x-1).^2); vold = exp(-100*(x-.2*dt-1).^2);
    column = [0 .5*(-1).^(1:N-1).*cot((1:N-1)*h/2)]';
    D = toeplitz(column,column([1 N:-1:2]));
    % Time-stepping by leap frog formula:
    tmax = 8; tplot = .15; clf, drawnow
    plotgap = round(tplot/dt); dt = tplot/plotgap;
    nplots = round(tmax/tplot);
    data = [v; zeros(nplots,N)]; tdata = t;
    time1 = cputime;
    for i = 1:nplots
        for n = 1:plotgap
            t = t+dt;
            vhat = fft(v);
            what = 1i*[0:N/2-1 0 -N/2+1:-1] .* vhat;
            w = real(ifft(what));
            vnew = vold - 2*dt*c.*w;
            vold = v; v = vnew;
        end
        data(i+1,:) = v; tdata = [tdata; t];
    end
    time1 = cputime - time1;
    x = h*(1:N)'; v = exp(-100*(x-1).^2); vold = exp(-100*(x-.2*dt-1).^2);c = .2 + sin(x-1).^2;
    data2 = [v'; zeros(nplots,N)]; t =0; %tdata = t;
    time2 = cputime;
    for i = 1:nplots
        for n = 1:plotgap
            t = t+dt;
            w = D*v;
            vnew = vold - 2*dt*c.*w;
            vold = v; v = vnew;
        end
        data2(i+1,:) = v; %tdata = [tdata; t];
    end
    time2 = cputime - time2;
    dt1(p) = time1;
    dt2(p) = time2;
end
at1 = sum(dt1);
at2 = sum(dt2);
atf = at1/at2
figure(1);
waterfall(x,tdata,data), view(10,70), colormap([0 0 0])
axis([0 2*pi 0 tmax 0 5]), ylabel t, zlabel u, grid off

figure(2);
waterfall(x,tdata,data2), %view(10,70), colormap([0 0 0])
%axis([0 2*pi 0 tmax 0 5]), ylabel t, zlabel u, grid off
