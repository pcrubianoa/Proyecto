function toque=obstaculo(obstaculos,robotx,destinox,obstaculox)

% Funcion que determina si hay contacto entre obstaculo y vision ROBOT
% toque ------> flag "SI" hay o "NO" toque
% ARGUMENTOS: obstaculos,robotx,destinox,obstaculox

    toque = 0;


    m1 = (obstaculox{1}(4)-obstaculox{1}(2))/(obstaculox{1}(3)-obstaculox{1}(1));     % Pendiente del obstaculo
    
    m2 = (destinox{1}(2)-robotx{1}(2))/(destinox{1}(1)-robotx{1}(1));                 % Pendiente linea de arriba
    
    x = (-m2*robotx{1}(1)+robotx{1}(2)+m1*obstaculox{1}(1)-obstaculox{1}(2))/(m1-m2); % Interseccion arriba
    y = m1*(x)-m1*obstaculox{1}(1)+obstaculox{1}(2);  
    
    m2 = (destinox{1}(4)-robotx{1}(4))/(destinox{1}(3)-robotx{1}(3));                 % Pendiente linea de abajo
    
    xx = (-m2*robotx{1}(3)+robotx{1}(4)+m1*obstaculox{1}(1)-obstaculox{1}(2))/(m1-m2);% Interseccion abajo
    
    yy = m1*(xx)-m1*obstaculox{1}(1)+obstaculox{1}(2);  
    
    Dv1=round(sqrt(((obstaculos(1))-x)^2+((obstaculos(2))-y)^2));
    
    if Dv1>25
        toque = 0;
    end
    if Dv1<=25
        toque = 1;
    end
    if toque == 0
        Dv2 = round(sqrt(((obstaculos(1))-xx)^2+((obstaculos(2))-yy)^2));
        if Dv2>25
            toque = 0;
        end
        if Dv2<=25
            toque = 1;
        end
    end
end