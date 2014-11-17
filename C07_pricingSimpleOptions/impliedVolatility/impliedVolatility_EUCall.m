function sigma = impliedVolatility_EUCall(price,S0,K,r,T,sigma0)
% impliedVolatility_EUCall: Implied volatility of a European call option
%
% SYNTAX: 
%
%        sigma = impliedVolatility_EUCall(price,S0,K,r,T,sigma0)
%
% INPUT:
%     price : Price of the option
%        S0 : Initial price of the asset
%         K : Strike 
%         r : Risk-free interest rate
%         T : Time to expiration date 
%    sigma0 : Initial guess for the implicit volatility
%
% OUTPUT:
%     sigma : Implied volatility
%
% EXAMPLE:   
%            S0 = 100; K = 90; r = 0.05; T = 2; 
%            price = 26.24;
%            sigma0 = 0.2;
%            impliedVolatility_EUCall(price,S0,K,r,T,sigma0)
%
%
%
TOL = 1e-6;     % Target error
MAXITER = 50;   % Maximum number of iterations in Newton-Raphson
sigma = sigma0; % Volatility
iter = 0;       % Initialize the iteration counter 
dSigma = 10.0*TOL; 
while (iter< MAXITER) && (abs(dSigma) > TOL)
    iter = iter + 1; % Increment iteration counter  
    dSigma = (price_EUCall(S0,K,r,T,sigma) - price)/vega_EUCall(S0,K,r,T,sigma); 
    sigma = sigma - dSigma; % Update the estimation of sigma
end
%
if (iter == MAXITER)
    warning('Newton-Raphson has not converged')
end