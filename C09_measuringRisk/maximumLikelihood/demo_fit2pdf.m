function demo_fit2pdf
%% demo_fit2pdf: model calibration using Maximum Likelihood
%

%% Sample
 
data = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');

% time series of daily closing prices
S_GOOG = data(:,2)';         % row vector [N,1]
 
% time series of daily returns
r_GOOG = log(S_GOOG(2:end)./S_GOOG(1:end-1));   % row vector [N-1,1]

%% Gaussian fit

% seed for the optimization
mu0 = 0.0; 
sigma0 = 1.0;

% uncostrained optimization (simplex)
[LL, mu,sigma] = fit2pdf(r_GOOG,@normpdf,[mu0,sigma0])

% compare to sample mean and stdev
mean(r_GOOG)
std(r_GOOG,1)  

% model pdf
modelPdf = @(x)(normpdf(x,mu,sigma));

% graphical comparison of the fit
figure(1); clf
graphicalComparisonPdf(r_GOOG,modelPdf)
title('Normal fit for log-returns GOOG')
legend('scaled histogram','normpdf(r_{GOOG})')

%% Student's t fit

% seed for the optimization
mu0    = mean(r_GOOG);                  % match first moment
nu0    = 5; 
sigma0 = sqrt(var(r_GOOG)*(nu0-2)/nu0); % match second moment

% costrained optimization
[LL, mu,sigma,nu] = fit2pdf_con(r_GOOG,@locationScaleTpdf,[mu0,sigma0,nu0],...
                                [-Inf 1e-5 1e-5], [Inf Inf Inf])

% model pdf
modelPdf = @(x)(locationScaleTpdf(x,mu,sigma,nu));

% graphical comparison of the fit
figure(2); clf
graphicalComparisonPdf(r_GOOG,modelPdf)
title('t Student fit for log-returns GOOG')
legend('scaled histogram',sprintf('tpdf(r_{GOOG}),%s=%.3g)','\nu',nu))