% ~~~~~~~ Constantes de inicializacion  ~~~~~~~
% ------- Red: XOR -------
%

% ~~~~~~~ Constantes de inicializacion de nn_initializeNN (Weights) ~~~~~~~
%    
rndWeightsDistribution = 'normal';     % normal, uniform
rndWeightsMean = 0;
rndWeigthsDev = 0.25;

% ~~~~~~~ Constantes de inicializacion de nn_trainNN ~~~~~~~
%    
trainIterations = 1000;  % Epocas
trainError = .01;        % Error que finaliza
trainEtaGain = 0.5;      % Ganancia de aprendizaje
trainShowTime = 1.0;     % Cada cuanto tiempo avisa por donde va (en segundos)

% ~~~~~~~ Constantes de inicializacion de nn_loadIOdata ~~~~~~~
%    
ioLoadGenerate = 0;      % Cargar Datos (1=Cargar, 0=Generar) 
ioNormalizeData = 1;     % ioNormalizeData (1=si, 0=no)
ioMaxMinVsMeanDev = 0;   % ioMaxMinVsMeanDev (1=MaxMin, 0=MeanDev)

% ~~~~~~~ Constantes de inicializacion de _createIOdata ~~~~~~~
%    
genExactOrRandom = 0; % 1=exact, 0=random; en desuso, definida por nn_loadIOdata
genNumPairs = 40;     % f(tamaño de la red); ver % al final de nn_loadIOdata

        