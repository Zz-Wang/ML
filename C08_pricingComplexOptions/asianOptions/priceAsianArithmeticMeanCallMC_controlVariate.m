function  [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC_controlVariate(S0,K,r,T,sigma,M,N)
%% priceAsianArithmeticMeanCall_controlVariate: Control variate variance reduction for the 
%  price of a Asian call option on the arithmetic mean in the Black-Scholes model
%
%% SYNTAX:
%        [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC_controlVariate(S0,K,r,T,sigma,M,N)
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
% stdev_MC : MC estimate of the standard deviation  
%
%% EXAMPLE:   
%        S0 = 100; K = 90; r = 0.05; T = 2; sigma = 0.4;
%        M = 1e5; N = 24;
%        [price_MC,stdev_MC] = priceAsianArithmeticMeanCallMC_controlVariate(S0,K,r,T,sigma,M,N)
%          

%% Generate M x N samples from N(0,1)
X = randn(M,N); 

%% Simulate M trajectories in N steps
deltaT = T/N;
S      = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2);

%% Compute arithmetic and geometric means per trajectory
arithmeticMean = mean(S(:,2:end),2);
geometricMean  = exp(mean(log(S(:,2:end)),2));

%% Compute the payoff
payoff_arithmetic = max(arithmeticMean-K,0);
payoff_geometric  = max( geometricMean-K,0);

%% MC estimate of the covariance matrix
covarianceMatrix = cov([payoff_arithmetic payoff_geometric]);

var_arithmetic            = covarianceMatrix(1,1);
var_geometric             = covarianceMatrix(2,2);
cov_arithmetic_geometric  = covarianceMatrix(1,2);
corr_arithmetic_geometric = cov_arithmetic_geometric/sqrt(var_arithmetic*var_geometric);

%% Standard MC for the arithmetic mean asian call option
discountFactor = exp(-r*T);
price_arithmetic_MC = discountFactor*mean(payoff_arithmetic);
stdev_arithmetic_MC = discountFactor*std(payoff_arithmetic)/sqrt(M);

%% Pricing for the geometric mean asian call option
price_geometric_MC = discountFactor*mean(payoff_geometric);
stdev_geometric_MC = discountFactor*std(payoff_geometric)/sqrt(M);

price_geometric_exact = priceAsianGeometricMeanCall(S0,K,r,T,sigma,N);

%% MC + control variate for the arithmetic mean asian call option
price_MC = price_arithmetic_MC - cov_arithmetic_geometric/var_geometric...
                                 *(price_geometric_MC - price_geometric_exact);
stdev_MC = stdev_arithmetic_MC*sqrt(1-corr_arithmetic_geometric^2);

