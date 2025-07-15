function [returnYes_No] = yes_no(msgPrompt)
    % =========== A replacement for 'yes_or_no()' Octave's prompt =============
    %    function [returnYes_No] = yes_no(msgPrompt)
    %    
    %    Parameters:
    %    - msgPrompt: Default msgPrompt to the user 
    %    
    %    Notes:
    %    + At the end of the prompt the text ' (Yes/No) ' is added
    %      including leading and trailing spaces.
    %    + Both 'Yes' and 'Y' are accepted answers, uppercase and lowercase.
    %      This may be of course be modified to suit your preferences.
    %    + The same for 'No' and 'N', uppercase and lowercase.
    %    + Any answer different than Yes or No is accepted as 
    %      a default 'No' answer. 
    %      A message is displayed to notify this to the user.
    %     
    %    This function has been included to satisfy the absence of
    %    yes_or_no() in Matlab (it is included in Octave).
    %     
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
        a_a = 'Are you sure?';  % Default msgPrompt to the user 
    switch nargin               % Complete optional arguments
        case 0
            msgPrompt = a_a;
    end
    
    % You may edit the ' (Yes/No) ' prompt to suit your language
    auxAnswer = input([msgPrompt, ' (Yes/No) '], 's');
    if (length(auxAnswer) > 0)
        auxB = upper(auxAnswer(1:1));
    else
        auxB = 'N';
    end
    
    % Accept an invalid entry as an attempt to interrupt execution
    if (uint32(auxB)<65 || uint32(auxB)>90) % 65='A', 90='Z'
        fprintf('...\n');
        fprintf('To interrupt execution type ''dbquit'' or else type ''dbcont'' to answer ''No''.\n');
        fprintf('...\n\n');
        keyboard;
    end
    
    % See note below regarding various 'Yes' answers in several languages
    if (~isempty(strfind('YSODIJ', auxB)))  
        returnYes_No = 1;
    elseif (isequal(auxB,'N'))
        returnYes_No = 0;
    else
        fprintf('Accepted default answer: ''No''.\n');
        returnYes_No = 0;
    end
    
    return
end

% How do you say 'Yes' in other languages?
% ----------------------------------------
% 
% English:Yes       'Y'
% Spanish:Si        'S'
% Italian:Si
% Catalan:Si
% Portuguese:Sim
% French:Oui        'O'
% Slovenian:Da      'D'
% Russian:Da
% Welsh:Ie          'I'
% Hungarian:Igen
% German:Ja         'J'
% Danish:Ja
% Dutch:Ja
% Afrikaans:Ja
% Norwegian:Ja
% Icelandic:Ja
% 
% 
% How do you say 'No' in other languages?
% ----------------------------------------
% 
% English:No        'N'
% Spanish:No
% Italian:No
% Catalan:No
% Portuguese:Nao
% French:Non        
% Slovenian:Ne
% Russian:Niet
% Welsh:Nage
% Hungarian:Nem
% German:Nein
% Danish:Nej
% Dutch:Nee
% Afrikaans:Nee
% Norwegian:Nei
% Icelandic:Nei
