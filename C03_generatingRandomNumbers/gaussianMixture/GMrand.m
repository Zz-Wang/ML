function Z = GMrand(M,N,p,mu,sigma)
%% GMrand: generator of rv's for a mixture of K Gaussians GM[p,mu,sigma]
%
%% SYNTAX:
%         Z = GMrand(M,N,p,mu,sigma)
%
%% INPUT:
%       M,N : Rows and columns for the matrix of random samples
%        mu : Vector of means     [Kx1]
%     sigma : Vector of stdev's   [Kx1]
%
%% OUTPUT:
%         Z : Sample from GM[p,mu,sigma] [MxN]  
%
%% EXAMPLE:
%
%   %% Sample matrix (M rows, N columns) 
%   M = 1000;
%   N = 100;
%   %% Gaussian components
%   p     = [ 1/2 1/3  1/6];  % probability vector 
%   mu    = [-1.0 4.0 12.0];  % means 
%   sigma = [ 1.0 3.0  0.5];  % standard deviations
%
%   %% Generate sample Z ~ GM[p,mu,sigma)
%   Z = GMrand(M,N,p,mu,sigma);
%
%   %% Compare modelPdf and scaled histogram
%   modelPdf = @(z)(GMpdf(z,p,mu,sigma));
%   figure(1); graphicalComparisonPdf(Z(:),modelPdf)
%   title('Z ~ GM[p,\mu,\sigma]')
%

%% p, mu, sigma should be column vectors
p = p(:); 
mu = mu(:); 
sigma = sigma(:); 

%% Simulate a matrix (M rows, N columns) of  Categorical[p,K]
xi = categoricalRand(M,N,p);    % xi ~ Categorical[p,K]

%% Simulate a matrix (M rows, N columns) of  GM[p,mu,sigma] random numbers (vectorized)
X = randn(M,N);
if M == 1
    Z = mu(xi)' + sigma(xi)' .* X; 
else
    Z = mu(xi) + sigma(xi) .* X;
end


%% Simulate a matrix (M rows, N columns) of  GM[p,mu,sigma] random numbers  (uses for loops)
% for m = 1:M
%     for n = 1:N
%         % Simulate the claim amount
%         Z(m,n) = mu(xi(m,n)) + sigma(xi(m,n)) * X(m,n)
%     end
% end