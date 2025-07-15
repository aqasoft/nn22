% ~~~~~~~ Constantes de inicializacion  ~~~~~~~
% ------- Red: sine -------
%

% ~~~~~~~ Constantes de inicializacion de nn_initializeNN (Weights) ~~~~~~~
%
rndWeightsDistribution = 'normal';     % normal, uniform
rndWeightsMean = 0;
rndWeigthsDev = 0.5;

% ~~~~~~~ Constantes de inicializacion de nn_trainNN ~~~~~~~
%
trainIterations = 1000;  % Epocas
trainError = .001;       % Error que finaliza
trainEtaGain = .1;       % Ganancia de aprendizaje
trainShowTime = 10.0;    % Cada cuanto tiempo avisa por donde va (en segundos)

% ~~~~~~~ Constantes de inicializacion de nn_loadIOdata ~~~~~~~
%
ioLoadGenerate = 0;      % Cargar Datos (1=Cargar, 0=Generar) 
ioNormalizeData = 1;     % ioNormalizeData (1=si, 0=no)
ioMaxMinVsMeanDev = 1;   % ioMaxMinVsMeanDev (1=MaxMin, 0=MeanDev)

% ~~~~~~~ Constantes de inicializacion de _createIOdata ~~~~~~~
%
genExactOrRandom = 0; % 1=exact, 0=random; en desuso, definida por nn_loadIOdata
genNumPairs = 100;    % f(tamano de la red); ver % al final de nn_loadIOdata
