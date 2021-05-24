function img = render_object(p, F,C,M,N,H,W,w, cv, clookat, cup)
    
    p = transpose(p);
    %Call project_cam_ku so that we can calculate points from CCS
    [P_cam,D_cam] = project_cam_ku(w,cv,clookat,cup,p);
    P_cam = transpose(P_cam);
    D_cam = transpose(D_cam);
    %Get the pixel coordinates
    P_rast = rasterize(P_cam,M,N,H,W);
    
    %~~~~~Extend image~~~~~
    %This is done so that we don't get negative pixel values
    min_coord = min(P_rast);
    
    if min_coord(1) < 1
       P_rast(:,1) = P_rast(:,1) - min_coord(1) + 1;
    end
    
    if min_coord(2) < 1
       P_rast(:,2) = P_rast(:,2) - min_coord(2) + 1;
    end
    
    %render extended image
    img = render(P_rast, F, C, D_cam, 'gouraud');
    %output cropped image
    img = img(1:M,1:N,:);
    
end