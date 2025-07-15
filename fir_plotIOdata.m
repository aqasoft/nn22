function [returnOK] = fir_plotIOdata(nnFilesBase, X, Y)
    % =========== Plot Data =============
    %   function [returnOK] = 
    %       nn_plotIOdata(nnFilesBase, X, Y)
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
        grid on;
        plot(X, 'g');   %, 'LineWidth', 2);
        plot(Y, 'r-o'); % 'bo'); 'mo'); 

        legend({'predicted' 'objective'});
        hold off;

        fprintf(msG.thePlotIsBeingBuilt_);
        fprintf(msG.pressEnterToCloseThePlotWindow);
        
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