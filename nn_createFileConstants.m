function [returnOK] = nn_createFileConstants(nnFilesConstants)
    % =========== Create a standard Constants file =============
    %    function [returnOK] = nn_createFileConstants(nnFilesConstants)
    %    
    %    Parameters:
    %    nnFilesConstants: The name of the file.
    %    
    %    Generates the Constants that will be used to calibrate the system.
    %    They are stored inside nnData, which is defined as global.
    %    They are saved when nnData is saved after training.
    %    
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    
    fprintf('Creating a new Constants file ''%s''...\n\n', nnFilesConstants);
    
    try
        fileAux = fopen(nnFilesConstants, 'w');

        fprintf(fileAux, '%% ~~~~~~~ Initialization Constants  ~~~~~~~\r\n');
        fprintf(fileAux, '%% ------- Neural Network: _____ -------\r\n');
        fprintf(fileAux, '%%\r\n');
        fprintf(fileAux, '\r\n');
        fprintf(fileAux, '%% ~~~~~~~ Initialization Constants for nn_initializeNN (Weights) ~~~~~~~\r\n');
        fprintf(fileAux, '%%\r\n');
        fprintf(fileAux, 'rndWeightsDistribution = ''normal''; %% normal, uniform\r\n');
        fprintf(fileAux, 'rndWeightsMean = 0;\r\n');
        fprintf(fileAux, 'rndWeigthsDev = 0.25;\r\n');
        fprintf(fileAux, '\r\n');
        fprintf(fileAux, '%% ~~~~~~~ Initialization Constants for nn_trainNN ~~~~~~~\r\n');
        fprintf(fileAux, '%%\r\n');
        fprintf(fileAux, 'trainIterations = 1000; %% Epochs\r\n');
        fprintf(fileAux, 'trainError = .001; %% Ending error\r\n');
        fprintf(fileAux, 'trainEtaGain = 0.5; %% Learning gain\r\n');
        fprintf(fileAux, 'trainShowTime = 1.0;    %% Time between progress messages during training (seconds)\r\n');
        fprintf(fileAux, '\r\n');
        fprintf(fileAux, '%% ~~~~~~~ Initialization Constants for nn_loadIOdata ~~~~~~~\r\n');
        fprintf(fileAux, '%%\r\n');
        fprintf(fileAux, 'ioLoadGenerate = 0; %% Load Data (1=Load, 0=Generate) \r\n');
        fprintf(fileAux, 'ioNormalizeData = 1; %% ioNormalizeData (1=yes, 0=no)\r\n');
        fprintf(fileAux, 'ioMaxMinVsMeanDev = 0; %% ioMaxMinVsMeanDev (1=MaxMin, 0=MeanDev)\r\n');
        fprintf(fileAux, '\r\n');
        fprintf(fileAux, '%% ~~~~~~~ Initialization Constants for (aux)_createIOdata ~~~~~~~\r\n');
        fprintf(fileAux, '%%\r\n');
        fprintf(fileAux, 'genExactOrRandom = 0; %% 1=exact, 0=random; should be set by nn_loadIOdata\r\n');
        fprintf(fileAux, 'genNumPairs = 100; %% is f(NN size); see %% at the end of nn_loadIOdata\r\n');
        
        fclose(fileAux);

    catch 
        if (~isempty(fileAux)) 
            fclose(fileAux); end
        fprintf('\n\n');
        fprintf(msG.errorWritingFile_VAR1, nnFilesConstants); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 0; return,
    end
    
    returnOK = 1; return
end