function demo_merton_jumpDiffusion(M)
%% demo_merton_jumpDiffusion:  Merton jump diffision model
%
% dS_t = mu S_t^- + sigma S_t^- dW_t + S_t^- dJ_t

%%  EXAMPLES:
%           M = 1; demo_merton_jumpDiffusion(M)
%           M = 3; demo_merton_jumpDiffusion(M)

%%  Drift and diffusion terms in SDE

S0    = 100;    % Initial price
mu    = 0.15;   % expected return
sigma = 0.2;    % volatility

a = @(t,S)(mu*S);    % drift term in SDE
b = @(t,S)(sigma*S); % diffusion term in SDE

%%  Jump pocess

c = @(t,S)(S);       % jump term in SDE 

%  jumps follow a Poisson process
lambda = 5;  %  average of lamdba jumps per year

%  lognormal jumps
randJumpSize = @()(lognrnd(0,0.2)-1); % random nr. generator for jump size

%% Conditions for simulation 

t0 = 1;    % initial time for simulation
T  = 2;    % simulation interval (in years) 

N  = 1000; % number of simulation steps 

%% Simulation of jump diffusion SDE (stochastic Euler integration)
[t,S,t_jump,S_jump_minus,S_jump] = jumpDiffusionIntegration(t0,S0,...
    a,b,c,lambda,randJumpSize,T,N,M);

%% Plot the results 
figure(1); plot(t,S)
xlabel('t'); ylabel('S(t)');
axis('tight');

% when simulating a single trajectory mark jumps
if (M ==1)
    hold on;
    plot(t_jump{1},S_jump_minus{1},'ro',t_jump{1},S_jump{1},'rx');
    hold off;
end

