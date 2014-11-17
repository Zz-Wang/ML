function [t,f] = eulerIntegration(t0,f0,a,T,N)
%% eulerIntegration: Integration of an ODE with the Euler scheme
%
%% SYNTAX:
%        [t,f] = eulerIntegration(t0,f0,a,T,N)
%
%% INPUT:
%        t0 : Initial time
%        f0 : Initial value of the function f(t0) = f0; 
%        a  : Handle of the function a(t,f), which gives the value
%             of the derivative 
%        T  : Length of integration interval [t0, t0+T]
%        N  : Number of time steps
%
%% OUTPUT:
%        t  : Times at which the trajectory is monitored
%        f  : Values of the trajectory that starts from f(t0) = f0
%              
%
%% EXAMPLE:   
%        % dsigma(t) = - alpha (sigma(t) -sigma_infty) dt   % reversion to the mean
%        sigma_0 = 0.5; sigma_infty = 0.2; alpha = 1/2; 
%        a = @(t,sigma)(-alpha*(sigma -sigma_infty))
%        t0 = 0; T = 20;          
%        N = 100;   
%        [t,sigma] = eulerIntegration(t0,sigma_0,a,T,N);
%        figure(1); plot(t,sigma);
%        xlabel('t'); ylabel('f(t)'); legend('\sigma(t)');        
%          

deltaT = T/N;              % size of the integration step

t = linspace(t0,t0+T,N+1); % monitoring times

f = zeros(1,N+1);          % initialize trajectory

% Euler integration method
f(1) = f0;                 % initial condition
for n = 1:N
    f(n+1) = f(n) + a(t(n),f(n))*deltaT; 
end

