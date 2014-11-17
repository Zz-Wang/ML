function demo_logReturns
%% demo_logReturns: Properties of log returns in a time series

%% Load the data 

S         = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
titleText = {'IBM','GOOG','SI'};

S = S'; 
% each row corresponds to the time series of prices of an asset
% time increases with the index of the columns

% D: Number of assets,   N: length of the time series
[D,N] = size(S);

N = N-1; % start counting at zero


%% Compute the asset log returns

r = log(S(:,2:end)./S(:,1:end-1));

%% Plot the log returns of the assets

nFigure = 0;
for d = 1:D
    nFigure = nFigure +1;
    figure(nFigure); clf;

    % plot time series of prices
    subplot(2,1,1)
    plot(0:N,S(d,:));
    xlabel('time (in days)');
    ylabel('price');
    axis('tight')

    % plot time series of log returns
    subplot(2,1,2)
    plot(0:N-1,r(d,:),'LineWidth',1);
    xlabel('time (in days)');
    ylabel('daily log return');
    axis('tight')
    % title 
    subplot(2,1,1)
    title(titleText{d});
    pause    
end
