function [returnOK] = nn_localization()
    % =========== Load localized messages =============
    %    function [returnOK] = localization()
    %   
    %    - msG is to be declared as global prior to calling this function
    %    - msG needs to be declared as global into every file that 
    %      uses localized messages.
    %   
    %    - One step further, extend Localization:
    %      Brief instructions are included at the end of this file.
    %   
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global msG;

    try
        % ----- Select localization file -----
        fprintf('\n');
        choice = menu('Choose your language of preference: ', ... 
            'English (en-US)', ...     %1
            'Spanish (es-AR)');        %2
        switch choice
            case 1
                locFile = 'nn_localization_en_US';
            case 2
                locFile = 'nn_localization_es_AR';
        end

        % ----- Load selected localization file -----
        aux_locFile = str2func(locFile);
        [returnOK] = aux_locFile();
            if (~returnOK) 
                fprintf('\n\n');
                fprintf('ERROR loading file ''%s''.\n', locFile); 
                fprintf('ERROR: %s.\n\n', lasterr()); 
                returnOK = 0; return
            end
    catch
        fprintf('\n\n');
        fprintf('ERROR loading localization file (main localization script).\n'); 
        fprintf('ERROR: %s.\n\n', lasterr()); 
        returnOK = 0; return
    end
   
    
    % ----- Notify success and return -----
    fprintf('\n');
    fprintf(msG.successLoadingLocalizationData); 
    fprintf(msG.activeLocale);
    fprintf('\n\n');
    fprintf(msG.pressEnterToContinue);
    pause;
    clc;

    returnOK = 1; return
end

%   One step further, extend Localization languages:
%   ------------------------------------------------
%   1. There are three files that contain localization info:
%       a) nn_localization.m
%       b) nn_localization_en_US.m
%       c) nn_localization_es_AR.m
%   2. File a) is called at the very beginning of nn22.m and helps the user
%      to choose between files b), c), and perhaps other localized files that
%      may be added in the future.
%   3. Files b) and c) contain the localized messages and are twin files
%      with the same number of lines, containing the same structure variable
%      declarations, all belonging to the 'msG' global structure, one of them
%      assigns messages in English language and the other in Spanish.
%   4. In order to add another language you may add an edited copy of file b).
%      Just keep the variable names and change the strings. 
%      Take care of:
%       a) The inclusion of arguments in the 'fprintf' formatting,
%          meaning, the %s, %d, etc. data formatting, which are included in
%          the variable names as '_VAR1_', '_VAR2_', etc.
%       b) The line breaks formatting, '\n', that allow to display messages
%          to the screen in a clean and readable form.
%       c) Respect the limit of 80 chars per line displayed to the screen.
%       d) The maximum variable name length is 63 chars.
%   5. Extend the choice menu in line 20 above in this function file.
%   6. Remember that file names for functions should beging with a letter
%      and allow only letters, numbers and underscore chars. 
%      Using a dash '-' char is a common error: it will be tempting to
%      write 'nn_localization_pt-BR', 'nn_localization_fr-CA'... :)
%
