function main
m2 = 0:0.01:10;     %store all possible x-values in a vector
t2 = 2*m2;  % calculate all possible y-values

f=figure; hold on
myplots();  % draw all the plots

set(f,'WindowButtonMotionFcn', @myCallBack);   
% associate a callback function  'myCallBack' to capture mouse movement

    function myCallBack(varargin)
    % this function is called at every mouse movement
      clf;    
    hObject = varargin{1};
       
        mpos =get(hObject,'CurrentPoint');
        % get current mouse position w.r.t figure, starting from 1
       
        mx=mpos(1); % x co-ordinate of current mouse position
        my=mpos(2); % y co-ordinate of current mouse position
       

        
        fpos =get(gcf,'position');  
        %get the position of the figure in the screen, starting from 1

        fx=fpos(1); % x co-ordinate of bottom-left corner of the figure
        fy=fpos(2); % y co-ordinate of bottom-left corner of the figure
        
       
        fw=fpos(3); % width of the figure, as number of pixels
        fh=fpos(4); % height of the figure, as number of pixels
       
        plotPos = get(axes,'position'); 
                                         % get the position of the plot w.r.t. the figure.
                                         % it gives four values x,y,w,h,
                                         % all in range [0,1],
                                         % these are represented as the proportion in the
                                         % corresponding side of the figure
        px=plotPos(1); 
        % x co-ordinate of the bottom-left corner of the plot w.r.t. the figure
        % if fw=20, then px=0.1 means that the bottom-left corner of the plot
        % is 2 (=20x0.1) pixels away from the left side of the figure                
       
        py=plotPos(2); 
        % y co-ordinate of the bottom-left corner of the plot w.r.t. the figure

        pw=plotPos(3);  % width of the plot
        ph=plotPos(4);  % height of the plot
        % I have done the conversions of these values from the range [0,1] to
        % actual pixel values in the
        % 'function x = function_x(fw,px,pw,range_x,mx,fx)' later
           
        myplots();  % draw the plots
        
        M2 = function_x(fw,px,pw,10,mx,fx); 
        %get the corresponding M2 value at the current mouse position
                                              % m2 values are ranged from 0 to 10
       
        if M2 >= 0 & M2 <= 10                
            % if the mouse pointer is within the plot
            T2 = 2*M2;  % calculate T2 for the M2 value
           
            % prepare 2 strings containing the values to show on the screen
            strM2 = strcat('M2 = ',num2str(mx));
            strT2 = strcat('T2 = ',num2str(my));
            
            
           
            % the next few lines show the 4 strings on the screen
            t=15;
            text(1,t,strM2);
            text(1,t-1,strT2);
            
        else    % if the mouse pointer is within the plot
            text(1,15,'The mouse pointer is at out of range of possible M2 values.');
        end
    end

   function x = function_x(fw,px,pw,range_x,mx,fx) 
   %find the corresponding M2 value (i.e., the value of x co-ordinate in the plot)
   %at the current mouse position

        ppx = fw*px;   
        % convert x co-ordinate of the bottom-left corner of the plot,
        % w.r.t. the figure, to number of pixels
        ppw = fw*pw;    % convert width of the plot to number of pixels
       
        rx = mx-ppx;   
        % how many pixels the mouse is away from the left side of the plot
       
        x = rx/ppw*range_x;
       % scale rx to the range of possible M2 values, i.e., [0,10] (here range_x=10)
    end

    function myplots()
        hold on   % plot all the graphs in the same figure
        plot(m2,t2,'color', 'white'); % plot T2 values w.r.t. M2 values in red color
       
    end

end

