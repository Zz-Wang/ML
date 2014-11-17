function y = GMpdf(x,p,mu,sigma)
%% GMpdf: pdf for a mixture of K Gaussians GM[p,mu,sigma]
%
%% SYNTAX:
%         y = GMpdf(x,p,mu,sigma)
%
%% INPUT:
%         p : Probability vector  [Kx1]
%        mu : Vector of means     [Kx1]
%     sigma : Vector of stdev's   [Kx1]
%
%% OUTPUT:
%         y : Value of the pdf [same size as x]  
%
%% EXAMPLE:
%
%   p     = [ 1/2 1/3  1/6];  % probability vector 
%   mu    = [-1.0 4.0 12.0];  % means 
%   sigma = [ 1.0 3.0  0.5];  % standard deviations
% 
%   x0 = 1.0;   GMpdf(x0,p,mu,sigma)
%   
%   % numerical derivative of cdf
%   h = 1e-5; (GMcdf(x0*(1+h),p,mu,sigma)-GMcdf(x0*(1-h),p,mu,sigma))/(2*x0*h)  
%

%%  Number of Gaussians in the mixture
K = length(p);

%%  Compute pdf 
y = zeros(size(x));
for k = 1:K
    y = y + p(k)*normpdf(x,mu(k),sigma(k)); 
end