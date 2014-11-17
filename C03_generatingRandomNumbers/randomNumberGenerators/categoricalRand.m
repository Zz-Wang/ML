function k = categoricalRand(M,N,p)
%% categoricalRand: Generate random numbers from a categorical distribution
%
%% SYNTAX:
%         k = categoricalRand(M,N,p)
%
%% INPUT:
%         M : Number of rows
%         M : Number of comlumns
%         p : Probability vector   [Kx1]
%
%% OUTPUT:
%         k : Sample from a categorical distribution [MxN]  
%
%% EXAMPLE:   
%      p = [1/2 1/3 1/6]; 
%      M = 50; N = 10;
%      xi = categoricalRand(M,N,p);
%      K = length(p);
%      for k = 1:K
%         frequency(k) = mean(xi(:) == k);
%      end
%      figure(1); clf
%      bar(1:K,frequency,0.2);
%      hold on; bar(1:K,p,0.05,'r'); hold off
%      legend('sample','p');
%      title(sprintf('%s %s Categorical[p,%d]','\xi','\sim',K))

%% Generate probability intervals
p = cumsum([0; p(:)]);

%% Sample from U[0,1]
k = rand(M,N);
%% Sample from Categorical[p,K]
for m = 1:M
    for n = 1:N
        k(m,n) = sum(k(m,n) > p);
    end
end
