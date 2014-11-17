function  demo_priceEuropeanCallMC_antithetic
% demo_priceEuropeanCallMC_antithetic: Efficiency of antithetic variance reduction
% for the MC estimate of the price of a European call option
%          
%% Parameters of the European call option
S0    = 100;  % initial price of the underlying asset
K     = 90;   % strike
r     = 0.05; % risk-free interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility

%% Batch MC (B repetitions) MC estimate with M trajectories

M = 2^14; 
B = 1000;

%% Standard MC
tic         % start timing 
for b = 1:B
    [price_MC,stdev_MC] = priceEuropeanCallMC(S0,K,r,T,sigma,M);
end
t_MC = toc  % stop timing
stdev_MC
efficiency_MC = 1.0/(t_MC*stdev_MC^2);

%% MC + antithetic variance reduction
tic                    % start timing 
for b = 1:B
    [price_MC_antithetic,stdev_MC_antithetic] = ...
        priceEuropeanCallMC_antithetic(S0,K,r,T,sigma,M);
end
t_MC_antithetic = toc  % stop timing
stdev_MC_antithetic
efficiency_MC_antithetic = 1.0/(t_MC_antithetic*stdev_MC_antithetic^2);

%% Relative efficiency  

efficiency_MC_antithetic/efficiency_MC
