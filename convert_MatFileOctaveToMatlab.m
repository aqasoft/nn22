function [returnOK] = convert_MatFileOctaveToMatlab(fileName)
    % =========== Convert Octave .mat file to Matlab binary format =============
    %    function [returnOK] 
    %      = convert_MatFileOctaveToMatlab(fileName)
    %    
    %    Parameters:
    %    - fileName: the .mat data file to be converted
    %    
    %    Notes:
    %    + Matlab cannot read Octave's default text data file format.
    %      Octave's default format is human readable, and thus it is 
    %      useful to keep it, for didactic reasons.
    %    + The '-text' option while saving Octave's format is the default,
    %      and may be omitted; it is included just for code readability.
    %
    
    try
        clear nnData;
            fprintf('\n\n');
            fprintf('File ''%s'' is being converted.\n', fileName); 
            fprintf('-----------------------------------------\n');
        load(fileName, 'nnData');
            fprintf('File ''%s'' has been loaded...\n', fileName); 
        save(fileName, 'nnData', '-v7');                % Matlab v7 format
            fprintf('File ''%s'' has been saved with Matlab .mat v7 format...\n', fileName); 
        if (exist('OCTAVE_VERSION', 'builtin') == 5)    % running Octave?
            save([fileName, '.txt'], 'nnData', '-text'); 
                fprintf('File ''%s'' has been saved with Octave .mat text format...\n', [fileName, '.txt']); 
        end
        clear nnData;
    catch
        if (exist('nnData')) 
            clear nnData; end
        fprintf('\n\n');
        fprintf('Error while converting: %s \n', fileName); 
        fprintf('ERROR: %s \n\n', lasterr()); 
        returnOK = 0; return
    end
    
    returnOK = 1; return
end