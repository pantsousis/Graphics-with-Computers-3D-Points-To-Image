function P_rast = rasterize(P,M,N,H,W)
        
    %Pixels Per Inch in x and y direction
    l_N = N/W;
    l_M = M/H;
    
    %Calculate and approximate pixel values
    x_rast = round((P(:,1)+H/2)*l_N+1);
    y_rast = round((P(:,2)+W/2)*l_M+1);
    
    P_rast = [x_rast y_rast];
end