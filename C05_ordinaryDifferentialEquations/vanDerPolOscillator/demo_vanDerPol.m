function demo_vanDerPol()
% demo_vanDerPol: numerical integration (Euler) of the Van der Pol oscillator
%

% damping parameter
mu = 2;

% initial conditions
t0 = 0; 
x0 = 1e-5; 
p0 = 1e-5;

% integration parameters
T = 100; 
N = 1e5;

[t,x,p] = eulerIntegrationVanDerPol(t0,x0,p0,mu,T,N);

% Plot  p(t) as a function of x(t)
figure(1); clf
h1 = plot(x0,p0,'k','LineWidth',1.5);
hold on
h2 = plot(x0,p0,'ro','LineWidth',2,'MarkerSize',6);
hold off
MIN_X = -2.2;  MAX_X = 2.2;
MIN_Y = -4;    MAX_Y = 4;
axis([MIN_X MAX_X MIN_Y MAX_Y])
xlabel('x(t)');
ylabel('p(t)');
drawnow

% Plot time series of x(t) and p(t)
figure(2); clf
subplot(2,1,1);
h3 = plot(t0,x0);
axis([t0 t0+T MIN_X MAX_X])
xlabel('t'); ylabel('x(t)');
subplot(2,1,2);
h4 = plot(t0,p0,'m');
axis([t0 t0+T MIN_Y MAX_Y])
xlabel('t'); ylabel('p(t)');
drawnow

pause(3)

% Update plots
frameLength = 50;
for i = 1:length(t)
    if(mod(i,frameLength) == 0)
        set(h1,'XData',x(1:i));
        set(h1,'YData',p(1:i));
        set(h2,'XData',x(i));
        set(h2,'YData',p(i));
        set(h3,'XData',t(1:i));
        set(h3,'YData',x(1:i));
        set(h4,'XData',t(1:i));
        set(h4,'YData',p(1:i));
        % pause(0.1)
        drawnow
    end
end
