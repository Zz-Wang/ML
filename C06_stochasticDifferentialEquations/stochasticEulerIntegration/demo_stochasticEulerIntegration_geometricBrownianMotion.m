function demo_stochasticEulerIntegration_geometricBrownianMotion
%demo_stochasticEulerIntegration_geometricBrownianMotion: Use stochastic Euler method to integrate SDE for geometric Brownian Motion
% 
%% Parameters for the simulation 
S0    = 100;   % initial asset price
t0    = 0.0;   % initial date
mu    = 0.3;   % expected return
sigma = 0.1;   % volatility
T     = 10.0;  % length of time interval (in years)
N     = 20;    % number of integration steps
M     = 1000;  % number of trajectories

%% Monitoring times

deltaT = T/N; % length of integration steps
t      = linspace(t0,t0+T,N+1); % instants at which trajectory is monitored

%% Evolution of E[S(t)]
%
averageS_exact = S0*exp(mu*t);

%% Stochastic Euler method
% S_euler(t): Approximate simulation scheme (stochastic Euler integration)
%
S_euler = zeros(M,N+1); % allocate memory for S_euler
X = randn(M,N); % generate X ~ N(0,1)
S_euler(:,1) = S0;  % initial step in Euler integration scheme
for n = 1:N
    S_euler(:,n+1) = S_euler(:,n).*(1 + mu*deltaT + sigma*sqrt(deltaT)*X(:,n));
end
%
%%
%  Graph for approximate simulation scheme (stochastic Euler integration)
%
figure(1);
subplot(2,1,1); plot(t,S_euler);
xlabel('t'); ylabel('S(t)');
subplot(2,1,2); plot(t,averageS_exact,'k',t,mean(S_euler),'b','LineWidth',1.5);
xlabel('t'); ylabel('S(t)');
legend('E[S(t)]','E[S_{euler}(t)]',0);


%% Exact simulation scheme (geometric Brownian motion)
%
S = zeros(M,N+1); % allocate memory for S_euler
X = randn(M,N);   % generate X ~ N(0,1)
S(:,1) = S0;  % initial step in Euler integration scheme
for n = 1:N
    S(:,n+1) = S(:,n).*exp((mu-0.5*sigma^2)*deltaT + sigma*sqrt(deltaT)*X(:,n));
end

%%  Graph for exact simulation scheme (geometric Brownian motion)
%
figure(2);
subplot(2,1,1); plot(t,S);
xlabel('t'); ylabel('S(t)');
subplot(2,1,2); plot(t,averageS_exact,'k',t,mean(S),'b','LineWidth',1.5);
xlabel('t'); ylabel('S(t)');
legend('E[S(t)]','E[S_{GBM}(t)]',0);

