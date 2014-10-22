function obstaculos2 = obsEntrePuntos(obstaculos,robot)

% Funcion que obtiene los obstaculos entre el ROBOT y el DESTINO
% obstaculos2 = obsEntrePuntos(obstaculos,robot,destino)
% obstaculos2 -----> almacena la coordenada  de los obstaculos entre ROBOT
% y DESTINO
% ARGUEMENTOS: obstaculos,robot,destino

    obstaculos2 = {}; 
    i = 1;
    j = 1;
    while (i<length(obstaculos))
            
        if (obstaculos{i}(1)>=robot(1)+25) 
            obstaculos2{j} = obstaculos{i};
            j = j+1;
        end
        i = i+1;
    end
end