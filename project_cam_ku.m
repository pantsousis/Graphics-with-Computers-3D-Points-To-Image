function [P,D] = project_cam_ku(w,c_center,c_look,c_up,p)
    
    %center = cv
    %look = ck
    %up = cu
    
    %calculate Camera Coordinate System base
    z_cam = (c_look-c_center)/norm((c_look-c_center));
    
    t = c_up - dot(c_up,z_cam)*z_cam;
    
    y_cam = t/norm(t);
    
    x_cam = cross(y_cam,z_cam);
    
    %Call project_cam
    [P,D] = project_cam(w,c_center,x_cam,y_cam,z_cam,p);
    
end