function [returnOK, X, Y] = sine_createIOdata(nnFilesBase, genExactOrRandom, genNumPairs)
    % =========== Create IO data =============
    %    function [returnOK, X, Y] = 
    %       (...)_createIOdata(nnFilesBase, genExactOrRandom, genNumPairs)
    %
    %    Parameters:
    %    ~~~~~~~~~~~
    %    - nnFilesBase (xor, sine, etc.)
    %    - genExactOrRandom (0:y=f(x)exact, 1:random around de y=f(x))
    %    - genNumPairs (number of IO pairs per Epoch)
    %   
    %   Notes:
    %    + Generates IO data.
    %    + This function belongs to each NN solution (xor, sine, etc.),
    %      since data is different, its generation algorithm is also unique.
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
        a_a = '';    % nnFilesBase, cannot be empty
        a_b = 0;     % genExactOrRandom (0=no=random, 1=yes=exact) 
        a_c = 20;    % genNumPairs 
    switch nargin    % Complete optional arguments
        case 0
            fprintf('The parameter ''nnFilesBase'' is mandatory.\n\n');
            returnOK = 0; return
            % nnFilesBase = a_a; genExactOrRandom = a_b; genNumPairs = a_c; 
        case 1
            genExactOrRandom = a_b; genNumPairs = a_c; 
        case 2
            genNumPairs = a_c; 
    end
    
    rMin = 0;
    rMax = 2*pi;
    
    if (genExactOrRandom)
        X = [rMin:(rMax/(genNumPairs-1)):rMax]';
        Y = sin(X);
    else
        X = [rMin:(rMax/((genNumPairs/2)-1))*(1+randn):rMax]';
        Y= sin(X);
    end

    aux_plotIOdata = str2func([nnFilesBase, '_plotIOdata']);
    [returnOK] = aux_plotIOdata(nnFilesBase, X, Y);
        if (~returnOK) returnOK = 0; return, end
        
    returnOK = 1; return
end