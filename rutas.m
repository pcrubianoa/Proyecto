function [puntoArriba,puntoAbajo,flag] = rutas(robot,destino,obstaculos2,r)
    
        puntoArriba = 0;
        puntoAbajo = 0;
        flag = 0;
        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"        
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(robot,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
%         if (isempty(obstaculos2)) || (toque == 0)
% %             plot([robot(1) destino(1)],[robot(2) destino(2)],'g');    
%         end
        if (toque == 1)
           
            [puntoArriba,puntoAbajo] = proximoDestino(robot,obstaculos2{n1},obstaculox,r);
            
            j = 1; %%%%%
            
            while(j<=length(obstaculos2) && flag==0)
                
                dArriba = distancia(puntoArriba,obstaculos2{j});
                dAbajo = distancia(puntoAbajo,obstaculos2{j});
%                 dArriba = dArriba+1;
                
                if dArriba<50 && dAbajo>50
                    flag=2;%Abajo
                end
                if dAbajo<50 && dArriba>50
                    flag=1;%Arriba
                end  
                if dArriba<50 && dAbajo<50
                    flag = 2;
                    puntoAbajo(1)=puntoAbajo(1)-50;
                end
                j = j+1;
            end
            
            if flag == 0
                dUP = distancia(robot,puntoArriba);
                dDOWN = distancia(robot,puntoAbajo);
                if dUP<dDOWN
                    flag=1;
                else
                    flag=2;
                end
            end
        end
end