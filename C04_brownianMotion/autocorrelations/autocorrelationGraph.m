function [corr, absCorr] = autocorrelationGraph(X,maxLag,plotCorrAbs)
%% autocorrelationGraph: Plot autocorrelations of time series + of absolute values
%
%% SYNTAX:
%        [corr, absCorr] = autocorrelationGraph(X,maxLag,plotCorrAbs)
%
%% INPUT:
%           X : Time series
%      maxLag : Maximum delay for correlations
% plotCorrAbs : Plot correlations of the absolute values of X as well
%       
%% OUTPUT:
%		corr	: Autocorrelations for the time series
%		absCorr	: Autocorrelations for the absolute value of the time series
%
%% EXAMPLE:
%       N = 1000;                 % length of simulation
%       phi0 = 0.0; phi1 = 0.8;   % AR(1) coefficients
%       sigma = 1.0;              % stdev of the noise term
%       X = zeros(1,N);
%       X(1) = 0.0;               % initial value
%       for n = 1:N
%           X(n+1) = phi0 + phi1*X(n) + sigma*randn;
%       end
%       figure(1); clf
%       autocorrelationGraph(X);
%

%% Defaults
if(nargin<3)
    plotCorrAbs = 0;
    if(nargin < 2)
        maxLag = 30;
    end
end

%% Compute the autocorrelations
[tau, corr]    = autocorrelations(X,maxLag);
[tau, absCorr] = autocorrelations(abs(X),maxLag);

%% Plot the autocorrelations
ul = 2*ones(size(tau))/sqrt(length(X));

if plotCorrAbs
    subplot(2,1,1);
    auxPlot(tau,corr,ul,maxLag)
    title('Autocorrelations of X');

    subplot(2,1,2);
    auxPlot(tau,absCorr,ul,maxLag)
    title('Autocorrelations of |X|');    
else 
    auxPlot(tau,corr,ul,maxLag)
end

%% Auxiliary function for plots
function auxPlot(tPlot,y,ul,maxLag)
bar(tPlot,y);
hold on; plot(tPlot,ul,'r',tPlot,-ul,'r'); hold off
axis('tight')
xlabel('delay');
ylabel('correlation');