function demo_rand
%% demo_rand: Demo for the use of rand
format short
%% generate U ~ U[0,1]
rand

%% generate a new sample U ~ U[0,1]
rand

%% generate a matrix with M rows and N columns of U ~ U[0,1]
M = 3;
N = 5;
rand(M,N)

%% Reproducible results

% store the state of the random number generator in s0
s0 = rand('state');

rand  % sample 1
rand  % sample 2

%% Generate the same sequence

% set the state of the random number generator to s0
rand('state',s0);

rand  % sample 1 
rand  % sample 2 

%% Plot pdf and cdf

nPlot = 1000;
xPlot = linspace(-0.5,1.5,nPlot);
axisPlot = [-0.5 1.5 0 1.1];

% uniform pdf
uniformPdf = zeros(size(xPlot));
uniformPdf((xPlot>=0) & (xPlot<=1)) = 1;

subplot(2,1,2);
plot(xPlot,uniformPdf)
xlabel('u'); ylabel('uniformPdf(u)')
axis(axisPlot)

% uniform cdf
uniformCdf = uniformPdf.*xPlot + (xPlot >=1);

subplot(2,1,1);
plot(xPlot,uniformCdf)
xlabel('u'); ylabel('uniformCdf(u)')
axis(axisPlot)



