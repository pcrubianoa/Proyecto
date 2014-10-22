function [puntoArriba,puntoAbajo] = proximoDestino(robot,obstaculo,obstaculox,r)

% Funcion que determina cuadrante a manejar para sacar tangente

    puntoAbajo=0;
    puntoArriba=0;
    if robot(1)<obstaculo(1) & robot(2)<=obstaculo(2)% I
        cuadranteArriba = [4,2];
        cuadranteAbajo = [2,4];
    end
    if robot(1)>obstaculo(1) & robot(2)<obstaculo(2)% II
        cuadranteArriba = [3,1];
        cuadranteAbajo = [1,3];
    end
    if robot(1)>obstaculo(1) & robot(2)>obstaculo(2)% III
        cuadranteArriba = [4,2];
        cuadranteAbajo = [2,4];
    end
    if robot(1)<obstaculo(1) & robot(2)>obstaculo(2)% IV
        cuadranteArriba = [3,1];
        cuadranteAbajo = [1,3];
    end

    delta = 1;
    angulo = 0;

    while(angulo<90 & delta~=0)

        [px,py]=punto(r,angulo,robot,cuadranteArriba(1));
    %     plot(px,py,'Ob');

        [ox,oy]=punto(r,angulo,obstaculo,cuadranteArriba(2));
    %       plot(ox,oy,'Ob');

        m=(oy-py)/(ox-px);
        C=(-(m*px)+py);

        CR=(C-robot(2)); 
        B=1+(m^2);
        if (cuadranteArriba(1)==4)
            if CR>=0
               A=(2*robot(1)+2*(m*CR)); 
            end
            if CR<0
               A=(2*robot(1)-2*(m*CR))*-1;
            end
        end
        if (cuadranteArriba(1)==1)
            if CR<=0
               A=(2*robot(1)+2*(m*CR)); 
            end
            if CR>0
               A=(2*robot(1)-2*(m*CR))*-1;
            end
        end
        if (cuadranteArriba(1)==2)
            if CR<=0
               A=(2*robot(1)+2*(m*CR)); 
            end
            if CR>0
               A=(2*robot(1)-2*(m*CR))*-1;
            end
        end    
        if (cuadranteArriba(1)==3)
            if CR>=0
               A=(2*robot(1)+2*(m*CR)); 
            end
            if CR<0
               A=(2*robot(1)-2*(m*CR))*-1;
            end
        end    

        CC=(robot(1)^2)+(CR^2)-(r^2);

        delta=round(A^2-4*(B*CC)); % DELTA ---> tipo de recta entre circulos tangente
    %   pause(0.5)
    %   plot([px ox],[py oy],'g');
        angulo=angulo+1; 
    end
    
        dRobotObs = distancia(robot,obstaculo);
        
        if (cuadranteArriba(1)==1)
               
            puntoArriba=[obstaculox{1}(1)+(obstaculo(1)-obstaculox{1}(1)),obstaculox{1}(2)-(obstaculox{1}(2)-obstaculo(2))];
            puntoAbajo=[obstaculox{1}(3)+(obstaculo(1)-obstaculox{1}(3)),obstaculox{1}(4)-(obstaculox{1}(4)-obstaculo(2))];

        end
        if (cuadranteArriba(1)==2)
                     
            puntoArriba=[obstaculox{1}(1)-(obstaculo(1)-obstaculox{1}(1)),obstaculox{1}(2)+(obstaculox{1}(2)-obstaculo(2))];
            puntoAbajo=[obstaculox{1}(3)-(obstaculo(1)-obstaculox{1}(3)),obstaculox{1}(4)+(obstaculox{1}(4)-obstaculo(2))];

        end
        if (cuadranteArriba(1)==3)
            
            puntoArriba=[obstaculox{1}(1)-(obstaculo(1)-obstaculox{1}(1)),obstaculox{1}(2)+(obstaculox{1}(2)-obstaculo(2))];
            puntoAbajo=[obstaculox{1}(3)-(obstaculo(1)-obstaculox{1}(3)),obstaculox{1}(4)+(obstaculox{1}(4)-obstaculo(2))];

        end
        if (cuadranteArriba(1)==4)
            
            puntoArriba=[obstaculox{1}(1)-(obstaculo(1)-obstaculox{1}(1)),obstaculox{1}(2)+(obstaculox{1}(2)-obstaculo(2))];
            puntoAbajo=[obstaculox{1}(3)-(obstaculo(1)-obstaculox{1}(3)),obstaculox{1}(4)+(obstaculox{1}(4)-obstaculo(2))];
        
        end
end