% ----- nn22 Basic Neural Networks Framework for Octave (or Matlab) -----
% ----- (version 2015.04.18) -----
%    
%   
%   About nn22 Basic Neural Networks (NN) framework for Octave (or Matlab)
%   ----------------------------------------------------------------------
%   nn22 is a small and basic NN framework that was built having the
%   following criteria in mind.
%   1. Function as a close-to all purpose NN framework allowing to
%      define a NN with:
%      a. as many layers as you want,
%      b. as many neurons per layer as you want,
%      c. the activation function per layer that you want,
%      d. the ability to feed back as many delayed outputs as you want,
%      e. the ability to delay the input vector as many times...
%      f. ...and other stuff, and do so in an easy way.
%   2. To have its main functions logically separated and uncluttered
%      so that the may be modified at will and easily understood.
%   3. To have all source code available at plain sight, nothing hidden
%      inside an obscure library.
%   4. The possibility to insert 'keyboard;' breaks at any point of the
%      code so that all variables and functions behavior can be
%      evaluated through 'who' and commands alike.
%   5. To be able to run in both Octave and Matlab.
%   6. To serve a didactic purpose.
%   
%   
%   What nn22 is not:
%   -----------------
%   1. It is not a full featured NN framework.
%   2. It is not fast.
%   3. It is not intended to work as a commercial product does.
%   4. It is not even intended to pair other open source frameworks 
%      available that are indeed fast and provide good results.
%   5. ...and this renders the previous stated objective: 
%      it has a didactic purpose. And just that :)
%   
%   
%   How nn22 came to see the light?
%   -------------------------------
%   1. There is a specialization course taught by Dr. Eng. Daniel Patino at
%      the INAUT institute, Universidad Nacional de San Juan, Argentina,
%      called "Neural Networks Applied to System's Identification and 
%      Control" ("Redes Neuronales Aplicadas a la Identificacion y Control
%      de Sistemas") and belongs to INAUT's MSc and PhD programs.
%   2. The author of this code (that would be me, Alejandro) attended 
%      professor Patino's classes.
%   3. One of the course's assignments was to build simple NN solutions
%      for the AND, XOR, SINE, FIR and other problems, including a 
%      multi-input multi-output non-linear dynamic system's identification, 
%      ...yes, true, that one is not that simple.
%   4. The author of the code got engaged and did an extra mile,
%      for the sake of machine learning coding joyfulness, sort of ;)
%   
%   
%   Expected future for nn22:
%   -------------------------
%   1. To serve as a didactic means of learning the insights of NN.
%   2. Perhaps, to have some other back-propagation or function added.
%   
%   
%   OK now...
%   
%   How to use:
%   -----------
%   1. From Octave's command line load nn22.m (you may use Matlab).
%   2. Follow the menu indications, by either loading or creating a
%      new Neural Network.
%   3. Data for training and testing is included in .txt files. Or you may
%      create new data.
%   4. Adjust constants for training.
%   5. Train, feed the NN and plot results.
%   6. Spare some time understanding the code, should be 
%      pretty straight forward.
%   7. The neural network structure is:
%      a) easily modified by its .ini file.
%      b) visible in the neurons data structure included in each .mat file.
%   8. This very simple framework is meant to provide a means to play and
%      understand neural networks basics. Nothing more than that.
%   9. Profound knowledge of Trial and Error is a must.
%      (versions history at the end of this .m script)
%   
%   
%   Some 'advanced' how to use:
%   ---------------------------
%   1. Files particular to each NN solution are included as examples and
%      as templates to be modified to suit your own NN solution.
%       a) and_Structure.ini
%       b) and_Constantes.m
%       c) and_nnData.mat
%       d) and_createIOdata.m
%       e) and_plotIOdata.m
%       f) and_ioIdealTest.txt
%       g) and_ioIdealTrain.txt
%       h) and_ioInputTest.txt
%       i) and_ioInputTrain.txt
%       ...where 'and' should be replaced by your NN's Base Name,
%       e.g.: xor, sine, fir, etc. (etc. meaning your own base name ;) 
%   2. File a) is the .ini NN structure definition. Edit it.
%   3. Files b) and c) may be omitted, but if they exist, you should respect
%      their existence. They may contain useful information regarding the NN :)
%      If they do not exist, they will be created by the program.
%   4. Files d) and e) are templates and *have to* be adapted to your solution.
%   5. Files f) to i) are the .txt data files. If they do not exist, 
%      the program can create them. There is a menu option for that task...
%      and it calls the function listed as file d) _createIOdata.m
%      It should be easy to build your own data set for a particular solution.
%   
%   
%   
%   Copyright statement:
%   ------------------------------------------------------------------
%   nn22 - Basic Didactic Neural Networks for Octave (or Maltlab) 
%   Contains GNU Octave (or Matlab) scripts & functions built by
%   Alejandro Quiroga Alsina for Dr. Eng. Daniel Patino's  MSc and PhD
%   courses at INAUT, Universidad Nacional de San Juan, Argentina.
%   ------------------------------------------------------------------
%   
%   Copyright (C) 2014 Alejandro Quiroga Alsina
%   
%   The copyright is made under GNU General Public License.
%   README.txt, COPYING.txt and LICENSE.txt files add info on this regard.
%   
%   Contact info:
%   -------------
%   Alejandro Quiroga Alsina
%   - aqasoft-nn22@yahoo.com.ar (regarding this project specifically)
%   - ar.linkedin.com/in/alejandroquirogaalsina
%   - twitter.com/sanjuanino 
%   
% -------------------------------------------------------------------




