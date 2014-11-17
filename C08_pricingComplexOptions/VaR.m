%Simulate the losses of a portfolio assuming that 
%they follow a mixture of two Gaussians using the
%command 

%with 
M = 1e5; N = 1;  p = [0.8; 0.2];
mu = [-0.1; -0.2];
sigma = [1.0; 3.0]; 
simulatedLoss = GMrand(M,N,p,mu,sigma); 
%The estimates of the value at risk and the expected
%shortfall at a probability level pVaR are approximately
pVaR = 0.95