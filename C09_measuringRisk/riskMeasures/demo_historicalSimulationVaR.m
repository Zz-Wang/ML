function demo_historicalSimulationVaR
%% demo_historicalSimulationVaR: Historical simulation for VaR

%% Load the data
S = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');

%% Select data in the recent past
N  = 500;

S_IBM   = S(end-N:end,1);
S0_IBM  = S_IBM(end);

S_GOOG  = S(end-N:end,2);
S0_GOOG = S_GOOG(end);


%% Compute the historical returns for the specified time horizon (DeltaT)

% horizon for the risk measures (VaR, ES)
horizon = 5; 

indices = N+1:-1:horizon+1;          % overlapping intervals
% indices = N+1:-horizon:horizon+1;  % non-overlapping intervals
indices = indices(end:-1:1);

% New sample size
N = length(indices);

r_IBM  = log(S_IBM(indices)./S_IBM(indices-horizon));
r_GOOG = log(S_GOOG(indices)./S_GOOG(indices-horizon));

%% Portfolio composition
c_IBM_asset        = 500;  % IBM shares
c_GOOG_asset       = 200;  % GOOG shares
c_IBM_call         = 5000; % European call on IBM
c_GOOG_asianCallAM = 2000; % Arithmetic mean Asian call on GOOG

%% Portfolio value at t0

%% Value of the European call option on IBM
r = 0.01;  % risk-free interest rate
T = 1;     % time to maturity
K = 180;   % Strike for the European call option

nDaysInYear = 252;  % number of trading days in a year
% sigma_IBM   = sqrt(nDaysInYear/horizon)*std(r_IBM); % annualized historical volatity
sigma_IBM   = 0.16;                                   % implied volatility in a call on IBM

payoff_call    = @(ST)(max(ST-K,0));
price_IBM_call = priceEuropeanOption(S0_IBM,r,T,sigma_IBM,payoff_call);

%% Value of an Asian call option on the arithmetic mean of Google
N_AM = 6;    % Number of monitoring times for the arithmetic mean 
T    = 0.5;  % Time to maturity
M_AM = 1e3;  % Number of simulated trajectories
K    = 880;  % Strike of the Asian arithmetic mean call option

sigma_GOOG   = sqrt(nDaysInYear/horizon)*std(r_GOOG); % annualized historical volatity

[price_GOOG_asianCallAM,stdev_MC] = ...
    priceAsianArithmeticMeanCallMC_controlVariate(S0_GOOG,K,r,T,sigma_GOOG,M_AM,N_AM)

%% Value of the portfolio
P0 = c_IBM_asset*S0_IBM       + ...
     c_IBM_call*price_IBM_call  + ...
     c_GOOG_asset*S0_GOOG     + ...
     c_GOOG_asianCallAM*price_GOOG_asianCallAM;

w_IBM_asset        = c_IBM_asset*S0_IBM/P0
w_IBM_call         = c_IBM_call*price_IBM_call/P0 
w_GOOG_asset       = c_GOOG_asset*S0_GOOG/P0
w_GOOG_asianCallAM = c_GOOG_asianCallAM*price_GOOG_asianCallAM/P0
 
%% Historical (bootstrap) simulation

% Simulate M scenarios
M = 1e4; 

%% Simulate the prices of the underlying at t0 + DeltaT

bootstrapIndices = ceil(rand(M,1)*N);

% IBM
simulated_r_IBM  = r_IBM(bootstrapIndices);
simulated_ST_IBM = S0_IBM*exp(simulated_r_IBM);

% bootstrapIndices = ceil(rand(M,1)*N);              % No dependencies (lower risk measures)
% If previous line commented: common random numbers  % Takes into account dependencies

% GOOG
simulated_r_GOOG  = r_GOOG(bootstrapIndices);
simulated_ST_GOOG = S0_GOOG*exp(simulated_r_GOOG);

%% Compute the prices of the derivatives at t0 + DeltaT

simulated_price_IBM_call = zeros(M,1);
simulated_price_GOOG_asianCallAM = zeros(M,1);
for m = 1:M
    % disp(M-m) % monitor simulations
    
    %% IBM:  Call option
    simulated_price_IBM_call(m) = ...
        priceEuropeanOption(simulated_ST_IBM(m),r,T,sigma_IBM,payoff_call);
    
    %% GOOG: Call on the arithmetic mean
    simulated_price_GOOG_asianCallAM(m) =...
        priceAsianArithmeticMeanCallMC_controlVariate(simulated_ST_GOOG(m),...
                                                      K,r,T,sigma_GOOG,M_AM,N_AM);
end

%% Simulated portfolio value at t0 + DeltaT
simulated_PT = c_IBM_asset*simulated_ST_IBM        + ...
               c_IBM_call*simulated_price_IBM_call + ...
               c_GOOG_asset*simulated_ST_GOOG      + ...
               c_GOOG_asianCallAM*simulated_price_GOOG_asianCallAM;

%% Simulated losses
simulated_Loss = -(simulated_PT-P0);

%% Risk measures 
p         = 0.95; % probability level for the risk measures
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

legend('Losses','VaR','ES');

