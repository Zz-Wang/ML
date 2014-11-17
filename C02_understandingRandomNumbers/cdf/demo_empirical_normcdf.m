function demo_empirical_normcdf()
%% demo_empirical_normcdf: Comparison of empirical cdf and normcdf

%% Parameters for N(mu,sigma) distribution
mu = -4; 
sigma = 2;         

%% Generate X ~ N(mu,sigma)
M = 1e2;                    % sample size
X = mu + sigma*randn(M,1);   

%% Compute empirical cdf
xCdf = sort(X);              % sort the values of X
eCdf = empiricalCdf(xCdf,X); % empirical cdf

%% Plot empirical cdf
figure(1);
widthOfLine = 1.5;
stairs(xCdf,eCdf,'LineWidth',widthOfLine); 

%% Plot normcdf
nPlot = 1000;
a = 3; % interval with ~ 99.73 % of the probability
xPlot = linspace(mu-a*sigma,mu+a*sigma);
yPlot = normcdf(xPlot,mu,sigma);
hold on;
plot(xPlot,yPlot,'r','LineWidth',widthOfLine);
hold off;
%
xlabel('x'); ylabel('probability');
legend('empcdf(x)','normcdf(x)',0)
axis('tight')

