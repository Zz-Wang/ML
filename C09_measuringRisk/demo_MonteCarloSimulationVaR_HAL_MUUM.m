function demo_MonteCarloSimulationVaR_HAL_MUUM
%% demo_MonteCarloSimulationVaR: Monte Carlo simulation for VaR with HAL
%% and MUUM

%% Load the data
S = load('prices_HAL_MUUM.txt'); %update

%% Select data in the recent past
N  = 500;

S_HAL   = S(end-N:end,1);
S0_HAL  = S_HAL(end);

S_MUUM  = S(end-N:end,2);
S0_MUUM = S_MUUM(end);


%% Compute historical log returns for the specified time horizon (DeltaT)

% horizon for the risk measures (VaR, ES)
horizon = 10;  

indices = N+1:-1:horizon+1;          % overlapping intervals
% indices = N+1:-horizon:horizon+1;  % non-overlapping intervals
indices = indices(end:-1:1);

% New sample size
N = length(indices);

r_HAL  = log(S_HAL(indices)  ./ S_HAL(indices-horizon));
r_MUUM = log(S_MUUM(indices) ./ S_MUUM(indices-horizon));

%% Student's t fit for the marginals of the log returns

% Degrees of freedom: seed for the optimization
nu0 = 5; 

% Student's t fit for HAL
[mu_HAL,sigma_HAL,nu_HAL,modelPdf_HAL,modelCdf_HAL,modelInv_HAL] = ...
    fit2StudentT(r_HAL,nu0);
nu_HAL

% Student's t fit for MUUM
[mu_MUUM,sigma_MUUM,nu_MUUM,modelPdf_MUUM,modelCdf_MUUM,modelInv_MUUM] = ...
    fit2StudentT(r_MUUM,nu0);
nu_MUUM

%% Gaussian copula for the joint distribution of log returns

% Transform to U[0,1] marginals
%u_HAL  = modelCdf_HAL(r_HAL); 
%u_MUUM = modelCdf_MUUM(r_MUUM);

% Gaussian copula fit
%rho = corr([norminv(u_HAL) norminv(u_MUUM)]);

%% Portfolio composition
c_HAL_asset        = 500;  % HAL shares
c_MUUM_asset       = 200;  % MUUM shares
c_HAL_call         = 5000; % European call on HAL
c_MUUM_asianCallAM = 2000; % Arithmetic mean Asian call on MUUM

%% Portfolio value at t0

%% Value of the European call option on HAL
r = 0.01;  % risk-free interest rate
T = 1;     % time to maturity
K = 180;   % Strike

nDaysInYear = 252;  % number of trading days in a year
% sigma_HAL   = sqrt(nDaysInYear/horizon)*std(r_HAL); % annualized historical volatity
sigma_HAL   = 0.16;                                 % implied volatility in a call on HAL  

payoff_call    = @(ST)(max(ST-K,0));
price_HAL_call = priceEuropeanOption(S0_HAL,r,T,sigma_HAL,payoff_call)

%% Value of an Asian call option on the arithmetic mean of MUUMle
N_AM = 6;    % Number of monitoring times for the arithmetic mean 
T    = 0.5;  % Time to maturity
M_AM = 1e3;  % Number of simulated trajectories
K    = 880;  % Strike of the Asian arithmetic mean call option

sigma_MUUM   = sqrt(nDaysInYear/horizon)*std(r_MUUM); % annualized historical volatity

[price_MUUM_asianCallAM,stdev_MC] = ...
    priceAsianArithmeticMeanCallMC_controlVariate(S0_MUUM,K,r,T,sigma_MUUM,M_AM,N_AM)

%% Value of the portfolio at t0
P0 = c_HAL_asset        * S0_HAL         + ...
     c_HAL_call         * price_HAL_call + ...
     c_MUUM_asset       * S0_MUUM        + ...
     c_MUUM_asianCallAM * price_MUUM_asianCallAM
 
%% Monte Carlo simulation

% Simulate M scenarios
M = 5e3;  %update

%% Simulate the log returns from the multivariate model

% Student's t marginals + Gaussian copula

% Gaussian copula sample
%U = gaussianCopulaRand(M,rho);

% Incorporate marginals
%simulated_r_HAL  = modelInv_HAL(U(:,1));
%simulated_r_MUUM = modelInv_MUUM(U(:,2));



%% Simulate the log returns from the multivariate model
% Student's t marginals + Student's copula
rho = [1 0.7; 0.7 1];
nu = 2.5;
U = studentTCopulaRand(M,rho,nu);

% Incorporate marginals
simulated_r_HAL  = modelInv_HAL(U(:,1));
simulated_r_MUUM = modelInv_MUUM(U(:,2));

%% Simulate the prices of the assets at t0 + DeltaT

simulated_ST_HAL  = S0_HAL*exp(simulated_r_HAL);
simulated_ST_MUUM = S0_MUUM*exp(simulated_r_MUUM);

%% Simulate the prices of the derivatives at t0 + DeltaT

simulated_price_HAL_call = zeros(M,1);
simulated_price_MUUM_asianCallAM = zeros(M,1);
for m = 1:M
    % disp(M-m) % monitor the number of pending simulations
    
    %% HAL:  Call option
    simulated_price_HAL_call(m) = ...
        priceEuropeanOption(simulated_ST_HAL(m),r,T,sigma_HAL,payoff_call);
    
    %% MUUM: Call on the arithmetic mean
    simulated_price_MUUM_asianCallAM(m) =...
        priceAsianArithmeticMeanCallMC_controlVariate...
        (simulated_ST_MUUM(m),K,r,T,sigma_MUUM,M_AM,N_AM);
end

%% Simulated portfolio value at t0 + DeltaT
simulated_PT = c_HAL_asset        * simulated_ST_HAL         + ...
               c_HAL_call         * simulated_price_HAL_call + ...
               c_MUUM_asset       * simulated_ST_MUUM        + ...
               c_MUUM_asianCallAM * simulated_price_MUUM_asianCallAM;

%% Simulated losses
simulated_Loss = -(simulated_PT-P0);

%% Risk measures 
p         = 0.975;  % probability level for the risk measures
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

