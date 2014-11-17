function [t,W] = simulateWienerProcess(M,N,T)
%% simulateWienerProcess: Simulate a Wiener process in [0,T]
%
%% SYNTAX:
%        [t,W] = simulateWienerProcess(M,N,T)
%
%% INPUT:
%        M  : Number of trajectories
%        N  : Number of time steps
%        T  : Length of the simulation interval [0,T]
%
%% OUTPUT:
%        t  : Times at which the trajectory is monitored
%        W  : Simulation of M trajectories of a Wiener Process
%
%% EXAMPLE:   
%
%       T = 10;     % interval [0,T]  
%       N = 100;    % number of time steps   
%       M = 50;     % number of trajectories  
%       [t,W] = simulateWienerProcess(M,N,T);
%       figure(1);  plot(t,W')
%       xlabel('t'); ylabel('W(t)');
%

%% Size of integration step
deltaT = T/N;          

%% Monitoring times
t = linspace(0,T,N+1); 

%% Simulate M trajectories 
X = randn(M,N);  % Gaussian white noise
W = cumsum([zeros(M,1) sqrt(deltaT)*X], 2);