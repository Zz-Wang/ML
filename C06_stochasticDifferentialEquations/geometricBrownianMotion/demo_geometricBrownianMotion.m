function demo_geometricBrownianMotion(M,N)
%% demo_geometricBrownianMotion: simulation and properties of arithmetic Brownian Motion
%
%%  SYNTAX:
%         demo_geometricBrownianMotion(M,N)
%
%%  INPUT: 
%         M : Number of simulations
%         N : Number of steps in simulations
%  
%%  EXAMPLE:
%     M = 1;    N = 100; demo_geometricBrownianMotion(M,N)
%     M = 25;   N = 100; demo_geometricBrownianMotion(M,N)
%     M = 100;  N = 100; demo_geometricBrownianMotion(M,N)
%     M = 1000; N = 100; demo_geometricBrownianMotion(M,N)
%

%% Simulate in [t0,t0+T]
t0 = 0;  
T  = 2;            

%% Parameters GBM
S0    = 100.0;
mu    = 0.50;
sigma = 0.30;

%% Simulation
[t,S] = simulateGeometricBrownianMotion(M,N,t0,S0,T,mu,sigma);

%% Plot the simulated trajectories 
if (M < 30) 
    plot(t,S'); 
    axis('tight');
    xlabel('t'); ylabel('S(t)')
else   % sufficiently large sample for E[ST] and stdev[ST]
    
    ST  = S(:,end);  % final value of each trajectory
    
    subplot(1,10,8:10);
    modelPdf = @(S)(lognpdf(S,log(S0)+(mu-0.5*sigma^2)*T,sigma*sqrt(T)));
    
    scale = 0; 
    graphicalComparisonPdf(ST,modelPdf,scale,min(S(:)), max(S(:)))
    view(90,-90);
    
    % plot trajectories
    subplot(1,10,1:6);
    plot(t,S','LineWidth',1);   
    axis('tight');
    xlabel('t'); ylabel('S(t)')

    hold on
    
    % plot stdev[S(t)]
    expected_logS = log(S0) + mu*t; 
    expected_S = S0*exp(mu*t); 
    plot(t,expected_S,'k','LineWidth',3);

    % plot stdev[S(t)]
    std_logS = sigma*sqrt(t);
    alpha = 2;
    plot(t,exp(expected_logS - alpha*std_logS),'b','LineWidth',3);
    plot(t,exp(expected_logS + alpha*std_logS),'b','LineWidth',3);
    hold off
end
