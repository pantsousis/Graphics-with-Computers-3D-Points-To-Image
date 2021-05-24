function result = bresenham(vertices_2d)
    %The function returns a Nx2 all the N pixels that belong in a line between two
    %vertices
    %vertices_2d is a 2x2 array, where each row represents the x and y
    %coordinate of a vertex of an line
    
    %Coordinates of each input point
    x1 = vertices_2d(1,1);
    y1 = vertices_2d(1,2);
    x2 = vertices_2d(2,1);
    y2 = vertices_2d(2,2);
    
    deltaX = 2*(x2 - x1);
    deltaY = 2*(y2 - y1);
    
    %===========deltaX = 0============
    if deltaX == 0 %If line is vertical (slope can't be determined, division by 0)
        if y1 < y2
           %Initialize at first point
           x = x1; 
           y = y1;
           %Add point to line
           line(1,:) = [x,y];
           %Set index counter for line array to 2
           counter = 2;
           %Add every other point to the line
           for i = y1+1:y2
               y = y+1;
               line(counter,:)=[x,y];
               counter = counter + 1;
           end
        else
           x = x2; 
           y = y2;
           %Add point to line
           line(1,:) = [x,y];
           %Set index counter for line array to 2
           counter = 2;
           %Add every other point to the line
           for i = y2+1:y1
               y = y+1;
               line(counter,:)=[x,y];
               counter = counter + 1;
           end
        end
    %=================================
    else
    %===========deltaX != 0============
    %Transformation flags
    slope_neg = 0;
    slope_big = 0;
    
    %Swap points if required, so that x1 is always the lowest
        if x1>x2
            temp = x1;
            x1 = x2;
            x2 = temp;
            
            temp = y1;
            y1 = y2;
            y2 = temp;
            
            deltaX = 2*(x2 - x1);
            deltaY = 2*(y2 - y1);
        end
    
    %To re-use the same algorithm which finds the line if 1>=slope>=0
    %we need to adjust the points as shown below.
        if (deltaX<0 && deltaY>0) || (deltaX>0 && deltaY<0) %If slope negative
            %Then do the transformation y' = -y
            y1 = -y1;
            y2 = -y2;
            deltaY = 2*(y2 - y1);
            slope_neg = 1;
        end

        if abs(deltaX)<abs(deltaY) %If slope outside 1>=slope>=0
            %Then x' = y and y' = x
            temp = x1;
            x1 = y1;
            y1 = temp;

            temp = x2;
            x2 = y2;
            y2 = temp;

            deltaX = 2*(x2 - x1);
            deltaY = 2*(y2 - y1);

            slope_big = 1;
        end
    
        y = y1;
        x = x1;
       
        f = -deltaY + deltaX/2;
        line(1,:)=[x,y];
        counter = 2;
        for i=x1+1:1:x2
            x=i;
            if f<0
                y=y+1;
                f=f + deltaX;
            end
            f = f - deltaY;
            line(counter,:)=[x,y];
            counter = counter + 1;
        end
        
        %Reverse transformations
        if slope_big == 1
            temp = line(:,1);
            line(:,1) = line(:,2);
            line(:,2) = temp;
        end
        
        if slope_neg == 1
            line(:,2) = -line(:,2);
        end
        
    end
            
    result = line;
end 