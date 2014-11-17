function demo_WienerProcess_statisticalProperties
%% demo_WienerProcess_statisticalProperties: Statistical properties of the Wiener process
%
%% Parameters for the simulation

T = 10;     % interval [0,T]  
N = 500;    % number of time steps   
M = 1000;   % number of trajectories  

%% Simulation of the Wiener process
%
%  simulate M trajectories in [0,T] in N steps

[t,W]  = simulateWienerProcess(M,N,T);

%% Mean and standard deviation
%   
% $$ E[W(t)] = 0 $$
%
% $$ std[W(t)] = \sqrt{t} $$
%   
mean_W = zeros(size(t));
estimated_mean_W = mean(W);

std_W = sqrt(t);
estimated_std_W  = std(W);

%% Plot the results
figure(1); clf

% E[W(t)]
subplot(2,1,1);
plot(t, estimated_mean_W,t,mean_W)
legend('Sample','Exact',0)
xlabel('t'); ylabel('E[W(t)]');

% std[W(t)]
subplot(2,1,2);
plot(t, estimated_std_W,t,std_W)
legend('Sample','Exact',0)
xlabel('t'); ylabel('std[W(t)]');
