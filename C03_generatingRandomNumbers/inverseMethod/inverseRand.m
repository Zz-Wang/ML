function X = inverseRand(M,N,invcdf)
%% inverseRand: Generation of random numbers using the method of the inverse
%
%% SYNTAX:
%         X = inverseRand(M,N,invcdf)
%
%% INPUT:
%      [M,N]: Dimensions of the output matrix
%    invcdf : Handle to the inverse of the cdf
%
%% OUTPUT:
%        X : random sample [M,N]    
%
%% EXAMPLE:
%        mu = 1; sigma = 0.3;
%        M = 1e3;  N = 100; % sample size
%        invcdf = @(p)(norminv(p,mu,sigma));
%        X = inverseRand(M,N,invcdf);
%        modelPdf = @(x)(normpdf(x,mu,sigma));
%        figure(1); graphicalComparisonPdf(X(:),modelPdf)
%        title('X ~ N(mu,sigma)')       
%

%% Sample from U[0,1]
U = rand(M,N);

%% Method of the inverse
X = invcdf(U);
