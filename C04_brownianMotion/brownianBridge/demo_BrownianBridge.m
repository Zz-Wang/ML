function demo_BrownianBridge
%% demo_BrownianBridge: simulation of a Brownian bridge

%% Parameters for the simulation
t1 = 0.0; 
B1 = 0.0;   

t2 = 10.0; 
B2 = 12.0; 

tau = 4.0;           

sigma = 2.0;

%% Brownian bridge simulation

% simulateM trajectories
M = 50;
B = simulateBrownianBridge(M,t1,B1,t2,B2,tau,sigma);


% plot the simulated trajectories
t  = [t1 tau t2];
Bt = [B1*ones(M,1) B B2*ones(M,1)];

figure(1); clf
subplot(1,2,1)
plot(t1,B1,'bx',t2,B2,'bx',t,Bt,'-o','LineWidth',1);
xlabel('t'); ylabel('B(t)');
title('Brownian bridge');

%% Simulate more trajectories and compare with histogram

% simulate M trajectories
M = 1e4;
[B, mu_B, std_B] = simulateBrownianBridge(M,t1,B1,t2,B2,tau,sigma);

% plot the histogram
subplot(1,2,2); 
scale = 0;
modelPdf = @(x)normpdf(x,mu_B, std_B);
graphicalComparisonPdf(B,modelPdf,scale,min(B), max(B))
view(-90,90);

% adjust the axes
subplot(1,2,1)
axis([t1 t2 min(B) max(B)]);
