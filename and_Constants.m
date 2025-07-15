% ~~~~~~~ Initialization Constants  ~~~~~~~
% ------- Neural Network: AND -------
%

% ~~~~~~~ Initialization Constants for nn_initializeNN (Weights) ~~~~~~~
%
rndWeightsDistribution = 'normal'; % normal, uniform
rndWeightsMean = 0;
rndWeigthsDev = 0.25;

% ~~~~~~~ Initialization Constants for nn_trainNN ~~~~~~~
%
trainIterations = 1000; % Epochs
trainError = .1; % Ending error
trainEtaGain = 0.25; % Learning gain
trainShowTime = 1.0;    % Time between progress messages during training (seconds)

% ~~~~~~~ Initialization Constants for nn_loadIOdata ~~~~~~~
%
ioLoadGenerate = 0; % Load Data (1=Load, 0=Generate) 
ioNormalizeData = 1; % ioNormalizeData (1=yes, 0=no)
ioMaxMinVsMeanDev = 0; % ioMaxMinVsMeanDev (1=MaxMin, 0=MeanDev)

% ~~~~~~~ Initialization Constants for (aux)_createIOdata ~~~~~~~
%
genExactOrRandom = 0; % 1=exact, 0=random; should be set by nn_loadIOdata
genNumPairs = 40; % is f(NN size); see % at the end of nn_loadIOdata