% =========== Workspace cleaning =============
%
    clc; clear all; close all; fclose('all');


% =========== Begin =============
%

    % Variables declaration, Global
    %
    global nnData;   % Neural Network Data
    global nnIO;     % Input and Training Data
    global msG;      % Localized Messages (loaded once first run)
    % Both nnData and nnIO are declared global in order to speed up
    %   the execution of Training and Feedforward functions.
    %   Using this approach lets the framework use a single copy
    %   of the NN in memory and modify its value directly.
    % Two reasons for this approach:
    %  -Neither Octave nor Matlab allow modifying the actual value
    %   of a variable through the use of pointers.
    %  -Having these variables Globally available allows to check
    %   their values from any 'keyboard;' break, and thus learning
    %   about the internals of the main functions of nn22. 
    %   This approach points to the didactic objective of the project.
    %   

    % Variables declaration, Local
    %
    aux_inputFedWas_1train_2test = 0;
    
    
    % Load global variable msG with localized messages
    %
    whileTrue = 1;
    while (whileTrue)
        fileMessages = sprintf('%s', 'nn_localization');
        if (exist(fileMessages, 'file'))
            aux_fileMessages = str2func(fileMessages);
            [returnOK] = aux_fileMessages();
            if (~returnOK) 
                fprintf('ERROR loading localization messages: ''%s''\n\n', fileMessages);
                returnOK = 0; return, end
            whileTrue = 0; continue; 
        else
            fprintf('\n\n');
            fprintf('The localization file ''%s'' does not exist...\n', fileMessages)
            fprintf('The working folder is: \n-> ''%s''\n\n', pwd)
            if (~yes_no('Want to try again? ')) 
                returnOK = 0; return, end
        end
    end

    % Program title to the screen
    %
    fprintf('\n');
    fprintf(msG.nn22ProgramTitle);
    fprintf(msG.nn22ProgramTitleUnderline);    

    % Choose the name nnFilesBase, which is the base name for all specific
    % NN's data files and functions.
    % From here on, all work will be done with the nnFilesBase NN.
    % In order to work with another NN, the program needs to be restarted,
    % and the way to do so is choose the option "Exit Program" and then 
    % type again nn22 into Octave's (or Matlab) command line.
    %
    whileTrue = 1;
    while (whileTrue)
        nnFilesBase = input(msG.enterBaseFileNameForNNFiles, 's');
        nnFilesStructIni = sprintf('%s%s', nnFilesBase, '_Structure.ini');
        if (exist(nnFilesStructIni, 'file')) break; end
        fprintf('\n\n');
        fprintf(msG.warningTheFile_VAR1_DoesNotExist, nnFilesStructIni);
        fprintf(msG.theWorkingFolderIs_VAR1, pwd);
        if (~yes_no(msG.doYouWantToTryAgain)) 
            returnOK = 0; return, end
    end

    % Load Constants file for the nnFilesBase NN.
    % If the file does not exist a standard one is created from a template.
    %
    nnFilesConstants = sprintf('%s%s', nnFilesBase, '_Constants.m');
    if (~exist(nnFilesConstants, 'file')) 
        fprintf(msG.theConstantsFileDoesNotExist);        
        fprintf(msG.itWillBeCreatedFromTemplateAndThenYouMayEditIt);
        [returnOK] = nn_createFileConstants(nnFilesConstants);
            if (~returnOK) returnOK = 0; return, end
        fprintf(msG.nowAnEditorWillOpenTheConstantsFileForNN_VAR1, nnFilesBase);
        fprintf(msG.whenFinishedEditingAndSavedPressEnterToContinue);
        edit(nnFilesConstants);
        pause;
    end
    fprintf(msG.constantsFromNN_VAR1_WillBeLoadedIntoWorkspace, nnFilesBase);
    run(fullfile(cd, nnFilesConstants));
    
    
