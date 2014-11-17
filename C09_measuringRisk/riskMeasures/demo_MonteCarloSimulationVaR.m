function demo_MonteCarloSimulationVaR
%% demo_MonteCarloSimulationVaR: Monte Carlo simulation for VaR

%% Load the data
S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');

%% Select data in the recent past
N  = 500;

S_IBM   = S(end-N:end,1);
S0_IBM  = S_IBM(end);

S_GOOG  = S(end-N:end,2);
S0_GOOG = S_GOOG(end);


%% Compute historical log returns for the specified time horizon (DeltaT)

% horizon for the risk measures (VaR, ES)
horizon = 5;  

indices = N+1:-1:horizon+1;          % overlapping intervals
% indices = N+1:-horizon:horizon+1;  % non-overlapping intervals
indices = indices(end:-1:1);

% New sample size
N = length(indices);

r_IBM  = log(S_IBM(indices)  ./ S_IBM(indices-horizon));
r_GOOG = log(S_GOOG(indices) ./ S_GOOG(indices-horizon));

%% Student's t fit for the marginals of the log returns

% Degrees of freedom: seed for the optimization
nu0 = 5; 

% Student's t fit for IBM
[mu_IBM,sigma_IBM,nu_IBM,modelPdf_IBM,modelCdf_IBM,modelInv_IBM] = ...
    fit2StudentT(r_IBM,nu0);
nu_IBM

% Student's t fit for GOOG
[mu_GOOG,sigma_GOOG,nu_GOOG,modelPdf_GOOG,modelCdf_GOOG,modelInv_GOOG] = ...
    fit2StudentT(r_GOOG,nu0);
nu_GOOG

%% Gaussian copula for the joint distribution of log returns

% Transform to U[0,1] marginals
u_IBM  = modelCdf_IBM(r_IBM); 
u_GOOG = modelCdf_GOOG(r_GOOG);

% Gaussian copula fit
rho = corr([norminv(u_IBM) norminv(u_GOOG)]);

%% Portfolio composition
c_IBM_asset        = 500;  % IBM shares
c_GOOG_asset       = 200;  % GOOG shares
c_IBM_call         = 5000; % European call on IBM
c_GOOG_asianCallAM = 2000; % Arithmetic mean Asian call on GOOG

%% Portfolio value at t0

%% Value of the European call option on IBM
r = 0.01;  % risk-free interest rate
T = 1;     % time to maturity
K = 180;   % Strike

nDaysInYear = 252;  % number of trading days in a year
% sigma_IBM   = sqrt(nDaysInYear/horizon)*std(r_IBM); % annualized historical volatity
sigma_IBM   = 0.16;                                 % implied volatility in a call on IBM  

payoff_call    = @(ST)(max(ST-K,0));
price_IBM_call = priceEuropeanOption(S0_IBM,r,T,sigma_IBM,payoff_call)

%% Value of an Asian call option on the arithmetic mean of Google
N_AM = 6;    % Number of monitoring times for the arithmetic mean 
T    = 0.5;  % Time to maturity
M_AM = 1e3;  % Number of simulated trajectories
K    = 880;  % Strike of the Asian arithmetic mean call option

sigma_GOOG   = sqrt(nDaysInYear/horizon)*std(r_GOOG); % annualized historical volatity

[price_GOOG_asianCallAM,stdev_MC] = ...
    priceAsianArithmeticMeanCallMC_controlVariate(S0_GOOG,K,r,T,sigma_GOOG,M_AM,N_AM)

%% Value of the portfolio at t0
P0 = c_IBM_asset        * S0_IBM         + ...
     c_IBM_call         * price_IBM_call + ...
     c_GOOG_asset       * S0_GOOG        + ...
     c_GOOG_asianCallAM * price_GOOG_asianCallAM
 
%% Monte Carlo simulation

% Simulate M scenarios
M = 1e3; 

%% Simulate the log returns from the multivariate model

% Student's t marginals + Gaussian copula

% Gaussian copula sample
U = gaussianCopulaRand(M,rho);

% Incorporate marginals
simulated_r_IBM  = modelInv_IBM(U(:,1));
simulated_r_GOOG = modelInv_GOOG(U(:,2));

%% Simulate the prices of the assets at t0 + DeltaT

simulated_ST_IBM  = S0_IBM*exp(simulated_r_IBM);
simulated_ST_GOOG = S0_GOOG*exp(simulated_r_GOOG);

%% Simulate the prices of the derivatives at t0 + DeltaT

simulated_price_IBM_call = zeros(M,1);
simulated_price_GOOG_asianCallAM = zeros(M,1);
for m = 1:M
    % disp(M-m) % monitor the number of pending simulations
    
    %% IBM:  Call option
    simulated_price_IBM_call(m) = ...
        priceEuropeanOption(simulated_ST_IBM(m),r,T,sigma_IBM,payoff_call);
    
    %% GOOG: Call on the arithmetic mean
    simulated_price_GOOG_asianCallAM(m) =...
        priceAsianArithmeticMeanCallMC_controlVariate...
        (simulated_ST_GOOG(m),K,r,T,sigma_GOOG,M_AM,N_AM);
end

%% Simulated portfolio value at t0 + DeltaT
simulated_PT = c_IBM_asset        * simulated_ST_IBM         + ...
               c_IBM_call         * simulated_price_IBM_call + ...
               c_GOOG_asset       * simulated_ST_GOOG        + ...
               c_GOOG_asianCallAM * simulated_price_GOOG_asianCallAM;

%% Simulated losses
simulated_Loss = -(simulated_PT-P0);

%% Risk measures 
p         = 0.95;  % probability level for the risk measures
VaR       = quantile(simulated_Loss,p)
indexTail = simulated_Loss > VaR;
ES        = mean(simulated_Loss(indexTail))

%% Risk measures as a percentage of the current portfolio value
100*VaR/P0
100*ES/P0

%% Plot the results
figure(1);
nBins = 50;
hist(simulated_Loss,nBins);
hold on;
plot(VaR,0,'rx');
plot(ES,0,'ro');
hold off;

legend('Losses','VaR','ES',2);

