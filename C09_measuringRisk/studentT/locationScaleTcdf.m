function F = locationScaleTcdf(x,mu,sigma,nu)
%% locationScaleTcdf: Stutent's t cdf with location and scale parameters
%
%% SYNTAX:
%         F = locationScaleTcdf(x,mu,sigma,nu)
%
%% INPUT:
%             x : Sample
%            mu : Location parameter
%         sigma : Scale parameter
%            nu : Degrees of freedom
%
%% OUTPUT:
%             F : value of the cdf
%
%% EXAMPLE:   
%        mu    = 3; 
%        sigma = 2;
%        nu    = 2.5;
%        x0    = 4;
%        locationScaleTcdf(x0,mu,sigma,nu)
%        quadl(@(x)(locationScaleTpdf(x,mu,sigma,nu)),-1000,x0)

%%  Cdf for location and scale Student's t distribution
F = tcdf((x-mu)/sigma,nu);
