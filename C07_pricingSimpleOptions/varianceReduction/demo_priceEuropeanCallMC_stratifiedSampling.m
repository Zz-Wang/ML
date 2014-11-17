function  demo_priceEuropeanCallMC_stratifiedSampling
% demo_priceEuropeanCallMC_stratifiedSampling: Stratified sampling
% for the MC estimate of the price of a European call option
%          
format short
%% Parameters of the European call option
S0    = 100;  % initial price
K     = 90;   % strike (out of the money)
r     = 0.05; % interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility       
         
%% MC estimate with M trajectories
M = 1e5; 

%% Standard MC
[price_MC,stdev_MC] = priceEuropeanCallMC(S0,K,r,T,sigma,M)

%% MC + stratified sampling
       
nStrata = 10; 
M = round(M/nStrata);  % use the same number of simulations
[price_MC_stratifiedSampling,stdev_MC_stratifiedSampling] = priceEuropeanCallMC_stratifiedSampling(S0,K,r,T,sigma,M,nStrata)
           
%% Exact price
price_exact = priceEuropeanCall(S0,K,r,T,sigma)

%% batch MC (B repetitions) 
B = 1000;
for b = 1:B
    price_MC_stratifiedSampling(b) = priceEuropeanCallMC_stratifiedSampling(S0,K,r,T,sigma,M,nStrata);
end
 
%% Check that the MC estimates have the predicted mean and stdev
mu    = mean(price_MC_stratifiedSampling)
sigma = std(price_MC_stratifiedSampling)

%% Check that the price estimates follow a Gaussian 
figure(1); clf,
modelPdf = @(price)(normpdf(price,price_exact,stdev_MC_stratifiedSampling));
graphicalComparisonPdf(price_MC_stratifiedSampling,modelPdf)
title('price_{MC} ~ Normal')

