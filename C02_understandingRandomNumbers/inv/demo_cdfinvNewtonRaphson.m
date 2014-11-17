function demo_cdfinvNewtonRaphson()
%% demo_cdfinvNewtonRaphson: Inverse cdf with Newton-Raphson method

%%  Parameters for the normal distribution
mu = 1; sigma = 3;

pdf = @(x)normpdf(x,mu,sigma);
cdf = @(x)normcdf(x,mu,sigma);

%% Uniform grid of probability values
M = 10000; 
p = (1:2:2*M-1)/(2*M);

%% Calculate inverse using the Newton-Raphson method
x0  = mu;
X   = cdfinvNewtonRaphson(p,pdf,cdf,x0);

%% Compare with the Gaussian pdf
figure(1); clf;
graphicalComparisonPdf(X,pdf)