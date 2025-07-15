function [returnOK] = nn_localization_en_US()
    % =========== Load localized messages =============
    %   function [returnOK] = nn_localization_xx-XX()
    %     
    %   - msG needs to be declared as global into every file that 
    %     uses localized messages.
    %   - WARNING: Max variable name length = 63
    %     >> namelengthmax
    %     ans = 63
    %   - Max recommended text for 'yes_no' function is 64 chars.
    %     Max text per message line to screen should be kept under 80 chars.
    %   
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global msG;

    % ----- Declare and define all localized messages -----
    %   
    msG.activeLocale = 'English (en-US)';
    % msG.activeLocale = 'Spanish (es-AR)';
    
    % -----{ nn22.m }-----
    msG.successLoadingLocalizationData = 'Localization data was loaded successfully.\n';
    msG.pressEnterToContinue = 'Press Enter to continue';
    msG.nn22ProgramTitle =          'nn22 Neural Networks (didactic framework)\n';
    msG.nn22ProgramTitleUnderline = '=========================================\n\n';
    msG.enterBaseFileNameForNNFiles = 'Enter the Base file name for all NN files (without extension): ';
    msG.warningTheFile_VAR1_DoesNotExist = '-> WARNING: The file ''%s'' does not exist...\n';
    msG.theWorkingFolderIs_VAR1 = 'The current folder is: \n-> ''%s''\n\n';
    msG.doYouWantToTryAgain = 'Do you want to try again? ';
    msG.theConstantsFileDoesNotExist = 'The constants file does not exist.\n';
    msG.itWillBeCreatedFromTemplateAndThenYouMayEditIt = 'It will be created from a template and then you may edit it.\n\n';
    msG.nowAnEditorWillOpenTheConstantsFileForNN_VAR1 = 'Now an editor will open the constants file for NN ''%s''...\n';
    msG.whenFinishedEditingAndSavedPressEnterToContinue = 'When finished editing and saved the constants file, press Enter to continue.\n...\n\n';
    msG.constantsFromNN_VAR1_WillBeLoadedIntoWorkspace = 'Constants from NN ''%s'' will be loaded into workspace.\n\n';
    msG.chooseAnAction = 'Choose an action: ';
    msG.loadExistingNN = 'Load existing NN';
    msG.intializeNN_CreateOrReset_ = 'Initialize NN (create or reset)';
    msG.load_RegenerateTrainingData_AndEvaluationData_ = 'Load/(re)generate training data (and evaluation data)';
    msG.trainSetOfEpochs = 'Train a set of Epochs';
    msG.feedAn_IOInput_SetThroughFeedforward = 'Feed an IO.Input set through the FF function';
    msG.feedAn_IOInputTest_SetThroughFeedforward = 'Feed an IO.InputTest set through the FF function';
    msG.plotInputVsOutput = 'Plot Input vs Output (real from NN)';
    msG.plotIdealOrTestOutputVsRealOutput = 'Plot Output (ideal or test file) vs Output (real from NN)';
    msG.editConstantsFile = 'Edit the constants file';
    msG.keyboardInterruptToWorkspace = 'Keyboard (interrupt to workspace)';
    msG.exitProgram = 'Exit program';
    msG.fileBaseIs_VAR1 = 'NN''s file base is ''%s''...\n\n';
    msG.doYouWantToChangeIt = 'Do you want to change it? ';
    msG.chooseLoad_Regenerate = 'Choose Load/Regenerate: ';
    msG.loadExistingIOData = 'Load existing IO data';
    msG.regenerateNewIOData = 'Regenerate new IO data';
    msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And = 'Warning: a) You must first load or initialize a NN and\n';
    msG.warning_B_LoadOrRegenerateTrainingData =         '         b) load or regenerate training data.\n';
    msG.backToMainMenuWithoutTraining = 'Back to main menu without training...\n\n';
    msG.enterNumberOfEpochsToTrain = 'Enter the number of Epochs to train (0=none): ';
    msG.alreadyTrainedEpochs_VAR1_additionalEpochsToTrain_VAR2 = '#Epochs already trained: %d, #Epochs to be trained: %d \n';
    msG.nnHasBeenFedWithIdealData_ = 'The NN has been fed with ideal data...\n';
    msG.nnHasBeenFedWithTestData_ = 'The NN has been fed with test data...\n';
    msG.a_nowYouMayPlotTheResults = '...you may now plot the results.\n\n';
    msG.warningYouShouldFeedforwardTheIODataSetBeforePlotting  = 'Warning: You should first Feedforward the IO data set before plotting.\n';
    msG.doYouWantToExit = 'Do you want to exit the program? ';
    msG.endOfProgram = 'END of program.\n\n';
    
    % -----{ nn_initializeNN.m }-----
    msG.errorEndOfProgram = 'ERROR, end of program.\n\n';
    msG.copyrightStatement = 'Copyright (C) 2014 Alejandro Quiroga Alsina';
    msG.localizationCredits = ['Spanish (es-AR) by Alejandro Quiroga Alsina'; ...
                               'English (en-US) by Alejandro Quiroga Alsina'];
    msG.theExistenceOfTheFollowingFilesWillBeVerifiedForTheNN_VAR1 = 'The existence of the following files will be verified for NN: ''%s''\n';
    msG.theExistenceOfTheFollowingFiles_Underline =                  '------------------------------------------------------------- ------\n';
    msG.nnStructure_VAR1 = 'NN structure: %s\n';
    msG.training_InputTrain_VAR1 = 'Training, input: %s\n';
    msG.training_InputTest_VAR1 = 'Training, input test: %s\n';
    msG.training_OutputTrain_VAR1 = 'Training, output: %s\n';
    msG.training_OutputTest_VAR1 = 'Training, output test: %s\n';
    msG.nnDataFile_VAR1 = 'Data (structure+weights+etc.) for NN: %s\n';
    msG.filesVerification =          'Files verification:\n';
    msG.filesVerificationUnderline = '-------------------\n';
    msG.file_VAR1_VerifiedOk = '-> File ''%s'' verified OK.\n';
    msG.theWorkingFolderIs_VAR1 = 'Te current folder is: \n-> ''%s''\n\n';
    msG.aStandardScenarioShouldHaveAllListedFilesAsExisting_ = 'A standard scenario should have all listed files as existing\n';
    msG.a_inTheWorkFolder_ = 'in the current folder.\n\n';
    msG.a_note1_TrainingAndTestFiles_HavingTxtExtensionAre_ = 'Note 1: Training and test files (having .txt extension) are\n';
    msG.a_optionalDependingOnWhetherYouWillTrainOrJustTest_ = '  optional, depending on whether you will train or just test.\n';
    msG.a_butEitherForTrainingOrTestingTheyMustExist_ = '  But either for training or testing, they must exist.\n';
    msG.a_ifTheTxtFilesYouNeedDoNotExistYouHaveToCreateThem_ = '  If the .txt files you need do not exist, you will have to create them,\n';
    msG.a_withRealDataOrYouMayUseTheCorrespondingOption_ = '  with your own real data or you may use the corresponding option\n';
    msG.a_fromTheMainMenu_inVersionnn22ItIsOption3_ = '  from the main menu (in version nn22 it is option 3 from the menu).\n';
    msG.a_writeDownThisPendingTask_TheProgramWillNotMakeItForYou_ = '  Write down this pending task, the program will not do it for you :)\n\n';
    msG.a_note2_theNNDataFile_with_matExtension_MustExist_ = 'Note 2: The NN data file (with .mat extension) must exist.\n';
    msG.a_ifThe_matFileDoesNotExistANewOneWillBeCreatedNowCleanEmpty = '  If the .mat file does no exist, a new one will be created now, clean (empty).\n\n';
    msG.doYouWantToInterruptExecutionAndVerifyYourWorkingFolder = 'Do you want to interrupt and verify your current folder? ';
    msG.errorReadingFile_VAR1 = 'ERROR reading file ''%s''.\n';
    msG.errorWritingFile_VAR1 = 'ERROR writing file ''%s''.\n';
    msG.error_VAR1 = 'ERROR: %s.\n\n';
    msG.generatingNeurons_FromScratch_ForTheNN = 'Generating neurons ''from scratch'' for the NN.\n';
    msG.generatingWeights_FromScratch_ForTheNN = 'Generating weights ''from scratch'' for the NN.\n';
    msG.loadingNNStructureDefinition =          'Loading NN structure definition.\n';
    msG.loadingNNStructureDefinitionUnderline = '--------------------------------\n\n';
    msG.theDataFileForNN_VAR1_HasBeenCreatedEmpty = 'The data file for NN ''%s'' has been created, clean (empty).\n...';
    
    % -----{ nn_loadNN.m }-----    
    msG.warningMissingParameter = '-> WARNING: The parameter ''%s'' es required by this function...\n\n';
    msG.theNNWasNotLoaded = 'The NN was not loaded.\n';
    msG.theNNMustBeFirstInitializedBeforeItCanBeLoaded = 'The NN must first be initialized, before it can be loaded.\n\n';
    msG.loadingNN_MaybeTrainedOrNot = 'Loading NN (it may be have already been trained or not).\n\n';
    msG.errorLoadingNN = 'ERROR loading NN.\n';
    
    % -----{ nn_feedforwardNN.m }-----
    msG.errorOfNNsStructureInFeedforwardFunction = 'Error of NN''s structure in function Feedforward.\n\n';
    
    % -----{ nn_trainNN.m }-----
    msG.trainingNN = 'Training NN...\n';
    msG.errorInFunction_nn_trainNN_NeuronsWithoutBiasLayer = 'ERROR in function ''nn_trainNN'', neurons without Bias layer';
    msG.error_trainIterations_IsNotDefinedOrIsLessThan1 = 'ERROR: trainIterations is not defined or is less than 1...\n';
    msG.Iteration_VAR1_Time_VAR2_Error_VAR3 = '(Iteration: %d, time: %.1f, error: %g)\n';
    msG.saving_Trained_WeightsForTheNN = 'Saving ''trained'' weights for the NN...\n';
    msG.numEpochsTrainedUntilNow_VAR1_NumEpochsJustPlusTrained_VAR2 = '#Epochs trained until now: %d, #Epochs just +trained: %d \n';
    msG.askedForError_VAR1_MeasuredError_VAR2 = 'Asked for error: %f, Measured error: %f \n';
    
    % -----{ nn_loadIOdata.m }-----
    msG.msG.theParameter_VAR1_IsMandatory = 'The argument ''%s'' is mandatory.\n\n';
    msG.theNNMustBeFirstInitializedBeforeIODataIsGenerated = 'The NN must be first initialized before IO data is generated.\n\n';
    msG.loadingTrainingData_Input_OutputPairs = 'Loading training data, input/output pairs.\n';
    msG.errorReadingFile_VAR1_TrainingDataWillBeLoadedInstead = ['ERROR reading file ''%s'',\n', ...
                                                                 '      training data will be loaded instead.\n\n'];
    msG.generatingTrainingData_Input_OutputPairs = 'Generating training data, input/output pairs.\n';
    msG.dataIsExactOrRandom = 'Data is ''Exact'' or ''Random''?: ';
    msG.errorTheNumberOfInputs_OutputsIsNotEqualInTrainingPairs = 'ERROR: The number of inputs/outputs is not equal in training pairs.\n';
    msG.normalizingTrainingData_StandardDeviation = 'Normalizing training data, Standard Deviation.\n';
    msG.normalizingTrainingData_Rank = 'Normalizing training data, Rank.\n';
    
    % -----{ nn_plotXYdata.m }-----
    msG.thePlotIsBeingBuilt_ = 'The plot is being built...\n';
    msG.pressEnterToCloseThePlotWindow = 'Press Enter to close the plot window.\n\n';
    msG.errorPlottingData_Check_plotIOdata_Function = 'ERROR plotting data (check the ''(...)_plotIOdata.m'' function).\n';
    
    returnOK = 1; return
end
