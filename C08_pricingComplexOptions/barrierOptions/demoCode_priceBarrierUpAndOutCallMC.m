function  demoCode_priceBarrierUpAndOutCallMC
%% demoCode_priceBarrierUpAndOutCallMC: Black-Scholes price of an up and out barrier call option

%% Parameters of the up-and-out call barrier option
S0    = 100;   % initial price
K     = 95;    % strike
B     = 115;   % barrier level
r     = 0.05;  % interest rate
T     = 1;     % maturity 
sigma = 0.1;   % volatility
N     = 4;     % monitoring times

%% Simulate M trajectories in [t0,t0+T] in N time-steps of size deltaT
M = 4;          % number of trajectories
deltaT = T/N;   % time step for the simulation

X = randn(M,N); % Generate M x N samples from N(0,1)
S = cumprod([S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)],2)

%% Check whether the trajectory is below the barrier

indexUnderBarrier = all(S<B,2)

%% Compute the payoff for each trajectory

ST     = S(:,end)    % value of S at maturity
payoff = max(ST-K,0).*indexUnderBarrier

%% MC estimate of the price of the option and standard deviation of this estimate
discountFactor = exp(-r*T);

price_MC = discountFactor*mean(payoff)
stdev_MC = discountFactor*std(payoff)/sqrt(M)
