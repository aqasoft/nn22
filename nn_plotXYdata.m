function [returnOK] = nn_plotXYdata(nnFilesBase, X, Y)
    % =========== Plot Data =============
    %   function [returnOK] = 
    %       nn_plotXYdata(nnFilesBase, X, Y)
    %
    %    Parameters:
    %    - nnFilesBase (Goes to plot's legend if there is one)
    %    - X, Y (input/output pairs)
    %
    %    Plots Y data against X data
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global msG;
    
    try
        h = figure();
        hold on;
        
        switch nargin
            case 3
                plot(X, Y, 'm', 'LineWidth', 2);
            case 2
                plot(X, 'b', 'LineWidth', 2);
        end
        
        legend(nnFilesBase);
        grid on;
        hold off;

        fprintf(msG.thePlotIsBeingBuilt_);
        fprintf(msG.pressEnterToCloseThePlotWindow);
        pause;
    catch
        fprintf('\n\n');
        fprintf(msG.errorPlottingData_Check_plotIOdata_Function); 
        fprintf(msG.error_VAR1, lasterr()); 
        returnOK = 1; return, 
    end

    if ishandle(h)
        close(h); end
    
    returnOK = 1; return
end