% =========== Main menu =============
%
    whileTrue = 1;
    while (whileTrue)
        
        fprintf('\n\n');
        choice = menu(msG.chooseAnAction, ... 
            msG.loadExistingNN, ...  %1
            msG.intializeNN_CreateOrReset_, ...  %2
            msG.load_RegenerateTrainingData_AndEvaluationData_, ...  %3
            msG.trainSetOfEpochs, ...  %4
            msG.feedAn_IOInput_SetThroughFeedforward, ...  %5
            msG.feedAn_IOInputTest_SetThroughFeedforward, ...  %6
            msG.plotInputVsOutput, ...  %7
            msG.plotIdealOrTestOutputVsRealOutput, ...  %8
            msG.editConstantsFile, ...  %9
            msG.keyboardInterruptToWorkspace, ...  %10
            msG.exitProgram);  %11
        fprintf('\n\n');
            switch choice
            case 1
                if (~isempty(nnData))
                    % Allow to change the NN to be run without exiting the program.
                    fprintf(msG.fileBaseIs_VAR1, nnFilesBase);
                    if (yes_no(msG.doYouWantToChangeIt)) 
                        % Loading a new NN forces to load new IO data,
                        %   and reset all persistent values in nn_feedforwardNN()
                        clear global nnIO; global nnIO; 
                        [returnOK] = nn_feedforwardNN(-1);
                            if (~returnOK) returnOK = 0; return, end
                        % Now ask for the 'nnFilesBase' name for the new NN
                        fprintf('\n');
                        nnFilesBase = input(msG.enterBaseFileNameForNNFiles, 's');
                        nnFilesStructIni = sprintf('%s%s', nnFilesBase, '_Structure.ini');
                        if (~exist(nnFilesStructIni, 'file'))
                            fprintf('\n\n');
                            fprintf(msG.warningTheFile_VAR1_DoesNotExist, nnFilesStructIni);
                            fprintf(msG.theWorkingFolderIs_VAR1, pwd);
                            continue;
                        end
                    end
                end
                
                [returnOK] = nn_initializeNN(nnFilesBase, rndWeightsDistribution, rndWeightsMean, rndWeigthsDev);
                    if (~returnOK) returnOK = 0; return, end
                [returnOK] = nn_loadNN(nnFilesBase);
                    if (~returnOK) returnOK = 0; return, end
                    
            case 2
                if (~isempty(nnData))
                    % Allow to change the NN to be run without exiting the program.
                    fprintf(msG.fileBaseIs_VAR1, nnFilesBase);
                    if (yes_no(msG.doYouWantToChangeIt)) 
                        % Loading a new NN forces to load new IO data,
                        %   and reset all persistent values in nn_feedforwardNN()
                        clear global nnIO; global nnIO; 
                        [returnOK] = nn_feedforwardNN(-1);
                            if (~returnOK) returnOK = 0; return, end
                        % Now ask for the 'nnFilesBase' name for the new NN
                        fprintf('\n');
                        nnFilesBase = input(msG.enterBaseFileNameForNNFiles, 's');
                        nnFilesStructIni = sprintf('%s%s', nnFilesBase, '_Structure.ini');
                        if (~exist(nnFilesStructIni, 'file'))
                            fprintf('\n\n');
                            fprintf(msG.warningTheFile_VAR1_DoesNotExist, nnFilesStructIni);
                            fprintf(msG.theWorkingFolderIs_VAR1, pwd);
                            continue;
                        end
                    end
                end
                
                [returnOK] = nn_initializeNN(nnFilesBase, rndWeightsDistribution, rndWeightsMean, rndWeigthsDev);
                    if (~returnOK) returnOK = 0; return, end
                    
            case 3
                choice = menu(msG.chooseLoad_Regenerate, ... 
                    msG.loadExistingIOData, ...     %1
                    msG.regenerateNewIOData);       %2
                fprintf('\n');
                switch choice
                    case 1
                        ioLoadGenerate = 1;  % Load(1), Generate(0)
                    case 2
                        ioLoadGenerate = 0;  % Load(1), Generate(0)
                end                
                [returnOK] = nn_loadIOdata(ioLoadGenerate, ioNormalizeData, ioMaxMinVsMeanDev, genNumPairs); 
                        if (~returnOK) returnOK = 0; return, end
                        
            case 4
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                trainIterations = input(msG.enterNumberOfEpochsToTrain);
                if (trainIterations==0)
                    fprintf(msG.backToMainMenuWithoutTraining); continue, end
                fprintf(msG.alreadyTrainedEpochs_VAR1_additionalEpochsToTrain_VAR2, nnData.Epochs, trainIterations);
                [returnOK] = nn_trainNN(trainIterations, trainError, trainEtaGain, trainShowTime); 
                    if (~returnOK) returnOK = 0; return, end
                    
            case 5
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                nnIO.x = nnIO.Input; aux_inputFedWas_1train_2test = 1;
                nnIO.y = zeros(size(nnIO.Ideal));
                for pair = 1:size(nnIO.x, 1)        % pair behaves as pointer to each input/output pair
                    % send one IO training pair to Feedforward
                    [returnOK] = nn_feedforwardNN(pair);
                        if (~returnOK) returnOK = 0; return, end
                        if (returnOK==2) continue, end      
                            % There was no an actual Feedforward, nn_feedforwardNN is just loading its FIR input buffer. 
                            % No output results from nn_feedforwardNN to be shown, no training to be done.
                            % The for loop has to be exited with no further processing.
                    % the output is coming out in nnIO.y(pair,:) 
                    %fprintf('Pair: %i, Ideal: %g, Real: %g \n', pair, nnIO.Ideal(pair,:), nnIO.y(pair,:));
                end
                fprintf(msG.nnHasBeenFedWithIdealData_); 
                fprintf(msG.a_nowYouMayPlotTheResults); 
                
            case 6    
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                nnIO.x = nnIO.InputTest; aux_inputFedWas_1train_2test = 2;
                nnIO.y = zeros(size(nnIO.IdealTest));
                for pair = 1:size(nnIO.x, 1)
                    % send one IO test pair to Feedforward
                    [returnOK] = nn_feedforwardNN(pair);
                        if (~returnOK) returnOK = 0; return, end
                        if (returnOK==2) continue, end 
                            % There was no an actual Feedforward, nn_feedforwardNN is just loading its FIR input buffer. 
                            % No output results from nn_feedforwardNN to be shown, no training to be done.
                            % The for loop has to be exited with no further processing.
                    % the output is coming out in nnIO.y(pair,:) 
                    %fprintf('Pair: %i, IdealTest: %g, Real: %g \n', pair, nnIO.IdealTest(pair,:), nnIO.y(pair,:));
                end
                fprintf(msG.nnHasBeenFedWithTestData_); 
                fprintf(msG.a_nowYouMayPlotTheResults); 
                
            case 7    
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                xX = nnIO.x; yY = nnIO.y;
                if (ioNormalizeData)
                    if (~ioMaxMinVsMeanDev)
                        xX = bsxfun(@times, xX, nnIO.Normalize.sigmaInput);
                        xX = bsxfun(@plus, xX, nnIO.Normalize.muInput);
                        yY = bsxfun(@times, yY, nnIO.Normalize.sigmaOutput);     
                        yY = bsxfun(@plus, yY, nnIO.Normalize.muOutput);
                    else
                        xX = bsxfun(@times, xX, nnIO.Normalize.rangeInput);
                        xX = bsxfun(@plus, xX, nnIO.Normalize.muInput);
                        yY = bsxfun(@times, yY, nnIO.Normalize.rangeOutput);     
                        yY = bsxfun(@plus, yY, nnIO.Normalize.muOutput);
                    end
                end
                aux_plotIOdata = str2func([nnData.FilesBase, '_plotIOdata']);
                [returnOK] = aux_plotIOdata(nnData.FilesBase, xX, yY);
                    if (~returnOK) returnOK = 0; return, end
                [returnOK] = nn_plotXYdata(nnData.FilesBase, nnData.PredictionError);
                    if (~returnOK) returnOK = 0; return, end
                    
            case 8
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                if (aux_inputFedWas_1train_2test==0)
                    fprintf(msG.warningYouShouldFeedforwardTheIODataSetBeforePlotting); continue, end
                switch aux_inputFedWas_1train_2test
                    case 1
                        xX = nnIO.Ideal; yY = nnIO.y;
                    case 2
                        xX = nnIO.IdealTest; yY = nnIO.y;
                end
                if (ioNormalizeData)
                    if (~ioMaxMinVsMeanDev)
                        xX = bsxfun(@times, xX, nnIO.Normalize.sigmaOutput);
                        xX = bsxfun(@plus, xX, nnIO.Normalize.muOutput);
                        yY = bsxfun(@times, yY, nnIO.Normalize.sigmaOutput);     
                        yY = bsxfun(@plus, yY, nnIO.Normalize.muOutput);
                    else
                        xX = bsxfun(@times, xX, nnIO.Normalize.rangeOutput);
                        xX = bsxfun(@plus, xX, nnIO.Normalize.muOutput);
                        yY = bsxfun(@times, yY, nnIO.Normalize.rangeOutput);     
                        yY = bsxfun(@plus, yY, nnIO.Normalize.muOutput);
                    end
                end
                aux_plotIOdata = str2func([nnData.FilesBase, '_plotIOdata']);
                [returnOK] = aux_plotIOdata(nnData.FilesBase, xX, yY);
                    if (~returnOK) returnOK = 0; return, end
                [returnOK] = nn_plotXYdata(nnData.FilesBase, nnData.PredictionError);
                    if (~returnOK) returnOK = 0; return, end
                    
            case 9    
                if (isempty(nnData) || isempty(nnIO))
                    fprintf(msG.warning_A_YouMustFirstLoadOrInitializeA_NN_And); 
                    fprintf(msG.warning_B_LoadOrRegenerateTrainingData); continue, end
                    
                fprintf(msG.nowAnEditorWillOpenTheConstantsFileForNN_VAR1, nnFilesBase);
                edit(nnFilesConstants);
                fprintf(msG.whenFinishedEditingAndSavedPressEnterToContinue);
                pause;
                fprintf(msG.constantsFromNN_VAR1_WillBeLoadedIntoWorkspace, nnFilesBase);
                run(fullfile(cd, nnFilesConstants));
                
            case 10    
                keyboard;
                
            case 11    
                if (yes_no(msG.doYouWantToExit)) 
                    whileTrue = 0; continue, end
        end
    end
    
    
    % ----------{ End of script nn22 }----------
    fprintf('\n');
    fprintf(msG.endOfProgram);
    close all; fclose all;
    

