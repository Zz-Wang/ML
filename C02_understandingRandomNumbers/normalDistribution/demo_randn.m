function demo_randn
%% demo_randn: Demo for the use of randn

%% Generate X ~ N[0,1]
randn

%% Generate a new sample X ~ N[0,1]
randn

%% Generate a matrix with M rows and N columns of X ~ N[0,1]
M = 3;
N = 5;
randn(M,N)

%% Plot pdf and cdf
nPlot = 1000;
alpha = 3;
xPlot = linspace(-alpha,alpha,nPlot);

figure(1); clf

% normal pdf
normalPdf = normpdf(xPlot);

subplot(2,1,2);
plot(xPlot,normalPdf)
xlabel('x'); ylabel('normdf(x)')
axis ([-alpha alpha 0 1.1*normpdf(0)]);

% normal cdf
normalCdf = normcdf(xPlot);

subplot(2,1,1);
plot(xPlot,normalCdf)
xlabel('x'); ylabel('normcdf(x)')
axis ([-alpha alpha 0 1.01]);
