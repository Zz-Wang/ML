function demo_graphicalComparisonCdf
%% demo_graphicalComparisonCdf: Comparison of empirical and model cdf

%% Parameters for the lognormal distribution
mu    = 1; 
sigma = 0.5;

%% Generate S ~ LN(mu,sigma)
M = 1e2;  % sample size
S = exp(mu + sigma*randn(M,1));

%% Sample estimates of the parameters
hat_mu    = mean(log(S))    
hat_sigma = std(log(S),1)

%% Compare empirical with model cdf
modelCdf = @(S)(logncdf(S,hat_mu,hat_sigma));
figure(1); clf;
graphicalComparisonCdf(S,modelCdf)
title('LN fit')     
            
