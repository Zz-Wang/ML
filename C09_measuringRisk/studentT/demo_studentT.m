function demo_studentT
%% demo_studentT: pdf and cdf of a Student's t distribution

%% Location and scale parameters
mu = 0; 
sigma = 1;

%% Degrees of freedom
nu = [1 2 5 30];

%% Range of values for the plot

alpha = 6;
xMin  = mu - alpha*sigma;
xMax  = mu + alpha*sigma;

nPlot = 1000;
xPlot = linspace(xMin,xMax,nPlot);

%% Compute the pdf and the cdf for the plot
for i = 1:length(nu);
    pdfPlot(i,:)  = locationScaleTpdf(xPlot,mu,sigma,nu(i));
    cdfPlot(i,:)  = locationScaleTcdf(xPlot,mu,sigma,nu(i));
    legendText{i} = sprintf('%s = %d','\nu',nu(i));
end

%% Plot pdf and cdf
figure(1); clf;

subplot(2,1,1);      % pdf
plot(xPlot,pdfPlot);
legend(legendText{:})
xlabel('x');
ylabel('tpdf(x;\mu,\sigma,\nu)');

subplot(2,1,2);      % cdf
plot(xPlot,cdfPlot);
xlabel('x');
ylabel('tcdf(x;\mu,\sigma,\nu)');

