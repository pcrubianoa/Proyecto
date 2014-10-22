function Navegacion
    %% PROYECTO
    %% Fecha: 15 de octubre de 2014

    clc                                                         % Limpia variables
    close                                                       % Limpia ventana de comandos
    clear                                                       % Cierra ventanas abiertas
     
    f = figure(1);                                              % Grafico figure()  
    set(gcf, 'Position', get(0,'Screensize'));                  % Maximizar ventana figure()
    set(f,'WindowButtonMotionFcn', @myCallBack);                % set mouse - event screen

    function myCallBack(varargin)   
        
%% Obtener poscion MOUSE

        clf;                                                    % Limpia figure()
        hObject = varargin{1};                                  % objeto mouse
        mpos = get(hObject,'CurrentPoint');                     % posición actual del ratón       
        mx = mpos(1);                                           % x coordenada
        my = mpos(2);                                           % y coordenada

        hold on;                                                % Dibija sobre el figure()

%% Constantes posicion elementos


        robot = [mx-150,(my-150)+1];                              % posicion del robot (mouse)
%       robot = [mx,my+1];                                    % posicion del robot (mouse)

        Otext = {'1','2','3','4','5','6'};                      % numeros de cada obstaculo
        Ptext = {'\bfROBOT','\bfDESTINO'};                      % etiquetas ROBOT - DESTINO
        destino = [900,300];                                    % Posición destino
        
%       robot = [500,300];                                      % Posición robot
%       robot = [robot(1),robot(2)+1];

        obstaculosDefinidos = {[300,250],...                     % Obstaculo No.1
                               [300,350],...                     % Obstaculo No.2
                               [500,250],...                     % Obstaculo No.3
                               [500,350],...                     % Obstaculo No.4
                               [700,250],...                     % Obstaculo No.5
                               [700,350]};                       % Obstaculo No.6

%% Ordenar obstaculos 
        
        dis = {};                                               % inicializo celda
        for i = 1:length(obstaculosDefinidos)                   % iteracion 1 - hasta el numero de obstaculos
            dis{i} = distancia(robot, obstaculosDefinidos{i});  % calcula distancia entre robot y cada obstaculo
        end
        
        A = [1 dis{1}; 2 dis{2}; 3 dis{3}; 4 dis{4}; 5 dis{5}; 6 dis{6}];% guardo cada distancia con un ID
        [B,k] = sort(A(:,2));                                            % ordena de forma descendente ... 
        B = [A(k) B];                                                    % las distancias
        B(:,1);                                                          % ID de cada obstaculo
        obstaculos = {obstaculosDefinidos{B(:,1)}};                      % obstaculos ordenados segun distancia a ROBOT
                      
%% Numero de cada obstaculo

        text(20,570,'ROBOT','fontsize',10)
        text(20,550,strcat('X:',num2str(ceil(robot(1)))),'fontsize',8)
        text(55,550,strcat('Y:',num2str(ceil(robot(2)))),'fontsize',8)
        text(20,540,'Angulo:','fontsize',8)                               % angulo
        
        text(20,500,'DESTINO','fontsize',10)                               % Destino
        text(20,480,strcat('X:',num2str(ceil(destino(1)))),'fontsize',8)
        text(55,480,strcat('Y:',num2str(ceil(destino(2)))),'fontsize',8)
        
        text(20,440,'RUTAS','fontsize',10)                               % Rutas
        text(20,420,'Ruta No.1:','fontsize',8)                               % Ruta No. 1 
        text(20,410,'Ruta No.2:','fontsize',8)                               % Ruta No. 2

        text(robot(1)-18,robot(2)+10,Ptext(1),'fontsize',8)
        text(destino(1)-21,destino(2)+10,Ptext(2),'fontsize',8)

        text(obstaculos{1}(1)-5,obstaculos{1}(2),Otext(1),'fontsize',15)
        text(obstaculos{2}(1)-5,obstaculos{2}(2),Otext(2),'fontsize',15)
        text(obstaculos{3}(1)-5,obstaculos{3}(2),Otext(3),'fontsize',15)
        text(obstaculos{4}(1)-5,obstaculos{4}(2),Otext(4),'fontsize',15)
        text(obstaculos{5}(1)-5,obstaculos{5}(2),Otext(5),'fontsize',15)
        text(obstaculos{6}(1)-5,obstaculos{6}(2),Otext(6),'fontsize',15)
        
        text(obstaculosDefinidos{1}(1)-3,obstaculosDefinidos{1}(2)+15,Otext(1),'fontsize',10)
        text(obstaculosDefinidos{2}(1)-3,obstaculosDefinidos{2}(2)+15,Otext(2),'fontsize',10)
        text(obstaculosDefinidos{3}(1)-3,obstaculosDefinidos{3}(2)+15,Otext(3),'fontsize',10)
        text(obstaculosDefinidos{4}(1)-3,obstaculosDefinidos{4}(2)+15,Otext(4),'fontsize',10)
        text(obstaculosDefinidos{5}(1)-3,obstaculosDefinidos{5}(2)+15,Otext(5),'fontsize',10)
        text(obstaculosDefinidos{6}(1)-3,obstaculosDefinidos{6}(2)+15,Otext(6),'fontsize',10)

