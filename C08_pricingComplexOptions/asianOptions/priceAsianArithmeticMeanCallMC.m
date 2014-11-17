function  [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC(S0,K,r,T,sigma,M,N)
%% priceAsianArithmeticMeanCall: Price of a Asian call option on the arithmetic mean in the Black-Scholes model
%
%% SYNTAX:
%        [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC(S0,K,r,T,sigma,M,N)
%
%% INPUT:
%       S0 : Initial value of the underlying asset
%        K : Strike 
%        r : Risk-free interest rate 
%        T : Time to expiry 
%    sigma : Volatility 
%        M : Number of simulations
%        N : Number of observations
%
%% OUTPUT:
% price_MC : MC estimate of the price of the option in the Black-Scholes model
%
% stdev_MC : MC estimate of the standard deviation  
%
%% EXAMPLE:   
        S0 = 100; K = 90; r = 0.05; T = 1; sigma = 0.2;
        M = 1e5; N = 12;
        [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC(S0,K,r,T,sigma,M,N)
%         

%% Generate M x N samples from N(0,1)
X = randn(M,N); 

%% Simulate M trajectories in N steps
deltaT = T/N;
S      = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2);

%% Compute the arithmetic mean for each trajectory
arithmeticMean = mean(S(:,2:end),2);

%% Compute the payoff
payoff = max(arithmeticMean-K,0);

%% MC estimate of the price and the error of the option
discountFactor = exp(-r*T);

price_MC = discountFactor*mean(payoff);
stdev_MC = discountFactor*std(payoff)/sqrt(M);

%price_MC =

%   12.9315
% stdev_MC =

%    0.0347
