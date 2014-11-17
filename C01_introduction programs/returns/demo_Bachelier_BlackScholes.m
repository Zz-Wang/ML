function demo_Bachelier_BlackScholes()
%% demo_Bachelier_BlackScholes: Compare Bachelier and Black-Scholes models

%% Load the data 
S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
S = S(:,1);  % Look at a short series of prices for one asset

%% Bachelier model
dS = diff(S);       % should be normal

%% Black-Scholes model
r = diff(log(S));   % should be normal

%% Comparison between price changes and log-returns
figure(1); clf

nBins    = 100;
centers  = linspace(-10,10,nBins);
axisPlot = [-10 10 0 180];

subplot(1,2,1);
hist(dS/iqr(dS),centers); % normalize by interquartile range
axis(axisPlot);
title('Normalized price changes')

subplot(1,2,2);
hist(r/iqr(r),centers);   % normalize by interquartile range
axis(axisPlot);
title('Normalized log-returns')