%% Constantes para dibujo circulos

        d = 50;                                     % Diametro del robot
        r = d/2;                                    % Radio del robot
        theta = linspace(0,2*pi,600);               % Theta
        rho = ones(1,600)*r;                        % Rho

        plot(robot(1),robot(2),'Or');               % Grafica posicion inicial
        plot(destino(1),destino(2),'Ob');           % Grafica posicion destino

%% Grafica de robot y obstaculos - Circulos

        robotCirculo = [robot(1) robot(2)];                                               % ROBOT
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'r', 'linewidth', 2); 

        robotCirculo = [destino(1) destino(2)];                                           % DESTINO
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'r', 'linewidth', 2); 

        robotCirculo = [obstaculos{1}(1) obstaculos{1}(2)];                               % Obstaculo No. 1
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);

        robotCirculo = [obstaculos{2}(1) obstaculos{2}(2)];                               % Obstaculo No. 2
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);

        robotCirculo = [obstaculos{3}(1) obstaculos{3}(2)];                               % Obstaculo No. 3
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);

        robotCirculo = [obstaculos{4}(1) obstaculos{4}(2)];                               % Obstaculo No. 4
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);

        robotCirculo = [obstaculos{5}(1) obstaculos{5}(2)];                               % Obstaculo No. 5
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);

        robotCirculo = [obstaculos{6}(1) obstaculos{6}(2)];                               % Obstaculo No. 6
        [robotCirculoX, robotCirculoY] = pol2cart(theta,rho);                             % Conversion de coordenadas cartesianas a polares
        robotCirculoX = robotCirculoX + robotCirculo(1);                                  % Coordenada X obstaculo
        robotCirculoY = robotCirculoY + robotCirculo(2);                                  % Coordenada Y obstaculo
        plot(robotCirculoX, robotCirculoY, 'b', 'linewidth', 2);
        
        m2 = 0:0.01:1000;                       % variables para dibujo linea diagonal...
        t2 = 0.6*m2;                            % dimensiones cancha    
        hold on                                 % diguja sobre figure la linea
        plot(m2,t2,'color', 'white');           % color blanca para que no se vea
      
