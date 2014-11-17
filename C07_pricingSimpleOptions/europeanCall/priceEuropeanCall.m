function price = priceEuropeanCall(S0,K,r,T,sigma)
%% priceEuropeanCall: Price of a European call option in the Black-Scholes model
%
%% SYNTAX:
%        price = priceEuropeanCall(S0,K,r,T,sigma)
%
%% INPUT:
%       S0 : Initial value of the underlying asset
%        K : Strike 
%        r : Risk-free interest rate 
%        T : Time to expiry 
%    sigma : Volatility 
%
%% OUTPUT:
%    price : Price of the option in the Black-Scholes model  
%
%% EXAMPLE:   
%        S0 = 100; r = 0.05; K = 90; T = 2; sigma = 0.4;
%        price = priceEuropeanCall(S0,K,r,T,sigma)
%          

%% Auxiliary parameters
discountedK     = K.*exp(-r.*T); 
totalVolatility = sigma.*sqrt(T); 

d_minus = log(S0./discountedK)./totalVolatility;
d_plus  = d_minus + 0.5*totalVolatility;
d_minus = d_minus - 0.5*totalVolatility;

%% Pricing formula
price = S0.*normcdf(d_plus) - discountedK.*normcdf(d_minus);

