function [returnOK] = nn_loadIOdata(ioLoadGenerate, ioNormalizeData, ioMaxMinVsMeanDev, genNumPairs)
    % =========== Load training data =============
    %     function [returnOK] = 
    %      nn_loadIOdata(ioLoadGenerate, ioNormalizeData, ioMaxMinVsMeanDev, genNumPairs)
    %
    %    Parameters:
    %    ioLoadGenerate (1=Load, 0=Generate) 
    %    ioNormalizeData (1=yes, 0=no)
    %    ioMaxMinVsMeanDev (1=yes, 0=no)
    %    genNumPairs (abort if empty and ioLoadGenerate es 0=Generate)
    %
    %    - Loads input training data into nnIO.ioInputTrain, 
    %      and loads ideal output into nnIO.ioIdealTrain
    %    - Generates the normalization structure
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global nnData;
    global nnIO;
    global msG;
    
        a_a = 0;    % Load data (1=Load, 0=Generate) 
        a_b = 0;    % ioNormalizeData (1=yes, 0=no)
        a_c = 0;    % ioMaxMinVsMeanDev (1=yes, 0=no)
        a_d = 10;   % genNumPairs (nonzero if ioLoadGenerate is 0=Generate)
    switch nargin   % Complete optional arguments
        case 0
            ioLoadGenerate = a_a; ioNormalizeData = a_b; ioMaxMinVsMeanDev = a_c; 
        case 1
            ioNormalizeData = a_b; ioMaxMinVsMeanDev = a_c;
        case 2
            ioMaxMinVsMeanDev = a_c; 
    end
    % ----- If genNumPairs is empty && ioLoadGenerate is 0=Generate, abort -----
    if (nargin < 4 && ioLoadGenerate == 0) 
        fprintf(msG.theParameter_VAR1_IsMandatory, 'genNumPairs');
        returnOK = 0; return, end 
    
    % ----- If nnData does not exist, abort -----
    if isempty(nnData)
        fprintf(msG.theNNMustBeFirstInitializedBeforeIODataIsGenerated); 
        returnOK = 1; return; end
    
    % ----- Initialize Normalize structure just once -----
    if isempty(nnIO)
        nnIO.Normalize = struct( ...
            'muInput', 0, ...
            'sigmaInput', 0, ...
            'rangeInput', 0, ...
            'muOutput', 0, ...
            'sigmaOutput', 0, ... 
            'rangeOutput', 0); 
        nnIO.DataIsNormalized = 0;     % (1=yes, 0=no)
    end
    
    % ----- Decide if Loading or Generating training pairs -----
    
    if (ioLoadGenerate) % (1=Load, 0=Generate)
        % ----- Load training pairs -----
        fprintf(msG.loadingTrainingData_Input_OutputPairs);
        try
            nnIO.Input = load(nnData.Files.ioInputTrain, '-ascii');
            nnIO.Ideal = load(nnData.Files.ioIdealTrain, '-ascii');
            if exist(nnData.Files.ioInputTest) 
                nnIO.InputTest = load(nnData.Files.ioInputTest, '-ascii');
            else 
                fprintf(msG.errorReadingFile_VAR1_TrainingDataWillBeLoadedInstead, nnData.Files.ioInputTest);
                nnIO.InputTest = nnIO.Input; % cheat ;)
            end
            if exist(nnData.Files.ioIdealTest) 
                nnIO.IdealTest = load(nnData.Files.ioIdealTest, '-ascii');
            else 
                fprintf(msG.errorReadingFile_VAR1_TrainingDataWillBeLoadedInstead, nnData.Files.ioIdealTest);
                nnIO.IdealTest = nnIO.Ideal; % cheat ;)
            end
        catch
            clear global nnIO; % Reset nnIO, so that nn22 knows it has to be loaded.
            global nnIO;
            fprintf('\n\n');
            fprintf(msG.errorReadingFile_VAR1, 'nnIO.Input/Ideal.Train/Test'); 
            fprintf(msG.error_VAR1, lasterr()); 
            returnOK = 1; return
        end
    else
        fprintf(msG.generatingTrainingData_Input_OutputPairs);
        try
            fprintf('\n\n');
            choice = menu(msG.dataIsExactOrRandom, ... 
                'Ideal: Exact, Test: Exact', ...     %1
                'Ideal: Exact, Test: Random', ...     %2
                'Ideal: Random, Test: Exact', ...     %3
                'Ideal: Random, Test: Random');     %4
            fprintf('\n\n');
            switch choice
                case 1
                    er1=1; er2=1;
                case 2
                    er1=1; er2=0;
                case 3
                    er1=0; er2=1;
                case 4
                    er1=0; er2=0;
            end
            % ----- Generate training pairs -----
            aux_createIOdata = str2func([nnData.FilesBase, '_createIOdata']);
            
            % genNumPairs for Training (er1/er2, 0=random, 1=exact)
            [returnOK, X, Y] = aux_createIOdata(nnData.FilesBase, er1, genNumPairs);
                if (~returnOK) returnOK = 0; return, end
            nnIO.Input = X; nnIO.Ideal = Y;
            save(nnData.Files.ioInputTrain, 'X', '-ascii');  % save error :( ??
            save(nnData.Files.ioIdealTrain, 'Y', '-ascii'); 
            
            % genNumPairs for Test (er1/er2, 0=random, 1=exact)
            [returnOK, X, Y] = aux_createIOdata(nnData.FilesBase, er2, genNumPairs);
                if (~returnOK) returnOK = 0; return, end
            nnIO.InputTest = X; nnIO.IdealTest = Y;
            save(nnData.Files.ioInputTest, 'X', '-ascii'); 
            save(nnData.Files.ioIdealTest, 'Y', '-ascii'); 
        catch
            clear global nnIO;
            global nnIO;
            fprintf('\n\n');
            fprintf(msG.errorWritingFile_VAR1, 'nnIO.Input/Ideal.Train/Test'); 
            fprintf(msG.error_VAR1, lasterr()); 
            returnOK = 1; return
        end
    end
    
    % ----- Verify IO training pairs -----
    if (size(nnIO.Input, 1) ~= size(nnIO.Ideal, 1) || ...
        (size(nnIO.Input, 2) ~= size(nnIO.InputTest, 2))|| ...
        (size(nnIO.Ideal, 2) ~= size(nnIO.IdealTest, 2)))
        fprintf('\n\n');
        fprintf(msG.errorTheNumberOfInputs_OutputsIsNotEqualInTrainingPairs);
        returnOK = 0; return, end
        
    nnIO.x = zeros(size(nnIO.Input)); % Just one input vector for FF
    nnIO.y = zeros(size(nnIO.Ideal)); % []; % Idem output

    
    % =========== Normalization of IO data =============
    %  mu, sigma must belong to the trained network...
    %
    if (ioNormalizeData && ~ioMaxMinVsMeanDev)
        fprintf('\n');
        fprintf(msG.normalizingTrainingData_StandardDeviation);
        nnIO.Normalize.muInput = mean(nnIO.Input);     % Vector of row size for nnIO.Input
        nnIO.Normalize.sigmaInput = std(nnIO.Input);    
        nnIO.Input = bsxfun(@minus, nnIO.Input, nnIO.Normalize.muInput);
        nnIO.Input = bsxfun(@rdivide, nnIO.Input, nnIO.Normalize.sigmaInput);
        nnIO.InputTest = bsxfun(@minus, nnIO.InputTest, nnIO.Normalize.muInput);
        nnIO.InputTest = bsxfun(@rdivide, nnIO.InputTest, nnIO.Normalize.sigmaInput);

        nnIO.Normalize.muOutput = mean(nnIO.Ideal);         
        nnIO.Normalize.sigmaOutput = std(nnIO.Ideal);    
        nnIO.Ideal = bsxfun(@minus, nnIO.Ideal, nnIO.Normalize.muOutput);     
        nnIO.Ideal = bsxfun(@rdivide, nnIO.Ideal, nnIO.Normalize.sigmaOutput);
        nnIO.IdealTest = bsxfun(@minus, nnIO.IdealTest, nnIO.Normalize.muOutput);     
        nnIO.IdealTest = bsxfun(@rdivide, nnIO.IdealTest, nnIO.Normalize.sigmaOutput);
    
    elseif (ioNormalizeData && ioMaxMinVsMeanDev)
        fprintf(msG.normalizingTrainingData_Rank);
        nnIO.Normalize.muInput = mean(nnIO.Input);     % Vector of row size for nnIO.Input
        nnIO.Normalize.rangeInput = max(nnIO.Input) - min(nnIO.Input);    
        nnIO.Input = bsxfun(@minus, nnIO.Input, nnIO.Normalize.muInput);
        nnIO.Input = bsxfun(@rdivide, nnIO.Input, nnIO.Normalize.rangeInput);
        nnIO.InputTest = bsxfun(@minus, nnIO.InputTest, nnIO.Normalize.muInput);
        nnIO.InputTest = bsxfun(@rdivide, nnIO.InputTest, nnIO.Normalize.rangeInput);

        nnIO.Normalize.muOutput = mean(nnIO.Ideal);         
        nnIO.Normalize.rangeOutput = max(nnIO.Ideal) - min(nnIO.Ideal);    
        nnIO.Ideal = bsxfun(@minus, nnIO.Ideal, nnIO.Normalize.muOutput);     
        nnIO.Ideal = bsxfun(@rdivide, nnIO.Ideal, nnIO.Normalize.rangeOutput);
        nnIO.IdealTest = bsxfun(@minus, nnIO.IdealTest, nnIO.Normalize.muOutput);     
        nnIO.IdealTest = bsxfun(@rdivide, nnIO.IdealTest, nnIO.Normalize.rangeOutput);
    end

    nnIO.DataIsNormalized = ioNormalizeData; % =1? => IO data is normalized

    returnOK = 1; return
end

% =========== The Baum-Haussler rule, 'rule of thumb' ===========
%
% Our next problem is what should the topology of the network be? 
% Firstly the input layer is easily defined to be the memory size. 
% Remember, we show the network a snapshot of where we have just been. 
% Also we are only making a 'one step ahead' prediction network so we 
% only need one output node.

% Nhidden <= (Ntrain * Etolerance)/(Ninput * Noutput)

% That just leaves the number of hidden nodes. Now there is some 
% deep maths than we can use to help us predict the number of nodes 
% and topology we will need in the hidden layers. One I will mention 
% is a 'rule of thumb' called the Baum-Haussler rule. This states that;

% Where Nhidden is the number of hidden nodes, 
% Ntrain is the number of training patterns, 
% Etolerance is the error we desire of the network, 
% Ninput and Noutput are the number of input and output nodes respectively. 
% This rule of thumb generally ensures that the network generalises 
% rather than memorises the problem.
% (http://neuroph.sourceforge.net/TimeSeriesPredictionTutorial.html)