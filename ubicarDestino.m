function [robotx,destinox,obstaculox]=ubicarDestino(robot,destino,obstaculo,r)

    %plot([robot(1) robot(1)],[robot(2)+25 destino(2)+25],'k');
    Dc=sqrt((robot(1)-robot(1))^2 +((robot(2)+25)-(destino(2)+25))^2);
    
    %plot([robot(1) destino(1)],[destino(2)+25 destino(2)+25],'k');
    Da=sqrt((robot(1)-destino(1))^2 +((destino(2)+25)-(destino(2)+25))^2);

    Db=sqrt(Dc^2+Da^2);

    Ab=asind(Da/Db);
    Agiro=90-Ab;

    x=r*sind(Agiro);
    y=r*cosd(Agiro);
    
        
    if (robot(1)<obstaculo(1) && robot(2)<=obstaculo(2)) || (robot(1)>obstaculo(1) && robot(2)>obstaculo(2))% III
    
        dx1=robot(1)+ x;
        dy1=robot(2)+ y;

        dx2=robot(1)- x;
        dy2=robot(2)- y;
        
        robotx={[dx1,dy1,dx2,dy2]};
        
        px1=destino(1)+ x;
        py1=destino(2)+ y;

        px2=destino(1)- x;
        py2=destino(2)- y;
        
        destinox={[px1,py1,px2,py2]};
        
        ox1=obstaculo(1)- x;
        oy1=obstaculo(2)+ y;

        ox2=obstaculo(1)+ x;
        oy2=obstaculo(2)- y;
        
        obstaculox={[ox1,oy1,ox2,oy2]}; 
        
    end
    
    if (robot(1)>obstaculo(1) && robot(2)<obstaculo(2)) || (robot(1)<obstaculo(1) && robot(2)>obstaculo(2))% IV
    
        dx1=robot(1)+ x;
        dy1=robot(2)+ y;

        dx2=robot(1)- x;
        dy2=robot(2)- y;
        
        robotx={[dx1,dy1,dx2,dy2]};
        
        px1=destino(1)+ x;
        py1=destino(2)+ y;

        px2=destino(1)- x;
        py2=destino(2)- y;
        
        destinox={[px1,py1,px2,py2]};
        
        ox1=obstaculo(1)+ x;
        oy1=obstaculo(2)+ y;

        ox2=obstaculo(1)- x;
        oy2=obstaculo(2)- y;
        
        obstaculox={[ox1,oy1,ox2,oy2]}; 
        
    end
end