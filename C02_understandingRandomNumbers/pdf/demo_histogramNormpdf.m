function demo_histogramNormpdf
%% demo_histogramNormpdf: Comparison of histogram and normpdf

%%  Parameters 

% Simulate N(mu,sigma)
mu = -4; sigma = 2;         

% sample size
M = 1e4;   
                 
% X ~ N(mu,sigma)
X = mu + sigma*randn(M,1);  

%% Compare histogram with scaled pdf

%% Plot histogram
figure(1); 
nBins = 40;    % number of bins for the histogram
hist(X,nBins); % generate histogram
axis('tight')

% base of histogram
xMin = min(X); 
xMax = max(X);

% area of histogram
areaHistogram = (xMax-xMin)*M/nBins; 

%% Plot scaled pdf

% compute values of the pdf in [xMin,xMax]
nPlot = 1000; 
xPlot = linspace(xMin,xMax,nPlot);
yPlot = normpdf(xPlot,mu,sigma);

% plot scaled pdf
hold on
plot(xPlot,yPlot*areaHistogram,'r','LineWidth',1.5);
hold off;
xlabel('x'); ylabel('count');
legend('histogram','scaled normpdf(x)')


%% Compare scaled histogram with pdf

%% plot scaled histogram
figure(2);
[barHeight,barCenter] = hist(X,nBins);
bar(barCenter,barHeight/areaHistogram,1);
axis('tight')

%% plot pdf
hold on
plot(xPlot,yPlot,'r','LineWidth',1.5);
hold off
xlabel('x'); ylabel('pdf(x)');
legend('scaled histogram','normpdf(x)')

