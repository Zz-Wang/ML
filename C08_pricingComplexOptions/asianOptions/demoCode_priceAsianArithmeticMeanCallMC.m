function  demoCode_priceAsianArithmeticMeanCallMC
%% demoCode_priceAsianArithmeticMeanCallMC: Price of a Asian call option on the arithmetic mean in the Black-Scholes model

%% Parameters of the Asian call option
S0    = 100;   % initial price
K     = 95;    % strike
r     = 0.05;  % interest rate
T     = 1;     % maturity 
sigma = 0.2;   % volatility
N     = 4;     % monitoring times

%% Simulate M trajectories in [t0,t0+T] in N time-steps of size deltaT
M = 3;          % number of trajectories
deltaT = T/N;   % time step for the simulation

X = randn(M,N); % Generate M x N samples from N(0,1)
S = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2)

%% Compute the arithmetic mean for each trajectory
arithmeticMean = mean(S(:,2:end),2)

%% Compute the payoff
payoff = max(arithmeticMean-K,0)

%% MC estimate of the price of the option and standard deviation of this estimate
discountFactor = exp(-r*T);

price_MC = discountFactor*mean(payoff)
stdev_MC = discountFactor*std(payoff)/sqrt(M)
