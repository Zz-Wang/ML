function demo_GaussianMixtureK_randomNumberGenerator
%% demo_GaussianMixtureK_randomNumberGenerator: generate GM[p,mu,sigma] random numbers

%% Sample matrix (M rows, N columns) 
M = 1000;
N = 100;

%% Gaussian components
p     = [ 1/2; 1/3;  1/6];  % probability vector 
mu    = [-1.0; 4.0; 12.0];  % means 
sigma = [ 1.0; 3.0;  0.5];  % standard deviations


%% Simulate a matrix (M rows, N columns) of  Categorical[p,K]
xi = categoricalRand(M,N,p);    % xi ~ Categorical[p,K]

%% Simulate a matrix (M rows, N columns) of  GM[p,mu,sigma] random numbers
X  = randn(M,N);
if (M == 1)
    % Needed to ensure correct dimensions of mu(xi) and sigma(xi)
    Z = mu(xi)' + sigma(xi)' .* X;
else
    Z = mu(xi) + sigma(xi) .* X;    
end

%% Compare modelPdf and scaled histogram

modelPdf = @(z)(GMpdf(z,p,mu,sigma));
figure(1); graphicalComparisonPdf(Z(:),modelPdf)
title('Z ~ GM[p,\mu,\sigma]')
                   
