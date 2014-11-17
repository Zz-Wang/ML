function demo_graphicalComparisonPdf
%% demo_graphicalComparisonPdf: Comparison of histogram and pdf

%% Generate lognormal data
mu    = 1; 
sigma = 0.5;

M = 1e3;  % sample size
S = exp(mu + sigma*randn(M,1));

%% Sample estimates of the parameters
hat_mu    = mean(log(S))    
hat_sigma = std(log(S),1)

%% Compare histogram with model pdf
modelPdf = @(S)(lognpdf(S,hat_mu,hat_sigma));
figure(1); clf;
graphicalComparisonPdf(S,modelPdf)
title('LN fit')     
            
