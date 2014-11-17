function demo_WienerProcess(M,N)
%% demo_WienerProcess: simulation and properties of a Wiener process
%
%%  SYNTAX:
%         demo_WienerProcess(M,N)
%
%%  INPUT: 
%         M : Number of simulations
%         N : Number of steps in simulations
%  
%%  EXAMPLES:
%     M = 1;    N = 1000; demo_WienerProcess(M,N)
%     M = 25;   N = 1000; demo_WienerProcess(M,N)
%     M = 100;  N = 1000; demo_WienerProcess(M,N)
%     M = 1000; N = 1000; demo_WienerProcess(M,N)
%

%% Simulate in [0,T]
T  = 2;            

%% Simulate M trajectories in [0,T] in N steps
[t,W] = simulateWienerProcess(M,N,T);

%% Plot simulated trajectories 
if (M < 30) 
    figure(1); clf
    plot(t,W'); 
    axis('tight');
    xlabel('t'); ylabel('W(t)')
else   % sufficiently large sample for E[WT] and stdev[WT]
    figure(1); clf
    
    WT  = W(:,end);  % final value of each trajectory
    
    subplot(1,10,8:10);
    modelPdf = @(x)(normpdf(x,0,sqrt(T)));
    
    scale = 0;       % do not scale histogram
    graphicalComparisonPdf(WT,modelPdf,scale,min(W(:)), max(W(:)))
    view(-90,90);
    
    % plot trajectories
    subplot(1,10,1:6);
    plot(t,W','LineWidth',1);   
    axis('tight');
    xlabel('t'); ylabel('W(t)')

    hold on
    
    % plot E[W(t)]
    expected_W = zeros(size(t)); 
    plot(t,expected_W,'k','LineWidth',3);

    % plot stdev[W(t)]
    std_W = sqrt(t);
    alpha = 2;
    plot(t,expected_W - alpha*std_W,'b','LineWidth',3);
    plot(t,expected_W + alpha*std_W,'b','LineWidth',3);
    hold off
end
