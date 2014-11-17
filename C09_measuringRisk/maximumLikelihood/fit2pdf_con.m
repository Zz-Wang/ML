function [logLikelihood, varargout] = fit2pdf_con(X,pdf,parameters0,lb,ub)
%% fit2pdf_con: ML fit to a pdf, considering lower and upper bound constraints
%
%% SYNTAX:
%        [logLikelihood, varargout] = fit2pdf_con(X,pdf,parameters0,lb,ub)
%
%% INPUT:
%             X : Sample
%           pdf : Model pdf
%   parameters0 : Seed for the parameters
%            lb : lower bound constraints for the parameters
%            ub : upper bound constraints for the parameters
%
%% OUTPUT:
% logLikelihood : value of the loglikelihood
%    varargaout : list of parameters than maximize the likelihood
%
%% EXAMPLE: 
%    data = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
%    S_GOOG = data(:,2);
%    r_GOOG = diff(log(S_GOOG));
% 
%    % Gaussian fit
%    mu0 = 0.0; sigma0 = 1.0;
%    [LL, mu,sigma] = fit2pdf_con(r_GOOG,@normpdf,[mu0,sigma0],[-Inf 1e-5], [Inf Inf])
%    mean(r_GOOG), std(r_GOOG,1)  % compare to sample mean and stdev
%    modelPdf = @(x)(normpdf(x,mu,sigma));
%    figure(1); graphicalComparisonPdf(r_GOOG,modelPdf) 
%    title('Normal fit for log returns GOOG')
%
%    % Student's t fit
%    mu0 = mean(r_GOOG); nu0 = 5; sigma0 = sqrt(var(r_GOOG)*(nu0-2)/nu0); 
%    [LL, mu,sigma,nu] = fit2pdf_con(r_GOOG,@locationScaleTpdf,[mu0,sigma0,nu0],[-Inf 1e-5 1e-5], [Inf Inf Inf])
%    modelPdf = @(x)(locationScaleTpdf(x,mu,sigma,nu));
%    figure(2); graphicalComparisonPdf(r_GOOG,modelPdf) 
%    title('t Student fit for log returns GOOG')

%   Copyright Alberto Suarez 
%   $Revision: 0.0 $  $Date: 2013/07/09 17:00:00 $

try
    % GNU Octave 
    [parameters, minusLL] =  sqp(parameters0,@(parameters)minusLogLikelihood(parameters,pdf,X),[],[],lb,ub);
catch
    % Matlab optimization toolbox
    options = optimset('fmincon');
    options = optimset('Algorithm','interior-point');
    [parameters, minusLL] =  fmincon(@(parameters)minusLogLikelihood(parameters,pdf,X),parameters0,[],[],[],[],lb,ub,[],options);
end
varargout = num2cell(parameters(:),2);
logLikelihood = - minusLL;