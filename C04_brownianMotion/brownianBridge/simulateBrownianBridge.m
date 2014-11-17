function [B,mu_B,sigma_B] = simulateBrownianBridge(M,t1,B1,t2,B2,t,sigma)
%% simulateBrownianBridge: simulation of Brownian Bridge
%
%% SYNTAX:
%        [B,mu_B,sigma_B] = simulateBrownianBridge(M,t1,B1,t2,B2,t,sigma)
%
%% INPUT:
%         M : number of trajectories
%     t1,B1 : initial time and level for the Brownian process 
%     t2,B2 : final time and level for the Brownian process
%        t  : time for simulation  t1 <= t <= t2
%     sigma : parameter for the diffusive term
%
%% OUTPUT:
%        B  : Simulated values at time t [Mx1]
%     mu_B  : Average of the simulated values
%  sigma_B  : standard deviation of the simulated values 
%
%% EXAMPLE:   
%       sigma = 2.0;
%       t1 =  0.0; B1 = 0.0;   
%       t2 = 10.0; B2 = 2.0;
%       t = 4.0;
%       M = 50;       
%       B = simulateBrownianBridge(M,t1,B1,t2,B2,t,sigma);
%       t = [t1 t t2];
%       B = [B1*ones(M,1) B B2*ones(M,1)];
%       figure(1); clf
%       plot(t1,B1,'bx',t2,B2,'bx',t,B,'-o');
%       xlabel('t'); ylabel('B(t)');
%       title('Brownian bridge');


if(t == t1)
    B = B1*ones(M,1);
elseif(t == t2)
    B = B2*ones(M,1);
else    
    mu_B    = (B1 + (t-t1)/(t2-t1)*(B2-B1));
    sigma_B = sigma*sqrt((t-t1)*(t2-t)/(t2-t1));
    
    % simulation
    X = randn(M,1);
    B = mu_B + sigma_B*X;
end
    