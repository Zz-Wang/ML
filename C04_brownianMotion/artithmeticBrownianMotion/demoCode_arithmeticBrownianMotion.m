function demoCode_arithmeticBrownianMotion
%% demoCode_arithmeticBrownianMotion

format short
%% Parameters for the simulation
t0 = 0;         % initial time
B0 = 0.0;       % initial value of the Brownian trajectories

mu    = 1;      % drift 
sigma = 2;      % diffusion

M = 3;          % Number of simulated trajectories
N = 5;          % Number of simulation steps
T = 2;          % length of the simulation interval [t0,t0+T]

% time step for the simulation
deltaT = T/N;

% monitoring times
t = linspace(t0,t0+T,N+1); 

%% Simulate Gaussian white noise 
X  = randn(M,N)  

%% Compute the increments of the Brownian process
% 
% $$ B(t+\Delta T) - B(t) = \mu\Delta T + \sigma \sqrt{\Delta T} X $$
% 

d  = mu*deltaT + sigma*sqrt(deltaT)*X    % M rows, N comums   

%% Prepare for simulation 
B  = [B0*ones(M,1) d]     % M rows, (N+1) columns                    

%% Simulate arithmetic Brownian motion 
B  = cumsum(B,2)          % simulation

%% Sample statistics
% sample mean
E_B   = mean(B)           % row vector with (N+1) columns

% sample standard deviation
std_B = std(B)            % row vector with (N+1) columns

%% Plot the simulated trajectories
%
figure(1); clf; 
plot(t,B,'o-');
xlabel('t'); ylabel('B(t)')
