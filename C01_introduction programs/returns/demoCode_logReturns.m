function demoCode_logReturns
%% demoCode_logReturns: Properties of log returns in a time series

%% Load the data 
format short;
S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
S = S(1:7,1);  % Look at a short series of prices for one asset

% each row corresponds to the time series of prices of an asset
% time increases with the index of the columns
S = S' 

%% Compute the asset log returns

r = log(S(2:end)./S(1:end-1))

%% Aggregation of the log returns in time

format long

%% The log return for the whole period
disp(log(S(end)/S(1)))

%% is the sum of the log returns for each of the subperiods
disp(sum(r))

