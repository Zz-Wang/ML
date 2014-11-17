%% Load the data
S = load('prices_HAL_MUUM.txt');
%Problem 1
%% data for HAL
% Time series of daily closing prices
S_HAL = S(:,1);
% Time series of log returns
r_HAL = log(S_HAL(2:end) ./ S_HAL(1:end-1));


%K = 1500;
%p     = [ 1/2 1/2];
%mu    = [-0.03 0.02];
%sigma = [ 1.0 3.0];

k=2;
[p, mu, sigma] = expectationMaximizationGM(r_HAL,k)
%p =

%    0.0853    0.9147


%mu =

%   -0.0041    0.0020


%sigma =

%    0.0601    0.0139


%Problem 2
%% data for MUUM
% Time series of daily closing prices
S_MUUM = S(:,2);
% Time series of log returns
r_MUUM = log(S_MUUM(2:end) ./ S_MUUM(1:end-1));


k=3;
[p, mu, sigma] = expectationMaximizationGM(r_MUUM,k)
%p =

%    0.5522    0.3882    0.0596


%mu =

%    0.0008    0.0010    0.0037


%sigma =

%    0.0143    0.0070    0.0368


