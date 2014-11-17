function f = eulerIntegrationVariableGrid(f0,a,t)
% eulerIntegrationVariableGrid: Integration of an ODE with the Euler scheme
%
% SYNTAX: 
%        f = eulerIntegrationVariableGrid(f0,a,t)
%
% INPUT:
%        f0   : Initial value of the function
%        a    : Handle of the function a(t,f), which gives the value
%               of the derivative 
%        t    : Times at which the trajectory is monitored
%
% OUTPUT:
%        f    : Values of the trajectory that starts from 
%               f(1) = f0 at t(1) = t0
%
%   EXAMPLE:   
%        % dM_t = r M_t dt   
%        t = [1 3 7 8 10 12 15 20];
%        M0 = 100; r = 0.05; a = @(t,M)(r*M);
%        M_euler = eulerIntegrationVariableGrid(M0,a,t);
%        nPlot = 1000; tPlot = linspace(t(1),t(end),nPlot); M = M0*exp(r*(tPlot-t(1)));
%        figure(1); plot(tPlot,M,'k',t,M_euler,'b',t,M_euler,'bo','linewidth',2);
%        xlabel('t'); ylabel('f(t)'); legend('M(t)','M_{euler}(t)',0)
%  

deltaT = diff(t);       % length of the different time intervals

f = zeros(1,length(t)); % reserve memory for the trajectory

f(1) = f0;              % initial value of trajectory
for n = 1: length(deltaT)
   f(n+1) = f(n) + a(t(n),f(n))*deltaT(n); 
end




