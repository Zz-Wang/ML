function demo_priceEuropeanOption_call
%% demo_priceEuropeanOption_call: Price of a European call option
format short

%% Parameters of the asset
S0    = 12;   % initial price of the underlying asset
sigma = 0.2;   % volatility

%% Parameters of the option
K      = 14;                 % strike
T      = 1;                  % maturity
payoff = @(ST)(max(ST-K,0)); % payoff of the European call option

%% Risk-neutral pricing
r = 0.05;  % risk-free interest rate

%% Price of the European call option
price = priceEuropeanOption(S0,r,T,sigma,payoff)
         