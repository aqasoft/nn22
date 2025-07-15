function [returnOK] = and_plotIOdata(nnFilesBase, X, Y)
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
        view(70, 300);
        hold on;
        plot3(X([0*(size(X, 1)/4)+1:1*(size(X, 1)/4)],1), ...
              X([0*(size(X, 1)/4)+1:1*(size(X, 1)/4)],2), ...
              Y([0*(size(Y, 1)/4)+1:1*(size(Y, 1)/4)],1), 'ro', 'LineWidth', 2);
        plot3(X([1*(size(X, 1)/4)+1:2*(size(X, 1)/4)],1), ...
              X([1*(size(X, 1)/4)+1:2*(size(X, 1)/4)],2), ...
              Y([1*(size(Y, 1)/4)+1:2*(size(Y, 1)/4)],1), 'ko', 'LineWidth', 2);
        plot3(X([2*(size(X, 1)/4)+1:3*(size(X, 1)/4)],1), ...
              X([2*(size(X, 1)/4)+1:3*(size(X, 1)/4)],2), ...
              Y([2*(size(Y, 1)/4)+1:3*(size(Y, 1)/4)],1), 'go', 'LineWidth', 2);
        plot3(X([3*(size(X, 1)/4)+1:4*(size(X, 1)/4)],1), ...
              X([3*(size(X, 1)/4)+1:4*(size(X, 1)/4)],2), ...
              Y([3*(size(Y, 1)/4)+1:4*(size(Y, 1)/4)],1), 'b+', 'LineWidth', 2);    
        grid on;
        hold off;
        view(3);
        
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