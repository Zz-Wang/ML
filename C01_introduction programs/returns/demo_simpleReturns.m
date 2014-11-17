function demo_simpleReturns
%% demo_simpleReturns: Properties of returns in a time series

%% Load the data 

S         = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
titleText = {'IBM','GOOG','SI'};

S = S'; 
% each row corresponds to the time series of prices of an asset
% time increases with the index of the columns

% D: Number of assets,   N: length of the time series
[D,N] = size(S);

N = N-1; % start counting at zero

%% Compute the asset returns

R = 100.0*(S(:,2:end)./S(:,1:end-1) - 1.0);

%% Plot the time series of prices and returns of the assets

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
 
    % plot time series of returns
    subplot(2,1,2)
    plot(0:N-1,R(d,:),'LineWidth',1);
    xlabel('time (in days)');
    ylabel('daily return');
    axis('tight')
   
    % title
    subplot(2,1,1)
    title(titleText{d});
    pause
end

%% Build time series of portfolio values

% define the composition of the portfolio
c = [500; 200; 200];

% compute series of portfolio values 
P = c'*S;       

% compute the time series of portfolio weights
w = repmat(c,1,N+1).*S./repmat(P,D,1);

% compute the time series of portfolio returns
portfolioReturn = 100.0*(P(2:end)./P(1:end-1) - 1.0);


%% Plot time series of portfolio values and returns

nFigure = nFigure + 1;
figure(nFigure); clf;

% Plot time series of portfolio values
subplot(2,1,1)
plot(0:N,S(d,:));
xlabel('time (in days)');
ylabel('price');
axis('tight')

% Plot time series of returns
subplot(2,1,2)
plot(0:N-1,portfolioReturn,'LineWidth',1);
xlabel('time (in days)');
ylabel('daily return');
axis('tight')

subplot(2,1,1)
title('Portfolio');

%% An equivalent form of computing the portfolio returns

% compute the returns of the portfolio from the portfolio weights
portfolioReturn_w = sum(w(:,1:end-1).*R);

