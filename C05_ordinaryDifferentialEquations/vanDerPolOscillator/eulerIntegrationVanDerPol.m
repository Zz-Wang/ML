function [t,x,p] = eulerIntegrationVanDerPol(t0,x0,p0,mu,T,N)
%% eulerIntegrationVanDerPol: Van Der Pol oscillator solved via Euler integration
%
%% SYNTAX: 
%        [t,x,p] = eulerIntegrationVanDerPol(t0,x0,p0,mu,T,N)
%
%% INPUT:
%        t0 : Initial time
%        x0 : Initial position 
%        p0 : Initial momentum 
%        mu : damping strength
%        T  : Length of integration interval [t0, t0+T]
%        N  : Number of time steps
%
%% OUTPUT:
%        t  : Times at which the trajectory is monitored
%             t(n) = t0 + n Delta T
%        x  : Values of the position along the trajectory
%        p  : Values of the momentum along the trajectory
%             
%% EXAMPLE 1:   
%        t0 = 0; x0 = 0; p0 = 1;
%        mu = 0.01;
%        T  = 20; N = 1e5;   
%        [t,x,p] = eulerIntegrationVanDerPol(t0,x0,p0,mu,T,N);
%        figure(1); plot(t,x,t,p);
%        xlabel('t');legend('x(t)','p(t)');        
%          
%% EXAMPLE 2:   
%        t0 = 0; x0 = 0; p0 = 1;
%        mu = 2;
%        T = 20; N = 1e5;   
%        [t,x,p] = eulerIntegrationVanDerPol(t0,x0,p0,mu,T,N);
%        figure(1); plot(t,x,t,p);
%        xlabel('t');legend('x(t)','p(t)');        
%

deltaT = T/N;              % size of integration step

t = linspace(t0,t0+T,N+1); % initialize monitoring times

x = zeros(1,N+1);          % initialize x
p = zeros(1,N+1);          % initialize p

% Euler integration 
x(1) = x0;                 % initial conditions
p(1) = p0;                 
for n = 1:N
    x(n+1) = x(n) + p(n)*deltaT; 
    p(n+1) = p(n) + (mu*(1-x(n)*x(n))*p(n)-x(n))*deltaT; 
end
