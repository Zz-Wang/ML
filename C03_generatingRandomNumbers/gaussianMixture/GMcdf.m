function y = GMcdf(x,p,mu,sigma)
%% GMcdf: cdf for a mixture of K Gaussians GM[p,mu,sigma]
%
%% SYNTAX:
%         y = GMcdf(x,p,mu,sigma)
%
%% INPUT:
%         p : Probability vector  [Kx1]
%        mu : Vector of means     [Kx1]
%     sigma : Vector of stdev's   [Kx1]
%
%% OUTPUT:
%         y : Value of the cdf [same size as x]  
%
%% EXAMPLE:
%
%   p     = [ 1/2 1/3  1/6];  % probability vector 
%   mu    = [-1.0 4.0 12.0];  % means 
%   sigma = [ 1.0 3.0  0.5];  % standard deviations
% 
%   x0 = 1.0;   GMcdf(x0,p,mu,sigma)
%   
%   % numerical quadrature of pdf
%   R = 10; x_inf = min(mu-R*sigma); % lower bound of numerical support of cdf 
%   quadl(@(x)GMpdf(x,p,mu,sigma),x_inf,x0)

%%  Number of Gaussians in the mixture
K = length(p);

%%  Compute pdf 
y = zeros(size(x));
for k = 1:K
    y = y + p(k)*normcdf(x,mu(k),sigma(k)); 
end