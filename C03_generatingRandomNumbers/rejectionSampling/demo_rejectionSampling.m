function demo_rejectionSampling
%% demo_rejectionSampling: illustrate rejection sampling

%% Target distribution
p      = [1/2 1/3 1/6];
mu     = [-1.0 4.0 12.0];
sigma  = [ 1.0 3.0  0.5];
f_Y    = @(x)(GMpdf(x,p,mu,sigma));

%% Origin distribution
mu0    = 4;
sigma0 = 8;
f_X    = @(x)(normpdf(x,mu0,sigma0));
rndX   = @()(mu0+sigma0*randn);

%% Scale f_X so that if covers f_Y
A = 6;

figure(1);
nPlot  = 1000;
xPlot  = linspace(-10,20,nPlot);
plot(xPlot,A*f_X(xPlot),xPlot,f_Y(xPlot))
drawnow

%% Rejection sampling
M = 10; 
N = 1000;

Y = rejectionSampling(M,N,f_X,f_Y,A,rndX);

%% Compare with histogram
figure(2); graphicalComparisonPdf(Y(:),f_Y)