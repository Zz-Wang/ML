function demo_Bernoulli_randomNumberGenerator
%% demo_Bernoulli_randomNumberGenerator: generate Bernoulli[p] random numbers

%% Parameters for the Bernoulli distributon
p = 0.8;

%% Simulate a matrix (M rows, N columns) of  Bernoulli[p] random numbers
M = 50;
N = 10;

% simulate U ~ U[0,1]
U = rand(M,N);

% simulate Bernoulli[mu,sigma]
xi = U < p;

%% Compare to histogram 
f_0 = mean(xi(:) == 0); % fraction of 0's
f_1 = mean(xi(:) == 1); % fraction of 1's 

figure(1); 
bar([0,1],[f_0,f_1],0.2) 
hold on; bar([0,1],[1-p,p],0.05,'r'); hold off
legend('sample','p',2);
title(sprintf('%s %s Bernoulli[p = %.1f]','\xi','\sim',p))
            
