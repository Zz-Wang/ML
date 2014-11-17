function f = locationScaleTpdf(x,mu,sigma,nu)
%% locationScaleTpdf: Stutent's t pdf with location and scale parameters
%
%% SYNTAX:
%         f = locationScaleTpdf(x,mu,sigma,nu)
%
%% INPUT:
%             x : Sample
%            mu : Location parameter
%         sigma : Scale parameter
%            nu : Degrees of freedom
%
%% OUTPUT:
%             f : value of the pdf
%
%% EXAMPLE:   
%        mu    = 3; 
%        sigma = 2;
%        nu    = 2.5;
%        x0    = 4;
%        locationScaleTpdf(x0,mu,sigma,nu)
%        h = 1e-5;
%        numericalDerivative(@(x)(locationScaleTcdf(x,mu,sigma,nu)),x0,h)

%%  Pdf for location and scale Student's t distribution
f = tpdf((x-mu)/sigma,nu)/sigma;
