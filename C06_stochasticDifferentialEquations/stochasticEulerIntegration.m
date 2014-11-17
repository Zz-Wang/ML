function [t,f] = stochasticEulerIntegration(t0,f0,a,b,T,N,M)
%% stochasticEulerIntegration: Integration of SDE in the Euler scheme
%
%% SYNTAX: 
%        [t,f] = stochasticEulerIntegration(t0,f0,a,b,T,N,M)
%
%% INPUT:
%        t0 : Initial time
%        f0 : Initial value of the function f(t_0) = f0; 
%        a  : Handle of the function a(t,f) in the drift term
%        b  : Handle of the function b(t,f) in the diffusion term 
%        T  : Length of integration interval [t0, t0+T]
%        N  : Number of time steps
%        M  : Number of trajectories in simulation 
%  
%% OUTPUT:
%        t  : Times at which the trajectory is monitored
%               t(n) = t0 + n Delta T
%        f  : values of the trajectory that starts from 
%               f(1) = f0 at t0
%
%% EXAMPLE:   
%        % dsigma_t = - alpha (sigma_t -sigma_infty) dt   % reversion to the mean
%        sigma_0 = 0.5; sigma_infty = 0.2; alpha = 1/2; xi = 0.1;
%        a = @(t,sigma)(-alpha*(sigma -sigma_infty));
%        b = @(t,sigma)(xi*sigma); 
%
%        t0 = 0; T = 20;          
%        N = 100; M = 50;  
%        [t,sigma_t] = stochasticEulerIntegration(t0,sigma_0,a,b,T,N,M);
%
%        figure(2); plot(t,sigma_t);
%        xlabel('t'); ylabel('\sigma(t)');       
%          
%


%%%%
M = 1000;
N = 200;
t0 = 0;
T =4;
f0 = 0.1;
a = 2;
b = 0.05;
sigma = 0.06;

%%%%
%% Size of integration step
deltaT = T/N; 

%% Initialize monitoring times
t = linspace(t0,t0+T,N+1); 
 
%% Initialize f   [M rows, (N+1) columns]
f = zeros(M,N+1); % Each row of f is a trajectory
                  % Each column corresponds to a monitoring time   

%% Simulate trajectories

%%%Vas
X      = randn(M,N);  % generate X ~ N(0,1) 
f(:,1) = f0;          % initial condition

for n = 1:N
    f(:,n+1) = f(:,n) + a*(b-f(:,n))*deltaT +... 
                        sigma.*X(:,n); 
end

plot(t,f);
xx = f(:,201)
z= 0
for i = 1:M
    if xx(i) > 0.055 
        z = z+1;
    end
end
    

%%% CIR
g0 = 0.1;
g(:,1) = g0;          % initial condition
g = zeros(M,N+1); 
for n = 1:N
    g(:,n+1) = g(:,n) + a*(b-g(:,n))*deltaT +... 
                        sqrt(g(:,n))*sigma.*X(:,n); 
end
dd = real(g(:,201));
z= 0
for i = 1:M
    if dd(i) > 0.055 
        z = z+1;
    end
end
    