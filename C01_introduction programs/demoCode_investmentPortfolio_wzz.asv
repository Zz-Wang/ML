function demoCode_investmentPortfolio
%% demo_investmentPortfolio: Time series of portfolio values from the series of asset prices (code).
format short

%% load the data 

S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
S = S(1:7,:);  % Look at a short series of prices for all assets

%% Each row corresponds to the time series of prices of an asset
% Time increases with the index of the colums
S = S'

%% D: Number of assets,   N: length of the time series
[D,N] = size(S); 

% start counting at 0
N = N-1;   

%% Plot the time series

%% normalize the prices so that the initial values are equal
initialValue = 100.0;
for d = 1:D
    normalizedS(d,:) = initialValue*S(d,:)/S(d,1);
end

normalizedS

%% plot the normalized prices of the assets in the portfolio
figure(1); clf;
plot(0:N,normalizedS);
axis('tight')
xlabel('time (in days)');
legend('IBM','GOOG','SI',0);
title('Time series of prices');

%% Build time series of portfolio values

%% define the composition of the portfolio
c = [5; 2; 2];

%% compute series of portfolio values 
P = c'*S       

%% normalize so that the initial values are equal
normalizedP = initialValue*P/P(1)

%% plot the normalized prices of the assets in the portfolio
hold on
plot(0:N,normalizedP,'c');
hold off

axis('tight')
legend('IBM','GOOG','SI','Portfolio',0);
xlabel('time (in days)');
title('Time series of prices');

%% Portfolio weights

%% Compute the time series of portfolio weights

c_repmat = repmat(c,1,N+1)
S
P_repmat = repmat(P,D,1)


%%
w = c_repmat.*S./P_repmat

%% plot the series of portfolio weights
figure(2); clf
plot(0:N,w);
axis([0 N 0 1])
title('Portfolio weights');
legend('IBM','GOOG','SI')

