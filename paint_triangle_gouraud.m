function result = paint_triangle_gouraud(img,vertices_2d,vertex_colors)
    
    %Determine all the points that make a side
    side1=vertices_2d(1:2,:);
    side2=vertices_2d(2:3,:);
    side3=[vertices_2d(1,:);vertices_2d(3,:)];
    
    %Find all pixels that belong to the sides
    side1 = bresenham(side1);
    side2 = bresenham(side2);
    side3 = bresenham(side3);
    
    color1 = vertex_colors(1,:);
    color2 = vertex_colors(2,:);
    color3 = vertex_colors(3,:);
    
    %Group all pixels that belong to the sides
    side_pixels = [side1;side2;side3];
    
    %To matlab, distixos, den exei arraylists. Sinepws, den ksero pws na
    %apothikeusw ta sides pou exoun diaforetiko mikos ston idio pinaka.
    %Ara, den eixa kai tropo na kanw automatopoiiso tin diadikasia. Tha
    %mporousa na brw kapoio texnasma isws, alla fanike pio aplo apla na
    %ftiaksw 3 for loops. Opws kai na exei einai idia metaksi tous kai apla
    %ginetai linear interpolation gia ta pixels kathe pleuras
    
    %'Fix' vertex colors if 3 points are the same.
    if isequal(vertices_2d(1,:),vertices_2d(2,:)) && isequal(vertices_2d(2,:),vertices_2d(3,:))
        color_fix = (0.33)*vertex_colors(1,:) + (0.33)*vertex_colors(2,:)+(0.33)*vertex_colors(3,:);
        color1 = color_fix;
        color2 = color_fix;
        color3 = color_fix;
    else
        %'Fix' vertex colors if 2 points are the same.
        if isequal(vertices_2d(1,:),vertices_2d(2,:))
            color_fix = 0.5*vertex_colors(1,:) + 0.5*vertex_colors(2,:);
            color1=color_fix;
            color2=color_fix;
        end

        if isequal(vertices_2d(2,:),vertices_2d(3,:))
            color_fix = 0.5*vertex_colors(2,:) + 0.5*vertex_colors(3,:);
            color2=color_fix;
            color3=color_fix;
        end

        if isequal(vertices_2d(1,:),vertices_2d(3,:))
            color_fix = 0.5*vertex_colors(1,:) + 0.5*vertex_colors(3,:);
            color1=color_fix;
            color3=color_fix;
        end
    end
    
    %'Paint' the pixels of the sides before we start. In this case, with
    %linear interpolation
    
    %~~~~~~~~~~~~For side1~~~~~~~~~~~~~~~~
     dim = 1;
    %If dx<dy
    if abs(vertices_2d(1,1)-vertices_2d(2,1))<abs(vertices_2d(1,2)-vertices_2d(2,2))
        dim = 2;
    end
    
    for i=1:length(side1(:,1))
       
       pixel_color = vector_interp(vertices_2d(1,:),vertices_2d(2,:),side1(i,:),color1,color2,dim);
       img(side1(i,2),side1(i,1),:)=pixel_color;
    end
    %~~~~~~~~~~~~For side2~~~~~~~~~~~~~~~~~
    dim = 1;
    %If dx<dy
    if abs(vertices_2d(2,1)-vertices_2d(3,1))<abs(vertices_2d(2,2)-vertices_2d(3,2))
        dim = 2;
    end
    
    for i=1:length(side2(:,1))
       pixel_color = vector_interp(vertices_2d(2,:),vertices_2d(3,:),side2(i,:),color2,color3,dim);
       img(side2(i,2),side2(i,1),:)=pixel_color;
    end
    
    %~~~~~~~~~~~~For side3~~~~~~~~~~~~~~~~~
    dim = 1;
    %If dx<dy
    if abs(vertices_2d(1,1)-vertices_2d(3,1))<abs(vertices_2d(1,2)-vertices_2d(3,2))
        dim = 2;
    end
    
    for i=1:length(side3(:,1))
       pixel_color = vector_interp(vertices_2d(1,:),vertices_2d(3,:),side3(i,:),color1,color3,dim);
       img(side3(i,2),side3(i,1),:)=pixel_color;
    end
    
    %Find scanline boundaries
    ymin = min(vertices_2d(:,2));
    ymax = max(vertices_2d(:,2));
    
    %   For each scanline, find the filling space. To do this, we add to the
    %current scanline (y=c) all the pixels that belong to a side and y = c.
    %   Instead of counting crossings, we have a flag, 'in', that
    %tells us whether we are inside the triangle (not on a line or outside)
    %or not.
    %   Since we have triangles, there can only be 0 or 1 gaps to paint. If
    %there is no gap, the flag empty is 1 or else it is 0.
    %   For each scanline (cur_scan_x), we keep the pixels that belong to 
    %the active lines, by keeping the x value. 
    %   When we find an x that doesn't belong to the scanline, we save the
    %previous as the pixel before the gap (start_x). Then, when we find an x that
    %does belong to the scanline, we save it as the pixel after the gap
    %(end_x).
    %   Finally, we fill the pixels from (y,start_x+1) to (y,end_x-1),
    %interpolating the colors of the pixels (y,start_x+1) and (y,end_x-1).
    
    for i=ymin:ymax
        %~~~Find every x coordinate of the side pixels that belong to the
        %scanline~~~
        rows = find(side_pixels(:,2) == i); %Find the row of every pixel with y = i
        cur_scan_x = transpose(side_pixels(rows,1)); %Keep only the x value of the points found
        cur_scan_x = sort(cur_scan_x); %Sort so that highest values are last

        %~~~Find the inner active points of the scanline~~~
        n = length(cur_scan_x);
        in = 0; %Flag that we are in the triangle
        empty = 1; %Flag that we have null filling space (1 or 2 pixels or horizontal line)
        start_x = -1; %Inner point of active line 1
        end_x = -1; %Inner point of active line 2
        for j = cur_scan_x(1):cur_scan_x(n)
            %If current x is not in scanline
            x_in_scan = not(isempty(find(cur_scan_x == j)));
            %Find start
            if not(x_in_scan) && (in==0) %If i is not in the scan
                start_x = j-1;             %The previous pixel is the start
                in = 1;               %Flag that we are inside the triangle
                empty = 0;            %Flag that filling space is not null
            end
            %Find end
            if x_in_scan && (in == 1) %If i IS in the scan and we are inside the triangle
                end_x = j;
                in = 0;
            end
            
        end
        
        %~~~Color filling space~~~
        
        if empty == 0 %If the filling space is not null
            for k = (start_x+1):(end_x-1)
                color1 = img(i,start_x,:);
                color2 = img(i,end_x,:);
                color = vector_interp([start_x i],[end_x i],[k i],color1,color2,1);
                img(i,k,:)=color;
            end
        end
    end

    result = img;
end