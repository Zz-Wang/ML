function graphicalComparisonCdf(X,modelCdf,xMin,xMax)
%% graphicalComparisonCdf: Compare empirical Cdf and modelCdf
%
%% SYNTAX:
%        graphicalComparisonCdf(X,modelCdf,scale)
%
%% INPUT:
%             X : Sample
%      modelCdf : model cdf
%  [xMin, xMax] : range for plot  [default: xMin = min(X); xMax = max(X);] 
%
%% EXAMPLE:
%           mu = 1; sigma = 0.3;
%           M = 1e3;  % sample size
%           S = exp(mu + sigma*randn(M,1));
%           modelCdf = @(S)(logncdf(S,mu,sigma));
%           figure(1); graphicalComparisonCdf(S,modelCdf)
%           title('X ~ LN(mu,sigma)')
% 

%% Default values for 
if (nargin < 4)
    xMax = max(X);
    if (nargin < 3)
        xMin = min(X);
    end    
end

%% Sample as a column vector
X   = X(:);
M   = length(X); % Sample size

%% Compute and plot empirical cdf
xEmpiricalCdf = sort(X);
empiricalCdf  = (1:2:(2*M-1))/(2*M);

stairs(xEmpiricalCdf,empiricalCdf);

%% Compute model cdf
nPlot = 1000; 
xPlot = linspace(xMin,xMax,nPlot);
yPlot = modelCdf(xPlot);

%% Plot model cdf
hold on
plot(xPlot,yPlot,'r','LineWidth',1.5);
hold off
axis('tight')
xlabel('x'); ylabel('cdf(x)');
legend('empirical','cdf(x)',0)
