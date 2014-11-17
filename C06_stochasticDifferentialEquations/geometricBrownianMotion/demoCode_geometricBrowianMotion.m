function demoCode_geometricBrowianMotion
%% demoCode_geometricBrowianMotion

%% Parameters for the simulation
t0 = 0;
S0 = 100.0;

mu    = 0.3;
sigma = 0.4;

M = 3; % Number of trajectories

T = 2; % Length of the simulation interval
N = 5; % Number of time steps

%% Time step
deltaT = T/N;

%% Monitoring times
t = linspace(t0,t0+T,N+1); 

%% Simulate Gaussian white noise 
X  = randn(M,N) 

%% Compute the exponential factors
% 
% $$ S(t+\Delta T) = S(t) e^{\left(\mu-\frac{1}{2} \sigma^2\right) \Delta T + \sigma \sqrt{\Delta T}X} $$

e  = exp((mu-0.5*sigma^2)*deltaT + sigma*sqrt(deltaT)*X)    

%% Prepare for the simulation 
S  = [S0*ones(M,1) e]                         

%% Simulate geometric Brownian motion 
S  = cumprod(S,2)          % simulation

%% Plot the simulated trajectories
figure(1); clf; 
plot(t,S);
xlabel('t'); ylabel('S(t)')
