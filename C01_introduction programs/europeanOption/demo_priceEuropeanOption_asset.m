function demo_priceEuropeanOption_asset
%% demo_priceEuropeanOption_asset: Pricing the asset
format short

%% Parameters of the asset
S0    = 100;   % initial price of the underlying asset
sigma = 0.4;   % volatility

%% Parameters of the option
T      = 2;         % maturity
payoff = @(ST)(ST); % payoff at maturity

%% Risk-neutral pricing
r = 0.05;  % risk-free interest rate

%% Price of the asset
price = priceEuropeanOption(S0,r,T,sigma,payoff)
         