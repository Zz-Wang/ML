function Y = rejectionSampling(M,N,f_X,f_Y,A,rndX)
%% rejectionSampling: Sampling from a univariate distribution by rejection sampling
%
%% SYNTAX: 
%        Y = rejectionSampling(M,N,f_X,f_Y,A,rndX)
%
%% INPUT:
%
%        M,N : Number of rows and columns
%        f_X : Handle of origin pdf
%        f_Y : Handle of target pdf
%          A : Scale factor
%       rndX : Handle of a function that generates X ~ f_X
%
%% OUTPUT:
%          Y : Sample of size [M x N] from the distribution f_Y. 
%
%% EXAMPLE:
%        p      = [1/2 1/3 1/6]; 
%        mu     = [-1.0 4.0 12.0];
%        sigma  = [ 1.0 3.0  0.5];
%        f_Y    = @(x)(GMpdf(x,p,mu,sigma));
%        mu0    = 4; 
%        sigma0 = 8;
%        f_X    = @(x)(normpdf(x,mu0,sigma0));
%        rndX   = @()(mu0+sigma0*randn);
%        A      = 6;
%
%        figure(1);
%        nPlot  = 1000;
%        xPlot  = linspace(-10,20,nPlot);
%        plot(xPlot,A*f_X(xPlot),xPlot,f_Y(xPlot)) 
%
%        M = 10; N = 1000;
%        Y = rejectionSampling(M,N,f_X,f_Y,A,rndX);
%        figure(2); graphicalComparisonPdf(Y(:),f_Y)
%

sampleLength = M*N;
Y = zeros(1,sampleLength);

i = 0;
while i < sampleLength
    sample = rndX();
    
    fx = A*f_X(sample);
    fy = f_Y(sample);
    
    assert(fx > fy, 'A*f_X is not a valid envelope for f_Y');
    
    % If the u ~ U[0,fx] is below fy, accept x.
    u  = fx*rand();
    if u < fy
        i = i + 1;
        Y(i) = sample;
    end
    % Otherwise, reject it.
end
Y = reshape(Y,M,N);
