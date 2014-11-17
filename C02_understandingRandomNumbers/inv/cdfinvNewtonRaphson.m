function x = cdfinvNewtonRaphson(p,pdf,cdf,x0)
%% cdfinvNewtonRaphson: inverse of a cdf using the Newton-Raphson method
%
%% SYNTAX:
%        x = cdfinvNewtonRaphson(p,pdf,cdf,x0)
%
%% INPUT:
%        p  : probability  0 <= p <= 1
%      pdf  : probability density function
%      cdf  : cumulative distribution function
%       x0  : seed
%
%% OUTPUT:
%        x  : cdf(x) = p
%              
%
%% EXAMPLE:   
%      M = 1000; 
%      p = rand(M,1);
%      mu = 1; sigma = 3;
%      pdf = @(x)normpdf(x,mu,sigma);
%      cdf = @(x)normcdf(x,mu,sigma);
%      x0  = mu;
%      X   = cdfinvNewtonRaphson(p,pdf,cdf,x0);
%      figure(1); clf;
%      graphicalComparisonPdf(X,pdf)


%% Parameters for convergence criteria
MAXITER = 100;    % maximum number of iterations
TOLABS  = 1.0e-6; % maximum absolute error

%% Initial seed
x  = x0*ones(size(p));

%% Newton-Raphson
dx = 10*TOLABS;
nIter = 0;
while (nIter < MAXITER) && (any(abs(dx(:)) > TOLABS))
    nIter = nIter +1;
    % iteration of the algorithm
    dx = (cdf(x)-p)./pdf(x); % vectorized
    x  = x - dx; 
end

%% Warnings
if (nIter == MAXITER)
    warning('Maximum number of iterations in NR reached')
end