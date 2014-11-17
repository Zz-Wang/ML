function [t,B] = simulateArithmeticBrownianMotion(M,N,t0,B0,T,mu,sigma)
%% simulateArithmeticBrownianMotion: Simulate arithmetic Brownian motion in [t0,t0+T]
%
%% SYNTAX:
%        [t,B] = simulateArithmeticBrownianMotion(M,N,t0,B0,T,mu,sigma)
%
%% INPUT:
%        M  : Number of trajectories
%        N  : Number of time steps
%        t0 : initial time
%        B0 : initial value B(t0) = B0
%        T  : Length of the simulation interval [t0,t0+T]
%  mu,sigma : parameters of the process
%
%% OUTPUT:
%        t  : Times at which the trajectory is monitored
%        B  : Simulation of M trajectories of arithmetic Brownian motion
%
%% EXAMPLE:   
%       t0 = 2;  B0 = 10; % initial conditions
%       T  = 10;    % interval [t0,t0+T]  
%       N  = 100;   % number of time steps   
%       M  = 50;    % number of trajectories 
%       mu = 2; sigma = 3;
%       [t,B] = simulateArithmeticBrownianMotion(M,N,t0,B0,T,mu,sigma);
%       figure(1);  plot(t,B')
%       xlabel('t'); ylabel('B(t)');
%

%% Size of integration step
deltaT = T/N;          

%% Monitoring times
t = linspace(t0,t0+T,N+1); 

%% Simulate M trajectories  in N steps
X = randn(M,N);  % Gaussian white noise
d = mu*deltaT + sigma*sqrt(deltaT)*X;
B = cumsum([B0*ones(M,1) d], 2);