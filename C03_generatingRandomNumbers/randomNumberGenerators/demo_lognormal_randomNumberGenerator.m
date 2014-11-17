function demo_lognormal_randomNumberGenerator
%% demo_lognormal_randomNumberGenerator: generate LN[mu,sigma] random numbers

%% Parameters for the lognormal distribution
mu    = 0.1;
sigma = 0.4;

%% Simulate a matrix (M rows, N columns) of  LN[mu,sigma] random numbers
M = 1000;
N = 100;

% simulate X ~ N(mu,sigma)
X = mu + sigma*randn(M,N);

% simulate LN[mu,sigma]
Y = exp(X);

%% Compare scaled histogram to pdf
modelPdf = @(y)(lognpdf(y,mu,sigma));
figure(1); graphicalComparisonPdf(Y(:),modelPdf)
title('Y ~ LN[\mu,\sigma]')
            
