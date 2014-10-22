function [px,py] = punto(r,angulo,robot,cuadrante)

% Funcion para calcular los punto de las rectas que son tangente a los
% circulos

    dx=abs(sind(angulo)*r);

    a=90-angulo;
    dy=abs(sind(a)*r);
    
    if cuadrante == 1
        px=robot(1)+dx;
        py=robot(2)+dy;
%         plot(px,py,'Ob');%
    end
    if cuadrante == 2
        px=robot(1)-dx;
        py=robot(2)+dy;
%         plot(px,py,'Ob');%
    end
    if cuadrante == 3
        px=robot(1)-dx;
        py=robot(2)-dy;
%         plot(px,py,'Ob');%
    end
    if cuadrante == 4
        px=robot(1)+dx;
        py=robot(2)-dy;
%         plot(px,py,'Ob');%
    end
end