% ===================================================================
% ----- Version history -----
% ----- Historial de versiones -----
%   
%  2014-07-06  v01    Inicio de traspaso de C# a Octave.
%                     Ya funciona en C# hasta XOR y red dinámica.
%  2014-07-07  v02    Lectura de archivos de formato de red:
%                     a) Encabezado variable.
%                     b) Paso de datos a estructura.
%  2014-07-08  v03    Darse cuenta de que lo hecho en C# no sirve acá.
%                     Superarlo.
%                     Normalización de entrada y salida.
%  2014-07-08  v04    Creación del nombre base.
%                     Corrección de todos los nombres de datos.
%                     Chequeo de errores de acceso a datos.
%  2014-07-08  v05    Separación en bloques de funciones.
%                     Duda sobre armar varios .m y un script.
%  2014-07-09  v06    Generación de pesos. 
%                     Rutina de Aleatorios.
%                     Almacenamiento de datos de red, estructura+pesos.
%                     Carga de datos existentes.
%  2014-07-09  v07    Feedforward. 
%  2014-07-09  v08    Feedforward queda solito, Neuronas a nnData.
%  2014-07-09  v09    Depuración de Feedforward
%                     Mejora en definición de neuronas
%  2014-07-10  v10    Ahora sí... un cacho de entrenamiento.
%                     Afuera el Bias opcional en Neuronas.
%                     Limpieza de código, velocidad.
%                     Prueba de Backpropagation exitosa.
%                     Limpieza de nombres de funciones.
%  2014-07-11  v11    Armar el programa para acceso desde afuera.
%                     Completar argumentos opcionales, eliminar redundantes.
%  2014-07-12  v12    Reagrupar funciones.
%                     Esta versión quedó no operativa.
%  2014-07-13  v13    Hacer que funcione nuevamente. :-/
%                     Seguir reagrupando funciones.
%                     Redefinir el cálculo del error de entrenamiento.
%  2014-07-16  v14    Sacar las funciones FF y BP afuera.
%                     Modo 'verbose' en Funciones que salen.
%                     El modo 'verbose' se quitó sólo de FF.
%  2014-07-21  v15    En v14 se quiso sacar las funciones FF y BP afuera...
%                     Ahora, se van todas afuera... :)
%                     ...vuelan todos los comentarios sobrantes.
%                     ...ahora v15 se transforma en script nuevamente.
%  2014-07-21  v16    Resultó ser en v16.
%  2014-07-24  v17    Cambio en toda la generación de datos de entrenamiento.
%  2014-07-28  v18    Edición en línea de constantes del sistema.
%  2014-08-09  v19    Corrección de normalización en salidas.
%                     Ajuste de parametros en llamadas a funciones.
%  2014-08-11  v20    Gráficas de progresión de error.
%                     Nuevas estructuras de red, con FIR y FB. FB no aún.
%  2014-08-11  v21    Gráficas de entrada/salida, salida/salida.
%                     Corrección de errores de llamados a funciones.
%                     Matriz de error de predicción.
%  2014-08-16  v22    Rutina FB, realimentación de salida.
%                     Autoajuste de Eta de aprendizaje +/-.
%                     Quedó pendiente el autoajuste...
%  2015-03-25  v2014-08-16  Version numbers are now based on to the  
%                           publishing date, and nn22 is kept as the 
%                           project name.
%  2015-03-26  v2015-03-26  All variables and functions have English names.
%                           All comments are in English.
%                           Wide scope debugging!
%                           Try-Catch structures included in most functions.
%                           Localization has been added for two languages:
%                           English (US style), Spanish (Latam style).
%                           It is easy to add another language.
%  2015-03-26  v2015-03-30  Several fixes to ensure Matlab compatibility, which
%                           unfortunately extends the # of code lines... o_O
%                           + A custom yes_no() function added to replace 
%                           Octave's stock function yes_or_no().
%  2015-03-26  v2015-03-31  Decided to include both Octave's and Matlab's
%                           default .mat formats, the former with a '.mat.txt'
%                           extension added. A conversion function is included. 
%  2015-03-26  v2015-04-18  One ticket solved.
%                           First incompatibility with Matlab R2009 found 
%                           and solved. Forum post about that, on the same day.
%
% -------------------------------------------------------------------
