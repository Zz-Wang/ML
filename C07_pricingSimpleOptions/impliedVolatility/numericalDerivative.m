function  derivative = numericalDerivative(f,x0,h)
% numericDerivative: Numerical estimate of the derivative of f at x0
%
% SYNTAX:
%        derivative = numericalDerivative(f,x0,h)
%
% INPUT:
%            f : Handle to the function whose derivative is being calculated
%           x0 : Point at which the derivative is calculated
%            h : Parameter for divided differences (1e-5 - 1e-6)
%
% OUTPUT:
%   derivative : Value of the derivative of f at x0  
%
% EXAMPLE:   
%            N = 8; h = logspace(-N,-1,N);
%            log10(h)
%            log10_error = log10(abs(1- numericalDerivative(@sin,2*pi,h)))
%            log10_error = log10(abs(1- numericalDerivative(@exp,0,h)))
%          

if x0 == 0
    derivative = (f(x0+h)-f(x0-h))./(2*h);
else
    derivative = (f(x0*(1+h))-f(x0*(1-h)))./(2*x0*h);
end    



