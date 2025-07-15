function [returnOK] = nn_loadNN(nnFilesBase)
    % =========== Load the NN in whatever state it is =============
    %    function [returnOK] = nn_loadNN(nnFilesBase)
    %    
    %    Parameters:
    %    - nnFilesBase (Base for data files, e.g.: xor, sine, etc.) 
    %     
    %    Loads trained weights and all other NN related data.
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global nnData;
    global msG;
    
    try    
        if isempty(nnFilesBase)
            fprintf('\n\n');
            fprintf(msG.warningMissingParameter, 'nnFilesBase')
            returnOK = 0; return
        end

        % OK, the .ini exists...
        % ...but if _nnData.mat does not exist, it has to be initialized
        nnFilesnnData = sprintf('%s%s', nnFilesBase, '_nnData.mat');
        if (~exist(nnFilesnnData, 'file'))
            fprintf('\n\n');
            fprintf(msG.warningTheFile_VAR1_DoesNotExist, nnFilesnnData)
            fprintf(msG.theNNWasNotLoaded); 
            fprintf(msG.theNNMustBeFirstInitializedBeforeItCanBeLoaded); 
            returnOK = 0; return, 
        end
        
        fprintf('\n');
        fprintf(msG.loadingNN_MaybeTrainedOrNot);
        load(nnFilesnnData, 'nnData');
        
    catch 
        fprintf('\n\n');
        fprintf(msG.errorLoadingNN); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 0; return
    end

    returnOK = 1; return
end
