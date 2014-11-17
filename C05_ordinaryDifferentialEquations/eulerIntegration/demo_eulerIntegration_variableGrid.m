function demo_eulerIntegration_variableGrid()
%%  demo_eulerIntegration_variableGrid: Integration of ODE for the exponential  
%
% Exponential 
% $$ dM(t) = r M(t) dt $$

%% Parameters for the integration grid

% initial conditions
M0 = 100; % initial value of the trajectory

% Monitoring times for the integration
t = [1 3 7 8 10 12 15 20];
         
%% Function that gives the value of the derivative 
%
% $$ a(t,M(t)) = r M(t) $$

r = 0.05;        % interest rate
a = @(t,M)(r*M);


%% Integrate the ODE (variable grid)

M_euler = eulerIntegrationVariableGrid(M0,a,t);


%% Plot the results

% exact solution
nPlot = 1000; 
tPlot = linspace(t(1),t(end),nPlot);   
M     = M0*exp(r*(tPlot-t(1)));    % exact solution

% compare the exact solution and the approximation by the Euler method 
figure(1); clf
plot(tPlot,M,'k',t,M_euler,'bo','LineStyle','-');
xlabel('t'); ylabel('f(t)'); legend('M(t)','M_{euler}(t)',0);

