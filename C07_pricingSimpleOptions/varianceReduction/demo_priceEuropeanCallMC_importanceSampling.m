function  demo_priceEuropeanCallMC_importanceSampling
% demo_priceEuropeanCallMC_importanceSampling: Importance sampling
% for the MC estimate of the price of a European call option
%          
format short
%% Parameters of the European call option
S0    = 100;  % initial price
K     = 200;  % strike (out of the money)
r     = 0.05; % interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility       
         
%% MC estimate with M trajectories
M = 1e4; 

%% Standard MC
[price_MC,stdev_MC] = priceEuropeanCallMC(S0,K,r,T,sigma,M)

%% MC + importance sampling
[price_MC_importanceSampling,stdev_MC_importanceSampling] = priceEuropeanCallMC_importanceSampling(S0,K,r,T,sigma,M)

%% Exact price
price_exact = priceEuropeanCall(S0,K,r,T,sigma)
