function  demo_priceEuropeanCallMC
% demo_priceEuropeanCallMC: MC estimate of the price of a European call option
%          
format short
%% Parameters of the European call option
S0    = 100;  % initial price of the underlying asset
K     = 90;   % strike
r     = 0.05; % risk-free interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility

%% Exact price

price_exact = priceEuropeanCall(S0,K,r,T,sigma);

%% MC estimate with M trajectories

M = 1e4; 
[price_MC,stdev_MC] = priceEuropeanCallMC(S0,K,r,T,sigma,M)


%% True error of the estimate
error = price_MC - price_exact

%% MC estimate with 100*M trajectories

M = 100*M; % on average reduces the error by a factor of 10
[price_MC,stdev_MC] = priceEuropeanCallMC(S0,K,r,T,sigma,M)

%% True error of the estimate
 
error = price_MC - price_exact