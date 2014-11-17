function U = linearCongruentialRand(N,a,c,m,k)
%% linearCongruentialRand: linear congruential generator for U[0,1]
%
%% SYNTAX:
%        U = linearCongruentialRand(N,a,c,m,k)
%
%% INPUT:
%        N  : Number of U[0,1] samples to generate
%        a  : Multiplier
%        c  : Increment
%        m  : Modulus
%        k  : Seed of the generator        
%
%% OUTPUT:
%        U  :  column vector with N samples from U[0,1]             
%
%% EXAMPLE:   
%         m = 2^31-1;   % generate integers in  the range 0..(m-1)
%         a = 7^5;      % multiplier 
%         c = 0;        % increment
%         k = 1969;  % seed
%         N = 30000; % number of samples
%         U = linearCongruentialRand(N,a,c,m,k);
%         figure(3); clf;
%         nBins = 40; hist(U,nBins);
%         title('Park & Miller LCG')


%% Initialize U
U = zeros(1,N);        

%% Transform seed into  ~ U[0,1]
U(1) = k/m;            

%% Linear congruential generator
for n = 2:N
    k = mod(a*k+c,m);  % 0 <= k < m
    U(n) = k/m;        % ~ U[0,1]
end
