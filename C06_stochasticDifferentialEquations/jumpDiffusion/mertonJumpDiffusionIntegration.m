function [t,S,t_jump,S_jump_minus,S_jump] = mertonJumpDiffusionIntegration(t0,S0,mu,sigma,lambda,randJumpY,T,N,M)
%% mertonJumpDiffusionIntegration: Integration of SDE for diffusion with jumps
%
%% SYNTAX:
%    [t,S,t_jump,S_jump_minus,S_jump] = mertonJumpDiffusionIntegration(t0,S0,mu,sigma,lambda,randJumpY,T,N,M)
%
%% INPUT:
%         t0  : Initial time
%         S0  : Initial value of the function S(t0) = S0;
%         mu  : parameter in the drift term
%      sigma  : parameter in the diffusion term
%     lambda  : Parameter of the Poisson counting process
%  randJumpY  : random number generator. Jumps are of size Z = randJumpY()-1
%          T  : Lenght of integration interval [t0, t0+T]
%          N  : Number of time steps
%          M  : Number of trajectories in simulation
%
%% OUTPUT:
%          t  : Times at which the trajectory is monitored
%               t(n) = t0 + n Delta T
%          S  : values of the trajectory that starts from
%                 S(1) = S0 at t0
%      t_jump : Times for jumps (cell array)
%S_jump_minus : Values of the trajectory right before jump
%      S_jump : Values of the trajectory right after jump
%
%% EXAMPLE:
%
%        %
%        %   Merton jump diffision model
%        %
%        % dS_t = mu S_t^- + sigma S_t^- dW_t + S_t^- dJ_t
%        %
%        S0 = 100; mu = 0.15; sigma = 0.2;
%        lambda = 5;  % Poisson process: average of lamdba jumps per year
%        randJumpY = @()(lognrnd(0,0.2)); % random nr. generator for jump size
%        t0 = 1; T = 2;
%        N = 1000; M = 1;
%        [t,S,t_jump,S_jump_min,S_jump] = mertonJumpDiffusionIntegration(t0,S0,...
%                                                 mu,sigma,lambda,randJumpY,T,N,M);
%        figure(1); plot(t,S)
%        hold on;
%        plot(t_jump{1},S_jump_min{1},'ro',t_jump{1},S_jump{1},'rx');
%        hold off;
%        xlabel('t'); ylabel('S(t)');
%        axis('tight');
%
%
deltaT = T/N;     % size of integration step
S = zeros(M,N+1); % initialize S
t = linspace(t0,t0+T,N+1); % initialize monitoring times
X = randn(M,N);   % generate X ~ N(0,1)
t_jump     = cell(M,1); % Cell array for vectors of jump times
S_jump_min = cell(M,1); % Cell array for vectors of value of S at t_jump^-
S_jump     = cell(M,1); % Cell array for vectors of value of S at t_jump
t(1) = t0;
S(:,1) = S0;
for m = 1:M
    
    %   Simulate the mth trajectory
    nJump  = 1;
    deltaT_jump = -log(rand)/lambda; % delay between consecutive jumps
    t_jump{m}(1) = t0 + deltaT_jump; % time of the first jump
    
    for n = 1:N
        tInit = t(n); 
        SInit= S(m,n);
        
        while(t(n+1) >= t_jump{m}(nJump)) % there is at least jump in [tInit,t_{n+1}]
            
            %  Integrate SDE in [tInit,t_jump)
            dT = t_jump{m}(nJump) - tInit; % size of interval
            S_jump_minus{m}(nJump) = SInit*exp((mu-0.5*sigma^2)*dT +sigma*sqrt(dT)*randn);
           
            %  Integrate SDE in (t_jump,t_jump]
            jumpY  = randJumpY(); % generate jump size
            S_jump{m}(nJump) = S_jump_minus{m}(nJump)*jumpY;
            
            %  Generate time for new jump
            deltaT_jump = -log(rand)/lambda; % delay between consecutive jumps
            t_jump{m}(nJump+1) = t_jump{m}(nJump) + deltaT_jump;
            tInit = t_jump{m}(nJump);
            SInit= S_jump{m}(nJump);
            nJump = nJump + 1;
        end
        
        %  Integrate SDE in [tInit,t_{n+1}]
        dT = t(n+1)- tInit; % size of interval
        S(m,n+1) = SInit*exp((mu-0.5*sigma^2)*dT +sigma*sqrt(dT)*X(m,n));

    end
    t_jump{m} = t_jump{m}(1:end-1);
end

