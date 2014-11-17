function demo_exponential_randomNumberGenerator
%% demo_exponential_randomNumberGenerator: generate Exp[lambda]  random numbers

%% Parameters for the simulation
lambda = 10;

%% Simulate a matrix (M rows, N columns) of  Exp[lambda] random numbers
%
% $$ X \sim \lambda e^{-\lambda x} $$
%
% $$ invcdf(p) = -\frac{log(1-p)} \lambda $$
%
M = 100;
N = 1000;

U = rand(M,N);      % U ~ U[0,1]
X = -log(U)/lambda; % inverse method: X ~ Exp[lambda]

%% Compare to histogram 
modelPdf = @(x)(lambda*exp(-lambda*x));
figure(1); graphicalComparisonPdf(X(:),modelPdf)
title(sprintf('X ~ Exp[%s = %.2f]','\lambda',lambda))
                   
