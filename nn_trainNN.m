function [returnOK] = nn_trainNN(trainIterations, trainError, trainEtaGain, trainShowTime)
    % =========== Train the NN =============
    %    function [returnOK] 
    %      = nn_trainNN(trainIterations, trainError, trainEtaGain, trainShowTime)
    %    
    %    Parameters:
    %    - trainIterations: training iterations, Epochs
    %    - trainError: the error looked for, that will stop training
    %    - trainEtaGain: learning gain
    %    - trainShowTime: interval (in secs) to show the training evolution
    %    
    %    Notes:
    %    + nnData y nnIO have to be loaded prior to calling this function,
    %      inside nnData the complete NN structure is received and 
    %      inside nnIO the data to be fed to the NN is received and returned.
    %
    %    + Input inside nnIO.x = , one pair in the input vector, 
    %      with as many elements as input elements (neurons, first layer).
    %    + The output of the NN is returned inside nnIO.y, a pair of the output
    %      vector, with as many elements as neurons has the output layer.
    %    + It is assumed that prior to calling this function:
    %        nnIO.x = nnIO.Input;
    %        nnIO.y = zeros(size(nnIO.Ideal));
    %      ...the structure then works with FIR_FB if needed.
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %    (refer to: LICENSE.txt - GNU GPL license terms and contact info)
    %
    global nnData;
    global nnIO;
    global msG;
   
        a_a = 1000;     % Epochs
        a_b = .001;     % Error that stops the training
        a_c = 0.5;      % Learning gain
        a_d = 1.0;      % trainShowTime (segundos)
    switch nargin       % Complete optional arguments
        case 0
            trainIterations = a_a; trainError = a_b; trainEtaGain = a_c; trainShowTime = a_d;
        case 1
            trainError = a_b; trainEtaGain = a_c;  trainShowTime = a_d;
        case 2
            trainEtaGain = a_c; trainShowTime = a_d;
        case 3
            trainShowTime = a_d;
    end
        
    fprintf(msG.trainingNN);
    
    % BIAS: nnData.Neurons has to have a Bias layer in this function
    if (nnData.Neurons{1}(1,1) ~= 1) 
        fprintf(msG.errorInFunction_nn_trainNN_NeuronsWithoutBiasLayer);
        returnOK = 0; return, end

    % Initialize deltas to zero
    for i = 1:nnData.layersTotal
        nnData.Deltas{i} = zeros(size(nnData.Weights{i}, 1) +1, 1); % +1 row for Bias
    end
    
    % Initialize training error vectors
    if (nnData.Epochs == 0)
        nnData.PredictionError = [];
    end 
    
    % Prepare vectors for Feedforward
    nnIO.x = nnIO.Input;
    nnIO.y = zeros(size(nnIO.Ideal));

    isTime_0 = clock(); 
    isTime_1 = isTime_0;
    
    % It may happen that trainIterations is not defined or is less than 1...
    if (~isscalar(trainIterations) || trainIterations < 1) 
        fprintf('\n');
        fprintf(msG.error_trainIterations_IsNotDefinedOrIsLessThan1);
        returnOK = 1; return, 
    end
    
    for epochIter = 1:trainIterations
        predErr_y = zeros(size(nnIO.y, 2));  % output/iteration errors vector
        predErr_1 = 0;  % A scalar to sum the average of the predErr_y vector
        
        for pair = 1:size(nnIO.x, 1)        % pair points to input/output pairs
            [returnOK] = nn_feedforwardNN(pair);
                if (~returnOK) returnOK = 0; return, end
                if (returnOK==2) continue, end 
                    % There was no an actual Feedforward, nn_feedforwardNN is just loading its FIR input buffer. 
                    % No output results from nn_feedforwardNN to be shown, no training to be done.
                    % The for loop has to be exited with no further processing.
            % the output is coming out in nnIO.y(pair,:) 
        end 
        predErr_y = (1/(2*size(nnIO.Ideal, 1))) * sum((nnIO.Ideal - nnIO.y).^2);
        predErr_1 = (sum(predErr_y)/size(predErr_y,2));

            % Every now and then, let the user know how are things going
            isTime_2 = etime(clock(), isTime_1);
            if (isTime_2 > trainShowTime) % trainShowTime=(s)
                fprintf(msG.Iteration_VAR1_Time_VAR2_Error_VAR3, epochIter, etime(clock(), isTime_0), predErr_1);                
                isTime_1 = clock();
            end    
        
        % Save the prediction errors sequence
        nnData.PredictionError = [nnData.PredictionError; predErr_y];
        % If the ending condition is met, then exit the loop
        if (predErr_1 < trainError) break; end
            
        % Calculate gradients for each training pair
        for pair = 1:size(nnIO.x, 1)        % pair points to input/output pairs
            [returnOK] = nn_feedforwardNN(pair);
                if (~returnOK) returnOK = 0; return, end
                if (returnOK==2) continue, end 
                    % There was no an actual Feedforward, nn_feedforwardNN is just loading its FIR input buffer. 
                    % No output results from nn_feedforwardNN to be shown, no training to be done.
                    % The for loop has to be exited with no further processing.
            % the output is coming out in nnIO.y(pair,:) 
            
            % Calculate gradient backwards up to layer 2 (not for input layer=1)
            for i = nnData.layersTotal:-1:2
                error = zeros(nnData.Structure.layerNeurons(i),1);
                output = error;
                if (i == nnData.layersTotal)
                    error = nnIO.Ideal(pair,:)' - nnIO.y(pair,:)';
                    output = nnIO.y(pair,:)';
                else
                    for j = 1:nnData.Structure.layerNeurons(i)
                        error(j) = nnData.Weights{i+1}(:,j+1)' * nnData.Deltas{i+1}([2:end]); % Weights{i+1}(:,j+1)' without Bias' weight
                    end
                    output = nnData.Neurons{i}([2:end],2);
                end
                switch nnData.Structure.layerActivation{i}
                    case 'logistic'
                        nnData.Deltas{i}([2:end]) = (output .* (ones(size(output)) - output)) .* error;
                    case 'tanh'
                        nnData.Deltas{i}([2:end]) = (ones(size(output)) - (tanh(output)).^2) .* error;
                    case 'linear'
                        nnData.Deltas{i}([2:end]) = (ones(size(output))) .* error;
                end
            end % All gradients are calculated before updating weights
            
            % Update weights, up to layer 2 (not for input layer=1)
            for i = 2:nnData.layersTotal % For neuron layers (their weights)
                for j = 1:(nnData.Structure.layerNeurons(i)) % For neurons in the current layer
                    % Updates weights for the current neuron (j) weighing all upstream inputs {i-1} y and delta for current neuron(i,j+1)
                    nnData.Weights{i}(j,:) = nnData.Weights{i}(j,:) + (trainEtaGain .* nnData.Deltas{i}(j+1) .* nnData.Neurons{i-1}(:,2)'); 
                end % Neurons{i-1}(:,2) += Bias
            end
        end % Iterations inside an epoch; epochs = IO pairs
    end % #Epochs for this training
    
    nnData.Epochs = nnData.Epochs + epochIter;

    % =========== Grabar pesos Entrenados =============
    % NN has just been trained. Save NN's trained data
    % ...besides while creating it, this is the only time 
    %    when nnData.mat is saved
    %
    fprintf('\n');
    fprintf(msG.saving_Trained_WeightsForTheNN);
    fprintf(msG.numEpochsTrainedUntilNow_VAR1_NumEpochsJustPlusTrained_VAR2, nnData.Epochs, epochIter);
    fprintf(msG.askedForError_VAR1_MeasuredError_VAR2, trainError, predErr_1);
    
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
        fprintf(msG.errorWritingFile_VAR1, nnData.Files.nnData); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 0; return
    end

    returnOK = 1; return
end

