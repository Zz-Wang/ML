function x = locationScaleTinv(p,mu,sigma,nu)
%% locationScaleTinv: Stutent's t inv with location and scale parameters
%
%% SYNTAX:
%         x = locationScaleTinv(p,mu,sigma,nu)
%
%% INPUT:
%             p : probability level (0 < p < 1)
%            mu : Location parameter
%         sigma : Scale parameter
%            nu : Degrees of freedom
%
%% OUTPUT:
%             x : value of the inv
%
%% EXAMPLE:   
%        mu    = 3; 
%        sigma = 2;
%        nu    = 2.5;
%        x0    = 4;
%        p0 = locationScaleTcdf(x0,mu,sigma,nu)
%        x0 = locationScaleTinv(p0,mu,sigma,nu)

%%  Inverse of the cdf for location and scale Student's t distribution
x = mu + sigma*tinv(p,nu);

