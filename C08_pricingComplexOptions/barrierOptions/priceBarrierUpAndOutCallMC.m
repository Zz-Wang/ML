function [price_MC,stdev_MC] = priceBarrierUpAndOutCallMC(S0,K,B1,B2,r,T,sigma,M,N)
%% priceBarrierUpAndOutCallMC: Black-Scholes price of an up and out barrier call option 
%
%% SYNTAX:
%        [price_MC,stdev_MC] = priceBarrierUpAndOutCallMC(S0,K,B,r,T,sigma,M,N)
%
%% INPUT:
%       S0 : Initial value of the underlying asset
%        K : Strike 
%        B : Up-and-out barrier 
%        r : Risk-free interest rate 
%        T : Time to expiry 
%    sigma : Volatility 
%        M : Number of simulations
%        N : Number of observations
%
%% OUTPUT:
% price_MC : MC estimate of the price of the option in the Black-Scholes model  
% stdev_MC : MC estimate of the standard deviation  
%
%% EXAMPLE:   
%        S0 = 100; K = 90; B = 160; r = 0.05; T = 2; sigma = 0.4;
%        M = 1e5; N = 24;
%        [price_MC,stdev_MC] = priceBarrierUpAndOutCallMC(S0,K,B,r,T,sigma,M,N)
%          

% exercise 2
% S0 = 100; K = 90; B1 = 160; B2 = 75; r = 0.05; T = 0.5; sigma = 0.4;
% M = 1e3; N = 1e4;

%% Generate M x N samples from N(0,1)
X = randn(M,N); 

%% Simulate M trajectories in N steps
deltaT = T/N;
S      = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2);
 
%% Compute the payoff for each trajectory
ST     = S(:,end);    % value of S at maturity
% payoff = max(ST-K,0).*all(S<B,2);
payoff = max(ST-K,0).*all(B2<S<B1,2);
%% MC estimate of the price and the error of the option
discountFactor = exp(-r*T);

price_MC = discountFactor*mean(payoff);
stdev_MC = discountFactor*std(payoff)/sqrt(M);
