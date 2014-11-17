function sample = empiricalRand(M,N,X)
%% empiricalRand: bootstrap sample from X
%
%% SYNTAX:
%          sample = empiricalRand(M,N,X)
%
%% INPUT:
%      [M,N]: Dimensions of the output matrix
%         X : Sample [any size]
%
%% OUTPUT:
%    sample : bootstrap sample from X [M,N]    
%

%% Sample as a column vector
X = X(:);

%% Sample from U[0,1]
U = rand(M,N);

%% Bootstrap sample
indices = ceil(U*length(X));
sample  = X(indices);
