function demo_investmentPortfolio
%% demo_investmentPortfolio: Time series of portfolio values from the series of asset prices.

%% load the data 

S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');

% Each row corresponds to the time series of prices of an asset
% Time increases with the index of the colums
S = S'; 

% D: Number of assets,   N: length of the time series
[D,N] = size(S);

N = N-1; % start counting at zero

%% Plot the time series

% normalize the prices so that the initial values are equal
initialValue = 100.0;
for d = 1:D
    normalizedS(d,:) = initialValue*S(d,:)/S(d,1);
end

% plot the normalized prices of the assets in the portfolio
figure(1); clf;
plot(0:N,normalizedS);

%% Build time series of portfolio values

% define the composition of the portfolio
c = [500; 200; 200];

% compute series of portfolio values 
P = c'*S;       

% normalize so that the initial values are equal
normalizedP = initialValue*P/P(1);

% plot the normalized prices of the assets in the portfolio
hold on
plot(0:N,normalizedP,'c');
hold off

axis('tight')
legend('IBM','GOOG','SI','Portfolio',0);
title('Time series of prices');

%% Portfolio weights

% compute the time series of portfolio weights
w = repmat(c,1,N+1).*S./repmat(P,D,1);

% plot the series of portfolio weights
figure(2); clf
plot(0:N,w);
axis([0 N 0 1])
title('Portfolio weights');
legend('IBM','GOOG','SI')

