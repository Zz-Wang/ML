function [logLikelihood, varargout] = fit2pdf(X,pdf,parameters0)
%% fit2pdf: ML fit to a pdf
%
%% SYNTAX:
%        [logLikelihood, varargout] = fit2pdf(X,pdf,parameters0)
%
%% INPUT:
%             X : Sample
%           pdf : Model pdf
%   parameters0 : Seed for the parameters
%
%% OUTPUT:
% logLikelihood : value of the loglikelihood
%    varargaout : list of parameters than maximize the likelihood
%
%% EXAMPLE:   
%
%    data = load('closingPrices_IBM_GOOG_SI_2007_07_01_2013_06_30.txt');
%    S_GOOG = data(:,2);
%    r_GOOG = diff(log(S_GOOG));
% 
%    % Gaussian fit
%    mu0 = 0.0; sigma0 = 1.0;
%    [LL, mu,sigma] = fit2pdf(r_GOOG,@normpdf,[mu0,sigma0])
%    mean(r_GOOG), std(r_GOOG,1)  % compare to sample mean and stdev
%    modelPdf = @(x)(normpdf(x,mu,sigma));
%    figure(1); graphicalComparisonPdf(r_GOOG,modelPdf) 
%    title('Normal fit for log returns GOOG')
%
%    % Student's t fit
%    mu0 = mean(r_GOOG); nu0 = 5; sigma0 = sqrt(var(r_GOOG)*(nu0-2)/nu0); 
%    [LL, mu,sigma,nu] = fit2pdf(r_GOOG,@locationScaleTpdf,[mu0,sigma0,nu0])
%    modelPdf = @(x)(locationScaleTpdf(x,mu,sigma,nu));
%    figure(2); graphicalComparisonPdf(r_GOOG,modelPdf) 
%    title('t Student fit for log returns GOOG')

%   Copyright Alberto Suarez 
%   $Revision: 0.0 $  $Date: 2013/07/09 17:00:00 $

[parameters, minusLL] =  fminsearch(@(parameters)minusLogLikelihood(parameters,pdf,X),...
                                     parameters0);
varargout = num2cell(parameters(:),2);
logLikelihood = - minusLL;