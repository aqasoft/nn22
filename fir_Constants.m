% ~~~~~~~ Constantes de inicializacion  ~~~~~~~
% ------- Red: SENO -------
%

% ~~~~~~~ Constantes de inicializacion de nn_inicializarNN (Weights) ~~~~~~~
%
rndWeightsDistribution = 'uniform'; % normal, uniform
rndWeightsMean = 0;
rndWeigthsDev = 0.5;

% ~~~~~~~ Constantes de inicializacion de nn_entrenarNN ~~~~~~~
%
trainIterations = 1000; % Epocas
trainError = .001; % Error que finaliza
trainEtaGain = 0.005; % Ganancia de aprendizaje
trainShowTime = 1.0;	% Cada cuanto tiempo avisa por donde va (en segundos)

% ~~~~~~~ Constantes de inicializacion de nn_cargarIOdata ~~~~~~~
%
ioCargarGenerar = 0; % Cargar Datos (1=Cargar, 0=Generar) 
ioNormalizeData = 1; % ioNormalizeData (1=si, 0=no)
ioMaxMinVsMeanDev = 1; % ioMaxMinVsMeanDev (1=MaxMin, 0=MeanDev)

% ~~~~~~~ Constantes de inicializacion de _generarIOdata ~~~~~~~
%
genExactOrRandom = 0; % 1=exact, 0=random; en desuso, definida por nn_cargarIOdata
genNumPairs = 100; % f(tamaño de la red); ver % al final de nn_cargarIOdata
