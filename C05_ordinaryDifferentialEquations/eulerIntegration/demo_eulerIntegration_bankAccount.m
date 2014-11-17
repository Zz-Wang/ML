function demo_eulerIntegration_bankAccount()
%% demo_eulerIntegration_bankAccount: demo Euler integration scheme for exponential
 
%% parameters

% intial conditions
t0 = 0.0;   % initial date
M0 = 100.0; % initial deposit

% interest rate
r  = 0.05;  

% parameters for integration grid
T  = 50.0;  % length of time interval (in years)
N  = 10;     % number of integration steps

%% Define integration grid

deltaT = T/N;                   % length of integration steps
t      = linspace(t0,t0+T,N+1); % vector of monitoring times

%% Euler integration method

M_euler(1) = M0;  % initial condition
for n = 1:N
    M_euler(n+1) = M_euler(n)*(1 + r *deltaT);
end

%% Exact solution

M = M0*exp(r*(t-t0));   

%% Plot the results

figure(1); clf
plot(t,M,'k',t,M_euler,'bo','LineStyle','-');
xlabel('t'); ylabel('f(t)');
legend('M(t)','M_{euler}(t)',0);

