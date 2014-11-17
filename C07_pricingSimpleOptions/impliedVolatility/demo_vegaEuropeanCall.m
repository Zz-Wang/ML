function  demo_VegaEuropeanCall
% demo_VegaEuropeanCall: Vega of a European call option using numerical derivatives
%          

%% Parameters of the European call option
S0    = 100;  % initial price
K     = 90;   % strike
r     = 0.05; % interest rate
T     = 2;    % maturity 
sigma = 0.4;  % volatility

%% Numerical estimate of vega

% pricing function
fPrice = @(sigma)(priceEuropeanCall(S0,K,r,T,sigma));

% good balance between rounding and truncation errors in the numerical derivative
h = 1e-5; 

numericalVega = numericalDerivative(fPrice,sigma,h)

%% Vega of a European call option
vega = vegaEuropeanCall(S0,K,r,T,sigma)

