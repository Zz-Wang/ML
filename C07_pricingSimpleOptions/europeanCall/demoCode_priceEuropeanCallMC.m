function demoCode_priceEuropeanCallMC
%% demoCode_priceEuropeanCallMC: MC estimate of the price of a European call option
%          

%% Parameters of the European call option
S0    = 100;  % initial price of the underlying
K     = 90;   % strike
r     = 0.05; % risk-free interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility

%% Generate M x N samples from N(0,1)
M = 4;   % simulate M trajectories
N = 5;   % N time-steps

X = randn(M,N) 

%% Simulate M trajectories in [t0,t0+T] in N time-steps of size deltaT
deltaT = T/N;
aux    = [S0*ones(M,1) exp((r-0.5*sigma^2)*deltaT+sigma*sqrt(deltaT)*X)]
S      = cumprod(aux,2)

%% Value of the underlying at maturity 
ST = S(:,end) % Last value of the simulated trajectories

%% Payoff 
payoff = max(ST-K,0)  % European call option

%% MC estimate of the price
discountFactor = exp(-r*T);
price_MC = discountFactor*mean(payoff)

%% MC estimate of the error
stdev_MC = discountFactor*std(payoff)/sqrt(M)

