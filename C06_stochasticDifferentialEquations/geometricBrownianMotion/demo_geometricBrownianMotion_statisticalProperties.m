function demo_geometricBrownianMotion_statisticalProperties
%% demo_geometricBrownianMotion_statisticalProperties: Statistical properties of ABM

%% parameters for geometric Brownian motion
mu    = 0.50;
sigma = 0.30;

%% Simulation

% initial condition
t0 = 0.0;  
S0 = 100.0;  

% simulate in [t0,t0+T]
T  = 2.0;            

N = 500;   % number of time steps
M = 50;    % number of trajectories  

[t,S] = simulateGeometricBrownianMotion(M,N,t0,S0,T,mu,sigma);

%% Mean 
%
% $$ E[S(t)] = S_0 e^{\mu (t-t_0)} $$ 

% mean
mean_S = S0 *exp(mu*(t-t0)) ;
estimated_mean_S = mean(S);

% plot the results
figure(1); clf

% E[S(t)]
plot(t, estimated_mean_S,t,mean_S)
legend('Sample','Exact',0)
xlabel('t'); ylabel('E[S(t)]');

