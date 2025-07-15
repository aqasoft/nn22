function [returnOK] = sine_plotIOdata(nnFilesBase, X, Y)
    % =========== Graficar Datos de Entrenamiento =============
    %   function [returnOK] = 
    %   (...)_plotIOdata(nnFilesBase, X, Y)
    %    - Graficar los datos Y contra X
    %
    %    Parametros:
    %    ~~~~~~~~~~~
    %    nnFilesBase (xor, sine, etc.)
    %    X, Y (pares de entrada/salida en la epoca)
    %
    %    -------------------------------------------
    %    Copyright (C) 2014 Alejandro Quiroga Alsina
    %
    global msG;
    
    try
        h = figure();
        hold on;
        grid on;
        plot(X, Y, 'ro'); % 'bo'); 'mo'); 
        plot(X, sin(X), 'g');

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