%% %%%%%%%%%%%%%%%%%%%%%%    MAIN PRINCIPAL   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        puntoArriba = 0;
        puntoAbajo = 0;

        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"
   
        obstaculos2 = obsEntrePuntos(obstaculos,robot,destino);
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(robot,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
        if (isempty(obstaculos2)) || (toque == 0)
            plot([robot(1) destino(1)],[robot(2) destino(2)],'g');    
        end
        if (toque == 1)
           
            [puntoArriba,puntoAbajo] = proximoDestino(robot,obstaculos2{n1},obstaculox,r);

            dUP = distancia(robot,puntoArriba);
            dDOWN = distancia(robot,puntoAbajo);

            j=2;
            
            while(j<=length(obstaculos2))
                
            dArriba=distancia(puntoArriba,obstaculos2{j});
            dAbajo=distancia(puntoAbajo,obstaculos2{j});
            dArriba=dArriba+1;
            
            spArriba=0;
            spAbajo=0;        
                j=j+1;
                if dArriba<=50 
                    spArriba=1;
                end
                if dAbajo<=50 
                    spAbajo=1;
                end
            end                   
            if spArriba==0 && spAbajo==0
                
                if dUP<=dDOWN
                    plot(puntoArriba(1),puntoArriba(2),'Or');
                    plot([robot(1) puntoArriba(1)],[robot(2) puntoArriba(2)],'g');
%                   plot([puntoArriba(1) destino(1)],[puntoArriba(2) destino(2)],'g');
%% puntoArriba
%       puntoArriba = 0;
%       puntoAbajo = 0;

        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"
   
        obstaculos2 = obsEntrePuntos(obstaculos,puntoArriba,destino);
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(puntoArriba,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
        if (isempty(obstaculos2)) || (toque == 0)
            plot([puntoArriba(1) destino(1)],[puntoArriba(2) destino(2)],'g');    
        end
        if (toque == 1)
           
            [puntoArriba2,puntoAbajo2] = proximoDestino(puntoArriba,obstaculos2{n1},obstaculox,r);

            dUP = distancia(puntoArriba,puntoArriba2);
            dDOWN = distancia(puntoArriba,puntoAbajo2);

            j=2;
            
            while(j<=length(obstaculos2))
                
            dArriba=distancia(puntoArriba,obstaculos2{j});
            dAbajo=distancia(puntoAbajo,obstaculos2{j});
            dArriba=dArriba+1;
            
            spArriba=0;
            spAbajo=0;        
                j=j+1;
                if dArriba<=50 
                    spArriba=1;
                end
                if dAbajo<=50 
                    spAbajo=1;
                end
            end                   
            if spArriba==0 && spAbajo==0
                
                if dUP<=dDOWN
                    plot(puntoArriba2(1),puntoArriba2(2),'Or');
                    plot([puntoArriba(1) puntoArriba2(1)],[puntoArriba(2) puntoArriba2(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');
                else
                    plot(puntoAbajo2(1),puntoAbajo2(2),'Or');
                    plot([puntoArriba(1) puntoAbajo2(1)],[puntoArriba(2) puntoAbajo2(2)],'g');
                    plot([puntoAbajo2(1) destino(1)],[puntoAbajo2(2) destino(2)],'g'); 
                end
            end
                if spArriba==1 && spAbajo==0
                    plot(puntoAbajo2(1),puntoAbajo2(2),'Or');
                    plot([puntoArriba(1) puntoAbajo2(1)],[puntoArriba(2) puntoAbajo2(2)],'g');
                    plot([puntoAbajo2(1) destino(1)],[puntoAbajo2(2) destino(2)],'g'); 
                end
                if spArriba==0 && spAbajo==1
                    plot(puntoArriba2(1),puntoArriba2(2),'Or');
                    plot([puntoArriba(1) puntoArriba2(1)],[puntoArriba(2) puntoArriba2(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');                     
                end
        end 
                else
                    plot(puntoAbajo(1),puntoAbajo(2),'Or');
                    plot([robot(1) puntoAbajo(1)],[robot(2) puntoAbajo(2)],'g');
%                     plot([puntoAbajo(1) destino(1)],[puntoAbajo(2) destino(2)],'g');

%% puntoAbajo

%       puntoArriba = 0;
%       puntoAbajo = 0;

        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"
   
        obstaculos2 = obsEntrePuntos(obstaculos,puntoAbajo,destino);
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(puntoAbajo,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
        if (isempty(obstaculos2)) || (toque == 0)
            plot([puntoAbajo(1) destino(1)],[puntoAbajo(2) destino(2)],'g');    
        end
        if (toque == 1)
           
            [puntoArriba3,puntoAbajo3] = proximoDestino(puntoAbajo,obstaculos2{n1},obstaculox,r);

            dUP = distancia(puntoAbajo,puntoArriba3);
            dDOWN = distancia(puntoAbajo,puntoAbajo3);

            j=2;
            
            while(j<=length(obstaculos2))
                
            dArriba=distancia(puntoArriba,obstaculos2{j});
            dAbajo=distancia(puntoAbajo,obstaculos2{j});
            dArriba=dArriba+1;
            
            spArriba=0;
            spAbajo=0;        
                j=j+1;
                if dArriba<=50 
                    spArriba=1;
                end
                if dAbajo<=50 
                    spAbajo=1;
                end
            end                   
            if spArriba==0 && spAbajo==0
                
                if dUP<=dDOWN
                    plot(puntoArriba3(1),puntoArriba3(2),'Or');
                    plot([puntoAbajo(1) puntoArriba3(1)],[puntoAbajo(2) puntoArriba3(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');
                else
                    plot(puntoAbajo3(1),puntoAbajo3(2),'Or');
                    plot([puntoAbajo(1) puntoAbajo3(1)],[puntoAbajo(2) puntoAbajo3(2)],'g');
                    plot([puntoAbajo3(1) destino(1)],[puntoAbajo3(2) destino(2)],'g'); 
                end
            end
                if spArriba==1 && spAbajo==0
                    plot(puntoAbajo3(1),puntoAbajo3(2),'Or');
                    plot([puntoArriba(1) puntoAbajo3(1)],[puntoArriba(2) puntoAbajo3(2)],'g');
                    plot([puntoAbajo3(1) destino(1)],[puntoAbajo3(2) destino(2)],'g'); 
                end
                if spArriba==0 && spAbajo==1
                    plot(puntoArriba3(1),puntoArriba3(2),'Or');
                    plot([puntoArriba(1) puntoArriba3(1)],[puntoArriba(2) puntoArriba3(2)],'g');
                    plot([puntoArriba3(1) destino(1)],[puntoArriba3(2) destino(2)],'g');                     
                end
        end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end
                if spArriba==1 && spAbajo==0
                    plot(puntoAbajo(1),puntoAbajo(2),'Or');
                    plot([robot(1) puntoAbajo(1)],[robot(2) puntoAbajo(2)],'g');
%                     plot([puntoAbajo(1) destino(1)],[puntoAbajo(2) destino(2)],'g'); 

%% puntoAbajo

%       puntoArriba = 0;
%       puntoAbajo = 0;

        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"
   
        obstaculos2 = obsEntrePuntos(obstaculos,puntoAbajo,destino);
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(puntoAbajo,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
        if (isempty(obstaculos2)) || (toque == 0)
            plot([puntoAbajo(1) destino(1)],[puntoAbajo(2) destino(2)],'g');    
        end
        if (toque == 1)
           
            [puntoArriba3,puntoAbajo3] = proximoDestino(puntoAbajo,obstaculos2{n1},obstaculox,r);

            dUP = distancia(puntoAbajo,puntoArriba3);
            dDOWN = distancia(puntoAbajo,puntoAbajo3);

            j=2;
            
            while(j<=length(obstaculos2))
                
            dArriba=distancia(puntoArriba,obstaculos2{j});
            dAbajo=distancia(puntoAbajo,obstaculos2{j});
            dArriba=dArriba+1;
            
            spArriba=0;
            spAbajo=0;        
                j=j+1;
                if dArriba<=50 
                    spArriba=1;
                end
                if dAbajo<=50 
                    spAbajo=1;
                end
            end                   
            if spArriba==0 && spAbajo==0
                
                if dUP<=dDOWN
                    plot(puntoArriba3(1),puntoArriba3(2),'Or');
                    plot([puntoAbajo(1) puntoArriba3(1)],[puntoAbajo(2) puntoArriba3(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');
                else
                    plot(puntoAbajo3(1),puntoAbajo3(2),'Or');
                    plot([puntoAbajo(1) puntoAbajo3(1)],[puntoAbajo(2) puntoAbajo3(2)],'g');
                    plot([puntoAbajo3(1) destino(1)],[puntoAbajo3(2) destino(2)],'g'); 
                end
            end
                if spArriba==1 && spAbajo==0
                    plot(puntoAbajo3(1),puntoAbajo3(2),'Or');
                    plot([puntoArriba(1) puntoAbajo3(1)],[puntoArriba(2) puntoAbajo3(2)],'g');
                    plot([puntoAbajo3(1) destino(1)],[puntoAbajo3(2) destino(2)],'g'); 
                end
                if spArriba==0 && spAbajo==1
                    plot(puntoArriba3(1),puntoArriba3(2),'Or');
                    plot([puntoArriba(1) puntoArriba3(1)],[puntoArriba(2) puntoArriba3(2)],'g');
                    plot([puntoArriba3(1) destino(1)],[puntoArriba3(2) destino(2)],'g');                     
                end
        end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
                if spArriba==0 && spAbajo==1
                    plot(puntoArriba(1),puntoArriba(2),'Or');
                    plot([robot(1) puntoArriba(1)],[robot(2) puntoArriba(2)],'g');
%                   plot([puntoArriba(1) destino(1)],[puntoArriba(2) destino(2)],'g');   
%% puntoArriba

%       puntoArriba = 0;
%       puntoAbajo = 0;

        n1 = 0;                                 % indice obstaculos
        toque = 0;                              % flag "SI" hay toque o "NO"
   
        obstaculos2 = obsEntrePuntos(obstaculos,puntoArriba,destino);
          
        while(toque == 0) && n1<length(obstaculos2) 
            n1 = n1+1;
            [robotx,destinox,obstaculox] = ubicarDestino(puntoArriba,destino,obstaculos2{n1},r); 
            toque = obstaculo(obstaculos2{n1},robotx,destinox,obstaculox);     
        end
        if (isempty(obstaculos2)) || (toque == 0)
            plot([puntoArriba(1) destino(1)],[puntoArriba(2) destino(2)],'g');    
        end
        if (toque == 1)
           
            [puntoArriba2,puntoAbajo2] = proximoDestino(puntoArriba,obstaculos2{n1},obstaculox,r);

            dUP = distancia(puntoArriba,puntoArriba2);
            dDOWN = distancia(puntoArriba,puntoAbajo2);

            j=2;
            
            while(j<=length(obstaculos2))
                
            dArriba=distancia(puntoArriba,obstaculos2{j});
            dAbajo=distancia(puntoAbajo,obstaculos2{j});
            dArriba=dArriba+1;
            
            spArriba=0;
            spAbajo=0;        
                j=j+1;
                if dArriba<=50 
                    spArriba=1;
                end
                if dAbajo<=50 
                    spAbajo=1;
                end
            end                   
            if spArriba==0 && spAbajo==0
                
                if dUP<=dDOWN
                    plot(puntoArriba2(1),puntoArriba2(2),'Or');
                    plot([puntoArriba(1) puntoArriba2(1)],[puntoArriba(2) puntoArriba2(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');
                else
                    plot(puntoAbajo2(1),puntoAbajo2(2),'Or');
                    plot([puntoArriba(1) puntoAbajo2(1)],[puntoArriba(2) puntoAbajo2(2)],'g');
                    plot([puntoAbajo2(1) destino(1)],[puntoAbajo2(2) destino(2)],'g'); 
                end
            end
                if spArriba==1 && spAbajo==0
                    plot(puntoAbajo2(1),puntoAbajo2(2),'Or');
                    plot([puntoArriba(1) puntoAbajo2(1)],[puntoArriba(2) puntoAbajo2(2)],'g');
                    plot([puntoAbajo2(1) destino(1)],[puntoAbajo2(2) destino(2)],'g'); 
                end
                if spArriba==0 && spAbajo==1
                    plot(puntoArriba2(1),puntoArriba2(2),'Or');
                    plot([puntoArriba(1) puntoArriba2(1)],[puntoArriba(2) puntoArriba2(2)],'g');
                    plot([puntoArriba2(1) destino(1)],[puntoArriba2(2) destino(2)],'g');                     
                end
        end 
                end
        end 
%% nivel #1
  
%     [puntoArriba,puntoAbajo,flag] = rutas(robot,destino,obstaculos,r); 
    % nivel #2
%     [puntoArriba2,puntoAbajo2,flag] = rutas(puntoArriba,destino,obstaculos,r);
%     [puntoArriba3,puntoAbajo3,flag] = rutas(puntoAbajo,destino,obstaculos,r);
%   % nivel #3
%     [puntoArriba4,puntoAbajo4,flag] = rutas(puntoArriba2,destino,obstaculos,r);
%     [puntoArriba5,puntoAbajo5,flag] = rutas(puntoAbajo2,destino,obstaculos,r);
%     [puntoArriba6,puntoAbajo6,flag] = rutas(puntoArriba3,destino,obstaculos,r);
%     [puntoArriba7,puntoAbajo7,flag] = rutas(puntoAbajo3,destino,obstaculos,r);
%   % nivel #4
%     [puntoArriba8,puntoAbajo8,flag] = rutas(puntoArriba4,destino,obstaculos,r);
%     [puntoArriba9,puntoAbajo9,flag] = rutas(puntoAbajo4,destino,obstaculos,r);
%     [puntoArriba10,puntoAbajo10,flag] = rutas(puntoArriba5,destino,obstaculos,r);
%     [puntoArriba11,puntoAbajo11,flag] = rutas(puntoAbajo5,destino,obstaculos,r);
%     [puntoArriba12,puntoAbajo12,flag] = rutas(puntoArriba6,destino,obstaculos,r);
%     
    end
        %% primer paso    
end