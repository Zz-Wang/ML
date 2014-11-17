function demo_WienerProcess_maxima
%% Estimate Prob[M(T) >= x] for a Wiener process
% 
% $$ M(T) = max[W(s): 0 < s < T] $$

%% Parameters for the simulation

T = 10;     % interval [0,T]  
N = 500;    % number of time steps   
M = 1000;   % number of trajectories  

%% Simulation of the Wiener process

% simulate M trajectories in [0,T] in N steps
[t,W] = simulateWienerProcess(M,N,T);

%% Estimation of the distribution of maxima
% 
% $$ Prob[M(T) \ge x] $$

% monitoring levels
mean_WT = 0;
std_WT  = sqrt(T);
alpha   = 4;
level   = linspace(0,mean_WT+alpha*std_WT);

% exact P[M(T) >= level]
exact_P = 2.0*(1- normcdf(level,0,sqrt(T))); 

% sample estimate P[M(T) >= level]
for i= 1:length(level)
    index = any(W >= level(i),2);
    estimated_P(i) = mean(index);
end

%% Plot the results
figure(1); clf
plot(level, estimated_P,level,exact_P)
title('Prob[M(T) >= x]');
xlabel('x');
ylabel('p');
legend('Sample','Exact')
axis('tight')