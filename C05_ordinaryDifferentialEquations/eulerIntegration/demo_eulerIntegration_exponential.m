function demo_eulerIntegration_exponential()
%%  demo_eulerIntegration_exponential: Integration of ODE for the exponential  
%
% Exponential 
% $$ dM(t) = r M(t) dt $$

%% Parameters for the integration grid

% initial conditions
t0 = 0;  % initial time 
M0 = 100; % initial value of the trajectory

% length of integration interval
T  = 50; 

%% Function that gives the value of the derivative 
%
% $$ a(t,M(t)) = r M(t) $$

r = 0.05;        % interest rate
a = @(t,M)(r*M);


%% Integrate the ODE (coarse integration grid)

N = 10;  % coarse grid
[t,M_euler] = eulerIntegration(t0,M0,a,T,N);


%% Plot the results

% exact solution
nPlot = 1000; 
tPlot = linspace(t0,t0+T,nPlot);   
M     = M0*exp(r*(tPlot-t0));    % exact solution

% compare the exact solution and the approximation by the Euler method 
figure(1); clf
plot(tPlot,M,'k',t,M_euler,'bo','LineStyle','-');
xlabel('t'); ylabel('f(t)'); legend('M(t)','M_{euler}(t)',0);


%% Integrate the ODE using a finer integration grid

N = 50;  % finer integration grid
[t,M_euler] = eulerIntegration(t0,M0,a,T,N);


%% Plot the results

% compare the exact solution and the approximation given by the Euler method 
figure(2); clf
plot(tPlot,M,'k',t,M_euler,'bo','LineStyle','-');
xlabel('t'); ylabel('f(t)'); legend('M(t)','M_{euler}(t)',0);


