function demo_arithmeticBrownianMotion_statisticalProperties
%% demo_arithmeticBrownianMotion_statisticalProperties: Statistical properties of ABM

%% Parameters for Brownian motion
mu    = 1.0;   % drift
sigma = 0.5;   % diffusion

%% Simulation of the Brownian motion trajectories

% initial condition
t0 = 0;       % initial time
B0 = 0.0;     % initial value of the Brownian trajectories

% number of trajectories 
M = 50;       
% simulate in [t0,t0+T]
T = 2.0;     % length of the simulation interval       
N = 500;     % number of time steps
 

% simulation 
[t,B] = simulateArithmeticBrownianMotion(M,N,t0,B0,T,mu,sigma);

%% Mean and standard deviation
%
% $$ E[B(t)] = B_0 + \mu (t-t_0) $$
%
% $$ std[B(t)] = \sigma \sqrt{t-t_0} $$
%

% Theoretical moments
mean_B = B0 + mu*(t-t0);    % row vector with N+1 columns
std_B  = sigma*sqrt(t-t0);  % row vector with N+1 columns

% Sample moments

% B is a matrix with M rows and N+1 columns
estimated_mean_B = mean(B); % row vector with N+1 columns
estimated_std_B  = std(B);  % row vector with N+1 columns

%%  Plot the results
figure(1); clf

% E[B(t)]
subplot(2,1,1);
plot(t, estimated_mean_B,t,mean_B)
legend('Sample','Exact',0)
xlabel('t'); ylabel('E[B(t)]');

% std[B(t)]
subplot(2,1,2);
plot(t, estimated_std_B,t,std_B)
legend('Sample','Exact',0)
xlabel('t'); ylabel('std[B(t)]');


