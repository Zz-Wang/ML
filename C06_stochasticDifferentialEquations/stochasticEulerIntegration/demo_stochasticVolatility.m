function demo_stochasticVolatility
%% Simulation of SDE for a stochastic volatility model
%
% $$ d\sigma(t) = - \alpha (\sigma(t) - \sigma_{\infty}) dt + \xi \sigma(t) dW(t) $$

%% Definition of the SDE    

sigma0      = 0.5; % initial volatility
sigma_infty = 0.2; % reversion level
alpha       = 1/2; % reversion rate
xi          = 0.1; % parameter for the diffusion term

% drift term: reversion to the mean
a = @(t,sigma)(-alpha*(sigma -sigma_infty)); 

% diffusion term
b = @(t,sigma)(xi*sigma);                    %

%% Simulation
t0 = 0; T = 20;
N = 1000; M = 100;
[t,sigma_t] = stochasticEulerIntegration(t0,sigma0,a,b,T,N,M);

%% Evolution of the average   
E_sigma_t = mean(sigma_t);

%% Plot the results

% Evolution of the average   
h = figure(1); 
plot(t,mean(sigma_t),'k','LineWidth',2);
xlabel('t'); ylabel('\sigma(t)'); legend('E[\sigma(t)]');

% Plot trajectories   
hold on
plot(t,sigma_t,'LineWidth',1);
plot(t,mean(sigma_t),'k','LineWidth',2);
hold off

%%  Reversion level
hold on
plot(t,sigma_infty*ones(size(t)),'k','LineStyle',':');
hold off

%% Characteristic time for decay
hold on
sigma_e = sigma_infty+(sigma0-sigma_infty)/exp(1);
plot([1/alpha 1/alpha],[0 sigma_e],'LineStyle','--');
text(1/alpha,sigma_e/3,' \tau_{\alpha} = 1/\alpha')
hold off
