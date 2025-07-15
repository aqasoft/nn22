function [returnOK] = nn_initializeNN(nnFilesBase, rndWeightsDistribution, rndWeightsMean, rndWeigthsDev)
    % =========== Armado de estructura de NN =============
    %    function [returnOK] = nn_createFileConstants(nnFilesConstants)
    %    
    %    Parameters:
    %    - nnFilesBase: (Base for data files, e.g.: xor, sine, etc.) 
    %    - rndWeightsDistribution: normal, uniform
    %    - rndWeightsMean: (opt, def=0) mean value for random numbers
    %    - rndWeigthsDev: (opt, def=0.25) standard for normal or +- for uniform
    %     
    %    Generates a new file for storing neurons, weights and all NN
    %    related data.
    %     
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global nnData;
    global nnIO;
    global msG;

        a_a = '';       % Base for data files, e.g.: xor, sine, etc.) 
        a_b = 'normal'; % rndWeightsDistribution: normal, uniform
        a_c = 0;        % rndWeightsMean 
        a_d = 0.25;     % rndWeigthsDev
    switch nargin       % Complete optional arguments
        case 0
            nnFilesBase = a_a; rndWeightsDistribution = a_b; rndWeightsMean = a_c; rndWeigthsDev = a_d;
        case 1
            rndWeightsDistribution = a_b; rndWeightsMean = a_c; rndWeigthsDev = a_d;
        case 2
            rndWeightsMean = a_c; rndWeigthsDev = a_d;
        case 3
            rndWeigthsDev = a_d;
    end

    % =========== Variables Initialization =============
    %
    nnData.Files = struct( ...
        'StructIni', '', ...
        'ioInputTrain', '', ...
        'ioInputTest', '', ...
        'ioIdealTrain', '', ...
        'ioIdealTest', '', ...
        'nnData', '');
    nnData.Structure = 0;
    nnData.layersTotal = 0;     % includes Input layer
    nnData.Neurons = cell(1);
    nnData.Weights = cell(1);
    nnData.Deltas = cell(1);
    nnData.Epochs = 0;          % Total Epochs that have been trained, if trained
    nnData.PredictionError = 0; % Prediction error resulting of the training
    
    % ----------{ Base for file names of this NN }----------
    if isempty(nnFilesBase)
        while (1)
            nnData.FilesBase = input(msG.enterBaseFileNameForNNFiles, 's');
            nnData.Files.StructIni = sprintf('%s%s', nnData.FilesBase, '_Structure.ini');
            if (exist(nnData.Files.StructIni, 'file')) break; end
            fprintf('\n\n');
            fprintf(msG.theFile_VAR1_DoesNotExist, nnData.Files.StructIni)
            fprintf(msG.theWorkingFolderIs_VAR1, pwd)
            if (~yes_no(msG.wantToTryAgain)) 
                returnOK = 0; return, end
        end
    else
        nnData.FilesBase = nnFilesBase;
        nnData.Files.StructIni = sprintf('%s%s', nnData.FilesBase, '_Structure.ini');
        if (~exist(nnData.Files.StructIni, 'file')) 
            fprintf('\n\n');
            fprintf(msG.theFile_VAR1_DoesNotExist, nnData.Files.StructIni);
            fprintf(msG.theWorkingFolderIs_VAR1, pwd);
            fprintf(msG.errorEndOfProgram);
                returnOK = 0; return,
        end
    end
    % ----------{ Copyright }----------
    nnData.Copyright = msG.copyrightStatement;
    nnData.LocalizationCredits = msG.localizationCredits;
    % ----------{ End of _nnData.mat structure }----------

    
    % =========== Verification and loading of NN files =============
    %
    
    % ----------{ NN file names }----------
    %
    fprintf('\n\n');
    fprintf(msG.theExistenceOfTheFollowingFilesWillBeVerifiedForTheNN_VAR1, nnData.FilesBase);
    fprintf(msG.theExistenceOfTheFollowingFiles_Underline);

    nnData.Files.StructIni = sprintf('%s%s', nnData.FilesBase, '_Structure.ini');
    nnData.Files.ioInputTrain = sprintf('%s%s', nnData.FilesBase, '_ioInputTrain.txt');
    nnData.Files.ioInputTest = sprintf('%s%s', nnData.FilesBase, '_ioInputTest.txt');
    nnData.Files.ioIdealTrain = sprintf('%s%s', nnData.FilesBase, '_ioIdealTrain.txt');
    nnData.Files.ioIdealTest = sprintf('%s%s', nnData.FilesBase, '_ioIdealTest.txt');
    nnData.Files.nnData = sprintf('%s%s', nnData.FilesBase, '_nnData.mat');
    fprintf(msG.nnStructure_VAR1,nnData.Files.StructIni);
    fprintf(msG.training_InputTrain_VAR1,nnData.Files.ioInputTrain);
    fprintf(msG.training_InputTest_VAR1,nnData.Files.ioInputTest);
    fprintf(msG.training_OutputTrain_VAR1,nnData.Files.ioIdealTrain);
    fprintf(msG.training_OutputTest_VAR1,nnData.Files.ioIdealTest);
    fprintf(msG.nnDataFile_VAR1,nnData.Files.nnData);
    
    % ----------{ Test if all NN files are there }----------
    %
    fprintf('\n\n');
    fprintf(msG.filesVerification);
    fprintf(msG.filesVerificationUnderline);
    
    try
        fields = fieldnames(nnData.Files);
        warning = 0;
        for fn = fields'
             if (~exist(nnData.Files.(fn{1}), 'file'))
                fprintf(msG.warningTheFile_VAR1_DoesNotExist, nnData.Files.(fn{1})); 
                warning = 1;
            else
                fprintf(msG.file_VAR1_VerifiedOk, nnData.Files.(fn{1}));
            end
        end
        fprintf('\n');
        if (warning)
            fprintf(msG.theWorkingFolderIs_VAR1, pwd);
            fprintf(msG.aStandardScenarioShouldHaveAllListedFilesAsExisting_);
            fprintf(msG.a_inTheWorkFolder_);
            fprintf(msG.a_note1_TrainingAndTestFiles_HavingTxtExtensionAre_);
            fprintf(msG.a_optionalDependingOnWhetherYouWillTrainOrJustTest_);
            fprintf(msG.a_butEitherForTrainingOrTestingTheyMustExist_);
            fprintf(msG.a_ifTheTxtFilesYouNeedDoNotExistYouHaveToCreateThem_);
            fprintf(msG.a_withRealDataOrYouMayUseTheCorrespondingOption_);
            fprintf(msG.a_fromTheMainMenu_inVersionnn22ItIsOption3_);
            fprintf(msG.a_writeDownThisPendingTask_TheProgramWillNotMakeItForYou_);
            fprintf(msG.a_note2_theNNDataFile_with_matExtension_MustExist_);
            fprintf(msG.a_ifThe_matFileDoesNotExistANewOneWillBeCreatedNowCleanEmpty);
            
            if (yes_no(msG.doYouWantToInterruptExecutionAndVerifyYourWorkingFolder)) 
                returnOK = 0; return, end
            fprintf('\n\n');
            
            % If the user decides to continue, the .mat file is saved at the 
            % end of this function, containing the data generated below.

        end
    catch 
        fprintf('\n\n');
        fprintf(msG.errorReadingFile_VAR1, nnData.Files.(fn{1})); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 0; return, 
    end


    % =========== Construct of the NN's structure =============
    %    The NN's structure (inside the .ini file) is defined by:
    %    a) Row = Layers
    %    b) Col = Layer#, #Neurons (w/o Bias), ActivationF(), FIR_FB, nnName
    %
    
    fprintf('\n');
    fprintf(msG.loadingNNStructureDefinition);
    fprintf(msG.loadingNNStructureDefinitionUnderline);

    try
        fileAux = fopen(nnData.Files.StructIni);
        cellArray = textscan(fileAux, '%f %f %s %f %s', 'delimiter', ',', 'EmptyValue', 0, 'commentstyle', '%');
        nnData.Structure = cell2struct(cellArray', {'layerNumber', 'layerNeurons', 'layerActivation', 'FIR_FB', 'fileNames'}, 1);
        fclose(fileAux);
    catch
        if (~isempty(fileAux)) 
            fclose(fileAux); end
        fprintf('\n\n');
        fprintf(msG.errorReadingFile_VAR1, nnData.Files.StructIni); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 0; return, 
    end
    
    
    % =========== Build neurons layers =============
    %    With as many matrices as layers
    %    Initialize neurons, #cell=#layers, including 1st_layer=Input
    % 
    fprintf(msG.generatingNeurons_FromScratch_ForTheNN);

    nnData.layersTotal = length(nnData.Structure.layerNeurons);
    for i = 1:nnData.layersTotal
        % Rows: #neurons/layer (+1 for Bias is moved to Feedforward), 
        % Columns: 1st=Sum, 2nd=Activation
        m = nnData.Structure.layerNeurons(i);         % m=this_layer
        nnData.Neurons{i} = zeros(m, 2);
    end

    % BIAS: In order to easy the Feedforward with Bias, add a row to each layer
    for i = 1:nnData.layersTotal
        nnData.Neurons{i} = [ones(1,size(nnData.Neurons{i},2)) ; nnData.Neurons{i}];
    end

    % =========== Load NN's weights =============
    %
    
    fprintf(msG.generatingWeights_FromScratch_ForTheNN);

    nnData.Weights{1} = [0]; % Not used, but let's not leave it empty
    for i = 2:nnData.layersTotal
        % Generate r vector with normal distribution, a mean and b standard deviation: r = a + b .* randn(10,1);
        m = nnData.Structure.layerNeurons(i);       % m=this_layer
        n = nnData.Structure.layerNeurons(i-1);     % n=previous_layer
        if isequal(rndWeightsDistribution, 'normal')
            nnData.Weights{i} = rndWeightsMean .* ones(m, n+1) + rndWeigthsDev .* randn(m, n+1);     % n+1=previous_layer+bias
        else
            nnData.Weights{i} = (rndWeightsMean-rndWeigthsDev) .* ones(m, n+1) + (2* rndWeigthsDev) .* rand(m, n+1);
        end
    end

    % Reset training data also
    nnData.Epochs = 0;          % Total Epochs that have been trained, if trained
    nnData.PredictionError = 0; % Prediction error resulting of the training
    
    % If _nnData.mat does not exist, create it now, with empty data
    nnFilesnnData = sprintf('%s%s', nnFilesBase, '_nnData.mat');
    if (~exist(nnFilesnnData, 'file')) 
        try
            % Save NN's data file, both in Matlab v7 format (for compatibility)
            %   and in Octave's text data format (Octave's default). 
            %   Octave's default text data format is human readable.
            %   Check convert_MatFileOctaveToMatlab() included in this package.
            %
            save(nnData.Files.nnData, 'nnData', '-v7');       % Matlab v7 format
            if (exist('OCTAVE_VERSION', 'builtin') == 5)      % running Octave?
                save([nnData.Files.nnData, '.txt'], 'nnData', '-text'); 
            end
        catch
            fprintf('\n\n');
            fprintf(msG.errorWritingFile_VAR1, nnFilesnnData); 
            fprintf(msG.error_VAR1, lasterr()); 
            returnOK = 0; return,
        end
    
        fprintf(msG.theDataFileForNN_VAR1_HasBeenCreatedEmpty, nnFilesnnData)
        fprintf('\n\n')
    end
    
    
    returnOK = 1; return
end

