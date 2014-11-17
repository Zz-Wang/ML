function  price = priceEuropeanOption(S0,r,T,sigma,payoff)
%% priceEuropeanOption: Price of a European option in the Black-Scholes model
%
%% SYNTAX:
%        price = priceEuropeanOption(S0,r,T,sigma,payoff)
%
%% INPUT:
%       S0 : Initial value of the underlying asset
%        r : Risk-free interest rate 
%        T : Time to expiry 
%    sigma : Volatility 
%   payoff : Handle to the function of ST that specifies the payoff
%
%% OUTPUT:
%    price : Price of the option in the Black-Scholes model  
%
%% EXAMPLE:   
        S0 = 100; K = 90; r = 0.05; T = 2; sigma = 0.4; A=90;
        digitalPayoff = @(ST)((ST >= K)*A); % payoff of a European call option
        price  = priceEuropeanOption(S0,r,T,sigma,digitalPayoff)
          

%% Value of underlying asset at t0+T in the BS model
ST = @(x)(S0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*x));

%% Integrand
integrand = @(x)(normpdf(x).*digitalPayoff(ST(x)));

%% Interval [-R,R] includes a probability mass larger than (1-eps) for N(0,1)
R = 10; 

%% Pricing formula
discountFactor = exp(-r*T);
price = discountFactor*quadl(integrand,-R,R);

