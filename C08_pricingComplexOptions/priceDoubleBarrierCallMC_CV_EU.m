function [price_MC_CV,stdev_MC_CV] = priceDoubleBarrierCallMC_CV_EU(S0,K,B1,B2,r,T,sigma,M,N)
%% priceDoubleBarrierCallMC_CV_EU: Black-Scholes price of a double barrier
%% (up and out, down and out) call option, by Monte Carlo with the European call as control variate
%
%% SYNTAX:
% [price_MC_CV,stdev_MC_CV] = priceDoubleBarrierCallMC_CV_EU(S0,K,B1,B2,r,T,sigma,M,N)
%
%% INPUT:
% S0 : Initial value of the underlying asset
% K : Strike
% B1 : Up-and-out barrier
% B2 : Down-and-out barrier
% r : Risk-free interest rate
% T : Time to expiry
% sigma : Volatility
% M : Number of simulations
% N : Number of observations
%
%% OUTPUT:
% price_MC_CV : MC+CV estimate of the price of the option in the Black-Scholes model
% stdev_MC_CV : MC+CV estimate of the standard deviation
%
%% EXAMPLE:
 S0 = 100; K = 90; B1 = 160; B2 = 75; r = 0.05; T = 0.5; sigma = 0.4;
 M = 1e3; N = 1e4;

 % MC barrier without CV
%% Generate M x N samples from N(0,1)
X = randn(M,N); 

%% Simulate M trajectories in N steps
deltaT = T/N;
S      = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2);
 
%% Compute the payoff for each trajectory
ST     = S(:,end);    % value of S at maturity
payoff1 = max(ST-K,0).*all(B2<S<B1,2);


% MC European option 
S0 = 100; K = 90;r = 0.05; T = 0.5; sigma = 0.4; M = 1e3; 
%% generate M samples from N(0,1)
X = randn(M,1); 

%% simulate M trajectories in one step
ST = S0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*X);

%% define payoff
payoff2 = max(ST-K,0);

re = corr(payoff1, payoff2)
%re =

%   -0.0032
%re =

%    0.0080
% No correlation and no actual reduction in variance.