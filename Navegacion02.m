function Navegacion02
    %% PROYECTO
    %% Fecha: 16 de octubre de 2014

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


        robot = [mx-150,(my-150)+1];                            % posicion del robot (mouse)
%       robot = [mx,my+1];                                      % posicion del robot (mouse)

        Otext = {'1','2','3','4','5','6'};                      % numeros de cada obstaculo
        Ptext = {'\bfROBOT','\bfDESTINO'};                      % etiquetas ROBOT - DESTINO
        destino = [900,300];                                    % Posición destino
        
%       robot = [500,300];                                      % Posición robot
%       robot = [robot(1),robot(2)+1];

        obstaculosDefinidos = {[700,350],...                     % Obstaculo No.1
                               [700,280],...                     % Obstaculo No.2
                               [800,200],...                      % Obstaculo No.3
                               [50,300],...                      % Obstaculo No.4
                               [50,300],...                      % Obstaculo No.5
                               [50,300]};                        % Obstaculo No.6

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
        
        flag = 1;
        k = 1;
        ruta = {k};
        ruta{k} = robot;
%         toque=0;
        while (flag ~= 0)
              obstaculos2 = obsEntrePuntos(obstaculosDefinidos,ruta{k});
              if isempty(obstaculos2)
                  flag = 0;
              else
                   [puntoArriba,puntoAbajo,flag] = rutas(ruta{k},destino,obstaculos2,r);
                   
                   m=0;
                   toque1=0;
                   if flag == 1
                       while toque1 == 0 && m<length(obstaculos2)
                           m=m+1;
                           [robotx,destinox,obstaculox] = ubicarDestino(robot,puntoArriba,obstaculos2{m},r);
                           toque1 = obstaculo(obstaculos2{m},robotx,destinox,obstaculox); 
                           if toque1 == 1
                               [puntoArriba,puntoAbajo,flag] = rutas(ruta{k},puntoArriba,obstaculos2,r);
                           end
                       end
                   end
                   p=0;
                   toque2=0;
                   if flag == 2
                       if toque2 == 0 && p<length(obstaculos2)
                           p=p+1;
                           [robotx,destinox,obstaculox] = ubicarDestino(robot,puntoAbajo,obstaculos2{p},r);
                           toque2 = obstaculo(obstaculos2{p},robotx,destinox,obstaculox);
                           if toque2==1
                               [puntoArriba,puntoAbajo,flag] = rutas(ruta{k},puntoAbajo,obstaculos2,r);
                           end
                       end
                   end
              end
              
              k = k+1;
              if flag == 0
                  ruta{k} = destino;
              end
              if flag == 1 % Arriba
                  ruta{k} = puntoArriba;
              end
              if flag == 2 % Abajo
                  ruta{k} = puntoAbajo;
              end             
         end   
         for i = 1:(length(ruta)-1)
             plot([ruta{i}(1) ruta{i+1}(1)],[ruta{i}(2) ruta{i+1}(2)],'g'); 
             plot(ruta{i}(1),ruta{i}(2),'Or');
         end
    end
end