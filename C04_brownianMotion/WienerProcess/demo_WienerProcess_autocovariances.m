function demo_WienerProcess_autocovariances
%% Autocovariance structure of a Wiener process

%% Parameters for the simulation

T = 10;     % interval [0,T]  
N = 500;    % number of time steps   
M = 1000;   % number of trajectories  

%% Simulate a Wiener process

% simulate M trajectories in [0,T] in N steps
[t,W]  = simulateWienerProcess(M,N,T);

%% Autocovariances
%
% $$ E[W(t)W(\tau)] = min(t,\tau) $$

% reference time for autocovariances
deltaT = T/N; % step size
n_tau  = round(N/3);
tau    = n_tau*deltaT;

% exact autocovariances
exact_autocovariances = min(t,tau);

% estimated autocovariances
for n = 1:N+1
    estimated_autocovariances(n) = mean(W(:,n).*W(:,n_tau));
end

%% Plot the results

figure(1); clf
plot(t, estimated_autocovariances,t,exact_autocovariances)
xlabel('t'); ylabel('autocovariances');
title('E[W(t),W(\tau)]')
legend('Sample','Exact',0)

% mark position of tau
hold on;
plot([tau,tau],[0 tau],'k','LineStyle',':')
hold off;
text(tau + 0.2, 0.2,'t = \tau')

