function [returnOK] = nn_feedforwardNN(pair)
    % =========== Feedforward =============
    %    function [returnOK] = nn_feedforwardNN(pair)
    %    
    %    Parameters:
    %    - pair: is the pointer to the vectors nnIO.x / nnIO.y
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

    % Define Input sizes, simplify names and reading of the function code.
    persistent ffFirstRun;
    persistent n_FIR; persistent n_FB;
    persistent n_in; persistent n_out;
    persistent n_inFIR; persistent n_outFB;
    
    % Force to reset all persistent values
    if (pair == -1) 
        ffFirstRun = -1;
        returnOK = 1; return, 
    end

    if (isempty(ffFirstRun) || (ffFirstRun == -1)) % Speed up the execution of FF
        ffFirstRun = 1;
        n_FIR = nnData.Structure.FIR_FB(1);
        n_FB = nnData.Structure.FIR_FB(nnData.layersTotal);
        n_in = size(nnIO.x,2);
        n_out = size(nnIO.y,2);
        n_inFIR = n_in * n_FIR; % inputs window FIR
        n_outFB = n_out * n_FB; % outputs window FB (they are also fir...)
    end


    % FIR_FB Working Example
    %  Supposing 15 neurons for the input layer
    %  having two elements per input pair and three elements at the output
    %  (meaning n_in=2 and n_out=3) with n_FIR=3 and n_FB=2; B=Bias:
    %   _  ____   ____  ____  ____   ________  ________
    %   1  2__3   4__5  6__7  8__9   10_11_12  13_14_15
    %  |-|------|------------------|--------------------|
    %   B \n_in/ \n_inFIR ________/ \n_outFB __________/
    %
    % -Rotations are between neurons 4 and 9 p/n_inFIR, 10 and 15 p/n_OutFB
    %  neurons 4 and 5 are loaded by 2 and 3, and thus the input rotation
    %  is done completely from 2 to 9.
    % -At the output, after rotating 10 to 15 a new output vector (pair) 
    %  is applied to 10_11_12.
    %
    
    % Is the input layer correctly sized?
    % nnData.Structure.layerNeurons(1)==(size(nnData.Neurons{1},1) - 1) (Bias) 
    if (nnData.Structure.layerNeurons(1) ~= (n_in + n_inFIR + n_outFB) ) 
        fprintf(msG.errorOfNNsStructureInFeedforwardFunction);
        returnOK = 0; 
        return
    end

    % Now, let's see how the carousel is fed:
    % There are two rotations, they go at different speeds if
    % size(pair_in)~=size(pair_out)
    % (Do not forget to count neuron 1 as BIAS)
    if (n_FIR)
        % Rotate i = INPUT size(pair_in) times
        for i = 1:n_in
            for j = ((1)+ n_in + n_inFIR):-1:((1)+ 1) % ((1)+ = Bias) will be overwritten
                nnData.Neurons{1}(j,2) = nnData.Neurons{1}(j-1,2);
            end
        end
    end
    %
    % Load an Input pair
    % nnData.Neurons{1}([2:1+size(nnIO.x(pair,:),2)],2) = nnIO.x(pair,:)';
    % layer{1} 2nd_Neuron|  \(1)+sizeInput           \layer{1}_output
    %      watch... here |   \ here          and here \
    nnData.Neurons{1}([((1)+ 1):((1)+ n_in)],2) = nnIO.x(pair,:)';    
    
    if (n_FB && pair > 1)
        % Rotate k = Output size(pair_out) times
        for k = 1:n_out
            for l = ((1)+ n_in + n_inFIR + n_outFB):-1:((1)+ n_in + n_inFIR + 1) 
                nnData.Neurons{1}(l,2) = nnData.Neurons{1}(l-1,2);
            end
        end
        % Load an Output pair deelaayeed oonee tiimee
        nnData.Neurons{1}([((1)+ n_in + n_inFIR + 1):((1)+ n_in + n_inFIR + n_out)],2) = nnIO.y(pair-1,:)';
    end

    % Return early if it corresponds (we are just loading FIR)
    if (pair < (n_in/n_in + n_FIR + n_FB))
        returnOK = 2; 
        return
    end 

    % Load neurons, first column with Sum, second with Activation function
    for i = 2:nnData.layersTotal                            %1=input_layer
        for j = 2:(nnData.Structure.layerNeurons(i) + 1)    %1=bias
            % Sum
            nnData.Neurons{i}(j,1) = nnData.Neurons{i-1}(:,2)' * nnData.Weights{i}(j-1,:)';
            % Activation
            switch nnData.Structure.layerActivation{i}
                case 'logistic'
                    nnData.Neurons{i}(j,2) = 1.0/(1.0 + exp(-nnData.Neurons{i}(j,1)));
                case 'tanh'
                    nnData.Neurons{i}(j,2) = tanh(nnData.Neurons{i}(j,1));
                case 'linear'
                    nnData.Neurons{i}(j,2) = nnData.Neurons{i}(j,1);
            end
        end
    end

    % Return the final result, the Output layer
    nnIO.y(pair,:) = nnData.Neurons{nnData.layersTotal}([2:end],2)';
    
    returnOK = 1; return
end
