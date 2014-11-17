function p = empiricalCdf(x,X)
%% empiricalCdf: empirical cdf for the sample X
%
%% SYNTAX:
%         p = empiricalCdf(x,X)
%
%% INPUT:
%         x : points for evaluation of the empirical cdf [nRows,nColumns]
%         X : Sample [any size]
%
%% OUTPUT:
%         p : Values of the empirical cdf                [nRows,nColumns]
%


%% Allocate output
p = zeros(size(x));

%% Sample size
X = X(:);      % Sample as column vector
M = length(X);

%% Sort the values in the sample
sortedX = sort(X);

%% Remove duplicates (and save the index of the last occurrence of every value)
lastIndices = [find(diff(sortedX)); M];
validX = sortedX(lastIndices);

%% Probabilities of sample values
pValidX = ([0; lastIndices(1:(end-1))] + lastIndices) / (2*M); % This is [1 3 ... 2M-1] / (2M) if all the values in X are different

%% Out of sample values
p(x < validX(1))   = 0;
p(x > validX(end)) = 1;

%% Special case: single value in sample (might cause problems in interpolation)
if length(validX) == 1
    p(x == validX(1)) = pValidX(1);
    return;
end

%% Linear interpolation 
indices = (x >= validX(1)) & (x <= validX(end));

p(indices) = interp1(validX,pValidX,x(indices));
