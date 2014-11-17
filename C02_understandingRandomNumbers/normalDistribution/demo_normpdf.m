function demo_normpdf
%% demo_normpdf: Plot normpdf

%% Parameters for the plot
mu    = 4; 
sigma = 2;

alpha = 4;
xMin = mu - alpha*sigma;
xMax = mu + alpha*sigma;

nPlot = 1000;
xPlot = linspace(xMin,xMax,nPlot);

%% Plot normpdf
normalPdf = normpdf(xPlot,mu,sigma);

figure(1); clf
plot(xPlot,normalPdf)
xlabel('x'); ylabel('normpdf(x)')
axis ([xMin xMax 0 1.1*normpdf(mu,mu,sigma)]);

%% Symmetric intervals around the mean
figure(2); clf
plot(xPlot,normalPdf)
xlabel('x'); ylabel('normpdf(x)')
axis ([xMin xMax 0 1.1*normpdf(mu,mu,sigma)]);

for alpha = 0:3
   xLower = mu-alpha*sigma;
   xUpper = mu+alpha*sigma;
   hold on
   plot([xLower xLower],[0 normpdf(xLower,mu,sigma)],'k','LineStyle',':');
   plot([xUpper xUpper],[0 normpdf(xUpper,mu,sigma)],'k','LineStyle',':');
   hold off 
end