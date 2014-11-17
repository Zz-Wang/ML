function E_g = expectedValue(g,f_X,xLow,xUpp)
%% expectedValue: Compute E[g(X)],  X ~ f_X(x)
%
%% SYNTAX:
%          E_g = expectedValue(g,f_X,xLow,xUpp)
%
%% INPUT:
%            g :  handle to the function g(X)
%          f_X : X ~ f_X
%  [xLow,xUpp] :  XLow <= X <= xUpp 
%
%% OUTPUT: 
%          E_g : E[g(X) | XLow <= X <= xUpp]               
%
%% EXAMPLE;
%          mu = 2; sigma = 3;
%          R = 10;
%          xLow = mu - R*sigma;
%          xUpp = mu + R*sigma;
%          f_X = @(x)(normpdf(x,mu,sigma));
%          mu_2 = expectedValue(@(x)((x-mu).^2),f_X,xLow,xUpp);
%          mu_3 = expectedValue(@(x)((x-mu).^3),f_X,xLow,xUpp);
%          mu_4 = expectedValue(@(x)((x-mu).^4),f_X,xLow,xUpp);
%          asymmetry = mu_3/mu_2^(3/2) 
%          kurtosis  = mu_4/mu_2^2
%
TOL = 1e-10;
integrand = @(x)(f_X(x).*g(x));
E_g = quadl(integrand,xLow,xUpp,TOL)/quadl(f_X,xLow,xUpp,TOL);