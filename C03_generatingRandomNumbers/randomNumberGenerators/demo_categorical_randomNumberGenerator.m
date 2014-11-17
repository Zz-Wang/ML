function demo_categorical_randomNumberGenerator
%% demo_categorical_randomNumberGenerator: generate Categorical[p,K] random numbers
%% Parameters for the Categorical distributon
p = [1/6 1/6 1/6 1/6 1/6 1/6];  % rolling a die

%% Number of possible outcomes
K = length(p)           

%% Sample from Categorical[p,K]

cum_p = cumsum([0 p])   % cumulative distribution 

U = rand                % simulate U ~ U[0,1]

xi = sum(U > cum_p)     % xi ~ Categorical[p,K]

%% Simulate a matrix (M rows, N columns) of  Categorical[p,K] random numbers
M = 100;
N = 20;

xi = categoricalRand(M,N,p);

%% Compare to histogram 
for k = 1:K
    frequency(k) = mean(xi(:) == k);
end

figure(1); clf
barWidth = 0.2;
bar(1:K,frequency,barWidth);
hold on; bar(1:K,p,0.05,'r'); hold off
legend('sample','p',4);
title(sprintf('%s %s Categorical[p,%d]','\xi','\sim',K))
