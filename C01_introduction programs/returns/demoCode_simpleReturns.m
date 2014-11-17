function demoCode_simpleReturns
%% demoCode_simpleReturns: Properties of returns in a time series

%% Load the data 

S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
titleText = {'IBM','GOOG','SI'};
S = S(1:7,:);  % Look at a short series of prices for all assets

% each row corresponds to the time series of prices of an asset
% time increases with the index of the columns
S = S' 

%% D: Number of assets,   N: length of the time series
[D,N] = size(S);

%% Compute the asset returns

R = 100.0*(S(:,2:end)./S(:,1:end-1) - 1.0)

%% Build time series of portfolio values

%% define the composition of the portfolio
c = [5; 2; 2];

%% compute series of portfolio values 
P = c'*S       

%% compute the time series of portfolio weights
w = repmat(c,1,N).*S./repmat(P,D,1)

%% compute the time series of portfolio returns
portfolioReturn = 100.0*(P(2:end)./P(1:end-1) - 1.0)

%% An alternative form of computing the portfolio returns

%% compute the returns of the portfolio from the portfolio weights
portfolioReturn_w = sum(w(:,1:end-1).*R)

