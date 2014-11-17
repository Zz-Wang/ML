function mLL = minusLogLikelihood(parameters,pdf,X)
%% minusLogLikelihood: minus the likelihood of a model pdf, given the data sample X
%
%% SYNTAX:
%        mLL = minusLogLikelihood(parameters,pdf,X)
%
%% INPUT:
%
%    parameters : Parameters of the model pdf
%           pdf : Model pdf
%             X : Sample
%
%% OUTPUT:
%           mLL : value of minus the loglikelihood, normalized by the sample size
%

%% Transform vector of parameters to a cell array
parameters = num2cell(parameters(:),2);

%% Compute minus the log likelihood
mLL = -sum(log(pdf(X,parameters{:})));

