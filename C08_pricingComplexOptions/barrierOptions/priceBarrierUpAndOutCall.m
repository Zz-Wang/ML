function  price = priceBarrierUpAndOutCall(S0,K,B,r,T,sigma)
%% priceBarrierUpAndOutCall: Black-Scholes price of an up and out barrier price option (continuous observations)
%
%% SYNTAX:
%        price = priceBarrierUpAndOutCall(S0,K,B,r,T,sigma)
%
%% INPUT:
%       S0 : Initial value of the underlying asset
%        K : Strike 
%        B : Up-and-out barrier 
%        r : Risk-free interest rate 
%        T : Time to expiry 
%    sigma : Volatility 
%
%% OUTPUT:
%    price : Price of the option in the Black-Scholes model  
% 
%% EXAMPLE:   
%        S0 = 100; K = 90; B = 160; r = 0.05; T = 0.5; sigma = 0.4;
%        price = priceBarrierUpAndOutCall(S0,K,B,r,T,sigma)
        M = 1000; N = 10000;
%        % MC price is different because of discretization errors
%        [price_MC,stdev_MC] = priceBarrierUpAndOutCallMC(S0,K,B,r,T,sigma,M,N)
%          

mu = r - 0.5*sigma^2;
nu = 2.0* mu/sigma^2;
aux1 = (B/S0)^(nu+2);
aux2 = (B/S0)^(nu);
[d0 d1] = compute_d(S0,K,r,sigma,T);
price   = S0*normcdf(d1)-K.*exp(-r.*T).*normcdf(d0);
[d0 d1] = compute_d(S0,B,r,sigma,T);
price   = price - S0*normcdf(d1)+K.*exp(-r.*T).*normcdf(d0);
[d0 d1] = compute_d(1.0/S0,1.0/B,r,sigma,T);
price   = price + aux1.*S0.*normcdf(d1)-aux2.*K.*(exp(-r.*T).*normcdf(d0));
[d0 d1] = compute_d(1./(K.*S0),1./B.^2,r,sigma,T);
price   = price - aux1.*S0.*normcdf(d1)+ aux2.*K.*(exp(-r.*T).*normcdf(d0));


function [d0, d1] = compute_d(S0,K,r,sigma,T)
%
%
%
d1 = (log(S0./K)+(r+sigma.^2/2).*T)./(sigma.*sqrt(T)); 
d0 = d1  - sigma.*sqrt(T);