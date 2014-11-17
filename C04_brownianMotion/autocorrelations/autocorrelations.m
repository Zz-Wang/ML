function [tau, corr] = autocorrelations(X,maxLag)
%% autocorrelations:  compute autocorrelations for the time series X
%
%% SYNTAX:
%        [tau, corr] = autocorrelations(X,maxLag)
%
%% INPUT:
%   	X	    : Time series
%   	maxLag	: Maximum delay for correlations
%
%% OUTPUT:
%       tau     : Vector of delays
%		corr	: Autocorrelations for the time series
%
%% EXAMPLE:
%         N = 1000;    % length of simulation
%         phi0 = 0.0; phi1 = 0.8;   % AR(1) coefficients
%         sigma = 1.0;  % stdev of innovations
%         X(1)  = 0.0;  % initial value
%         for n = 1:N
%             X(n+1) = phi0 + phi1*X(n) + sigma*randn;
%         end
%         maxLag = 30;
%         [tau, corr] = autocorrelations(X,maxLag);
%         figure(1); clf
%         bar(tau,corr)
%         xlabel('delay'); ylabel('autocorrelations')
%         axis('tight')

%   Copyright Alberto Suarez 
%   $Revision: 0.0 $  $Date: 2013/07/10 09:00:00 $


%% Remove the mean
X = X(:) - mean(X); 

%% Compute the autocorrelations
T = length(X);
for tau = 1:maxLag+1

    indices        = tau:T;
    delayedIndices = 1:(T-(tau-1));
    
    % compute the autocovariances
    corr(tau) = sum(X(indices).*X(delayedIndices))/T; % assume T >> tau for normalization
end

%% normalize to obtain the autocorelations
corr = corr/corr(1);  

%% Vector of delays
tau = 0:maxLag; 
