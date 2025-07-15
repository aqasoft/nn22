function [returnOK] = nn_localization_es_AR()
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
    % msG.activeLocale = 'English (en-US)';
    msG.activeLocale = 'Spanish (es-AR)';
    
    % -----{ nn22.m }-----
    msG.successLoadingLocalizationData = 'Los datos de localizacion fueron cargados satisfactoriamente.\n';
    msG.pressEnterToContinue = 'Presione Enter para continuar';
    msG.nn22ProgramTitle =          'nn22 Redes Neuronales (framework didactico)\n';
    msG.nn22ProgramTitleUnderline = '===========================================\n\n';
    msG.enterBaseFileNameForNNFiles = 'Ingrese la Base para los archivos de la NN (sin extension): ';
    msG.warningTheFile_VAR1_DoesNotExist = '-> ADVERTENCIA: El archivo ''%s'' no existe...\n';
    msG.theWorkingFolderIs_VAR1 = 'La carpeta de trabajo es: \n-> ''%s''\n\n';
    msG.doYouWantToTryAgain = 'Desea intentar nuevamente? ';
    msG.theConstantsFileDoesNotExist = 'El archivo de constantes no existe.\n';
    msG.itWillBeCreatedFromTemplateAndThenYouMayEditIt = 'Sera creado a partir de una plantilla y luego usted podra editarlo.\n\n';
    msG.nowAnEditorWillOpenTheConstantsFileForNN_VAR1 = 'Ahora se abrira en un editor el archivo de constantes de la red ''%s''...\n';
    msG.whenFinishedEditingAndSavedPressEnterToContinue = 'Cuando haya editado y grabado las constantes, presione Enter para continuar.\n...\n\n';
    msG.constantsFromNN_VAR1_WillBeLoadedIntoWorkspace = 'Las constantes de la red ''%s'' seran cargadas en el workspace.\n\n';
    msG.chooseAnAction = 'Elija una tarea: ';
    msG.loadExistingNN = 'Cargar red existente';
    msG.intializeNN_CreateOrReset_ = 'Inicializar red (crear o reiniciar)';
    msG.load_RegenerateTrainingData_AndEvaluationData_ = 'Cargar/(re)generar datos de entrenamiento (y de evaluacion)';
    msG.trainSetOfEpochs = 'Entrenar un conjunto de epocas';
    msG.feedAn_IOInput_SetThroughFeedforward = 'Alimentar FF con el conjunto IO.Input';
    msG.feedAn_IOInputTest_SetThroughFeedforward = 'Alimentar FF con el conjunto IO.InputTest';
    msG.plotInputVsOutput = 'Graficar Entrada vs Salida (real de la red)';
    msG.plotIdealOrTestOutputVsRealOutput = 'Graficar Salida (archivo ideal o test) vs Salida (real de la red)';
    msG.editConstantsFile = 'Editar archivo de constantes';
    msG.keyboardInterruptToWorkspace = 'Keyboard (interrupcion al workspace)';
    msG.exitProgram = 'Salir';
    msG.fileBaseIs_VAR1 = 'El nombre base de la red es ''%s''...\n\n';
    msG.doYouWantToChangeIt = 'Desea cambiarlo? ';
    msG.chooseLoad_Regenerate = 'Elija Cargar/Regenerar: ';
    msG.loadExistingIOData = 'Cargar datos IO existentes';
    msG.regenerateNewIOData = 'Regenerar datos IO nuevos';
    msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And = 'Advertencia: a) Debe primero cargar o inicializar una red y\n';
    msG.warning_B_LoadOrRegenerateTrainingData =         '             b) cargar o generar datos de entrenamiento.\n';
    msG.backToMainMenuWithoutTraining = 'Se regresa al menu principal sin realizar ningun entrenamiento...\n\n';
    msG.enterNumberOfEpochsToTrain = 'Ingrese el numero de Epocas a entrenar (0=ninguna): ';
    msG.alreadyTrainedEpochs_VAR1_additionalEpochsToTrain_VAR2 = '#Epocas ya entrenadas: %d, #Epocas adicionales a entrenar: %d \n';
    msG.nnHasBeenFedWithIdealData_ = 'Se ha realizado una alimentacion de la red con datos ideales...\n';
    msG.nnHasBeenFedWithTestData_ = 'Se ha realizado una alimentacion de la red con datos de evaluacion...\n';
    msG.a_nowYouMayPlotTheResults = '...ya puede graficar los resultados.\n\n';
    msG.warningYouShouldFeedforwardTheIODataSetBeforePlotting  = 'Advertencia: Debe alimentar Feedforward con datos IO antes de graficar.\n';
    msG.doYouWantToExit = 'Desea salir del programa? ';
    msG.endOfProgram = 'FIN del programa.\n\n';
    
    % -----{ nn_initializeNN.m }-----
    msG.errorEndOfProgram = 'ERROR, fin del programa.\n\n';
    msG.copyrightStatement = 'Copyright (C) 2014 Alejandro Quiroga Alsina';
    msG.localizationCredits = ['Spanish (es-AR) by Alejandro Quiroga Alsina'; ...
                               'English (en-US) by Alejandro Quiroga Alsina'];
    msG.theExistenceOfTheFollowingFilesWillBeVerifiedForTheNN_VAR1 = 'Se verificara la existencia de los siguientes archivos de la NN: ''%s''\n';
    msG.theExistenceOfTheFollowingFiles_Underline =                  '---------------------------------------------------------------- ------\n';
    msG.nnStructure_VAR1 = 'Estructura de la NN: %s\n';
    msG.training_InputTrain_VAR1 = 'Entrenamiento, entrada: %s\n';
    msG.training_InputTest_VAR1 = 'Entrenamiento, entrada Test: %s\n';
    msG.training_OutputTrain_VAR1 = 'Entrenamiento, salida: %s\n';
    msG.training_OutputTest_VAR1 = 'Entrenamiento, salida Test: %s\n';
    msG.nnDataFile_VAR1 = 'Datos (estructura+pesos+etc.) de la NN: %s\n';
    msG.filesVerification =          'Verificacion de archivos:\n';
    msG.filesVerificationUnderline = '-------------------------\n';
    msG.file_VAR1_VerifiedOk = '-> Archivo ''%s'' verificado OK.\n';
    msG.theWorkingFolderIs_VAR1 = 'La carpeta de trabajo es: \n-> ''%s''\n\n';
    msG.aStandardScenarioShouldHaveAllListedFilesAsExisting_ = 'En un escenario normal, todos los archivos listados deben existir\n';
    msG.a_inTheWorkFolder_ = 'en la carpeta de trabajo.\n\n';
    msG.a_note1_TrainingAndTestFiles_HavingTxtExtensionAre_ = 'Nota 1: Los archivos de entrenamiento y prueba (con extension .txt) son\n';
    msG.a_optionalDependingOnWhetherYouWillTrainOrJustTest_ = '  optativos, dependiendo de si solo entrenara o solo probara.\n';
    msG.a_butEitherForTrainingOrTestingTheyMustExist_ = '  Pero ya sean entrenamiento o prueba, deben existir.\n';
    msG.a_ifTheTxtFilesYouNeedDoNotExistYouHaveToCreateThem_ = '  Si los archivos .txt que necesita no existen, debe crearlos usted,\n';
    msG.a_withRealDataOrYouMayUseTheCorrespondingOption_ = '  con datos propios o puede hacerlo utilizando la opcion correspondiente\n';
    msG.a_fromTheMainMenu_inVersionnn22ItIsOption3_ = '  del menu principal (en la version nn22 es la opcion 3 del menu).\n';
    msG.a_writeDownThisPendingTask_TheProgramWillNotMakeItForYou_ = '  Tome nota de este pendiente, el programa no lo hará por usted :)\n\n';
    msG.a_note2_theNNDataFile_with_matExtension_MustExist_ = 'Nota 2: El archivo de datos de la red (con extension .mat) debe existir.\n';
    msG.a_ifThe_matFileDoesNotExistANewOneWillBeCreatedNowCleanEmpty = '  Si el archivo .mat no existe, se creara uno nuevo ahora, limpio (vacio).\n\n';
    msG.doYouWantToInterruptExecutionAndVerifyYourWorkingFolder = 'Desea interrumpir y verificar su carpeta de trabajo? ';
    msG.errorReadingFile_VAR1 = 'ERROR al leer el archivo ''%s''.\n';
    msG.errorWritingFile_VAR1 = 'ERROR al grabar el archivo ''%s''.\n';
    msG.error_VAR1 = 'ERROR: %s.\n\n';
    msG.generatingNeurons_FromScratch_ForTheNN = 'Generando neuronas ''de cero'' para la NN.\n';
    msG.generatingWeights_FromScratch_ForTheNN = 'Generando pesos ''de cero'' para la NN.\n';
    msG.loadingNNStructureDefinition =          'Cargando definicion de estructura de NN.\n';
    msG.loadingNNStructureDefinitionUnderline = '----------------------------------------\n\n';
    msG.theDataFileForNN_VAR1_HasBeenCreatedEmpty = 'El archivo de datos de la red ''%s'' ha sido creado, vacio.\n...';
    
    % -----{ nn_loadNN.m }-----    
    msG.warningMissingParameter = '-> ADVERTENCIA: El parametro ''%s'' es requerido por la funcion...\n\n';
    msG.theNNWasNotLoaded = 'La red no fue cargada.\n';
    msG.theNNMustBeFirstInitializedBeforeItCanBeLoaded = 'Debe primero inicializar la red, antes de cargarla.\n\n';
    msG.loadingNN_MaybeTrainedOrNot = 'Cargando red (puede estar entrenada o no).\n\n';
    msG.errorLoadingNN = 'ERROR cargando la red NN.\n';
    
    % -----{ nn_feedforwardNN.m }-----
    msG.errorOfNNsStructureInFeedforwardFunction = 'Error de estructura NN en funcion Feedforward.\n\n';
    
    % -----{ nn_trainNN.m }-----
    msG.trainingNN = 'Entrenando la NN...\n';
    msG.errorInFunction_nn_trainNN_NeuronsWithoutBiasLayer = 'ERROR en la funcion ''nn_trainNN'', neuronas sin capa de Bias';
    msG.error_trainIterations_IsNotDefinedOrIsLessThan1 = 'ERROR: trainIterations no esta definida o su valor es menor que 1...\n';
    msG.Iteration_VAR1_Time_VAR2_Error_VAR3 = '(Iteracion: %d, tiempo: %.1f, error: %g)\n';
    msG.saving_Trained_WeightsForTheNN = 'Grabando pesos ''entrenados'' para la NN...\n';
    msG.numEpochsTrainedUntilNow_VAR1_NumEpochsJustPlusTrained_VAR2 = '#Epocas entrenadas ahora: %d, #Epocas que se acaban de +entrenar: %d \n';
    msG.askedForError_VAR1_MeasuredError_VAR2 = 'Error solicitado: %f, Error medido: %f \n';
    
    % -----{ nn_loadIOdata.m }-----
    msG.msG.theParameter_VAR1_IsMandatory = 'El argumento ''%s'' es obligatorio.\n\n';
    msG.theNNMustBeFirstInitializedBeforeIODataIsGenerated = 'Debe primero cargar o inicializar una red antes de generar los datos IO.\n\n';
    msG.loadingTrainingData_Input_OutputPairs = 'Cargando datos de entrenamiento, pares entrada/salida.\n';
    msG.errorReadingFile_VAR1_TrainingDataWillBeLoadedInstead = ['ERROR leyendo el archivo ''%s'',\n', ... 
                                                                 '      los datos de entrenamiento seran cargados en su lugar.\n\n'];
    msG.generatingTrainingData_Input_OutputPairs = 'Generando datos de entrenamiento, pares entrada/salida.\n';
    msG.dataIsExactOrRandom = 'Los datos son ''Exact'' o ''Random''?: ';
    msG.errorTheNumberOfInputs_OutputsIsNotEqualInTrainingPairs = 'ERROR: El numero de entradas/salidas nos es igual en los pares de entrenamiento.\n';
    msG.normalizingTrainingData_StandardDeviation = 'Normalizando los datos de entrenamiento, Desviacion Estandar.\n';
    msG.normalizingTrainingData_Rank = 'Normalizando los datos de entrenamiento, Rango.\n';
    
    % -----{ nn_plotXYdata.m }-----
    msG.thePlotIsBeingBuilt_ = 'El grafico se esta generando...\n';
    msG.pressEnterToCloseThePlotWindow = 'Presione Enter para cerrar la ventana del grafico.\n\n';
    msG.errorPlottingData_Check_plotIOdata_Function = 'ERROR graficando datos (verifique la funcion ''(...)_plotIOdata.m'').\n';
    
    returnOK = 1; return
end
