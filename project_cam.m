function [P,D] = project_cam(w,cv,cx,cy,cz,p)

    %Rotation of camera coordinate system - transposed so that we can get
    %the points translated
    R_T = transpose([cx cy cz]);
    
    %Inverse transformation matrix
    L_inv=[R_T (-R_T*cv);zeros(1,3) 1];
    
    %Create transformation matrix object
    trans = transformation_matrix;
    trans.T = L_inv;
    
    %Apply transformation to find coordinates in Camera Coordinate System
    ccs = system_transform(p,trans);
   
    %Save zq (z after transformation) for depth
    D = ccs(3,:);
    
    %Calculate 2D coordinates - front symmetrical curtain
    P(1,:) = -w*ccs(1,:)./ccs(3,:); %pg72: xq =w*xp/zp 
    P(2,:) = -w*ccs(2,:)./ccs(3,:); %pg72: zq =w*yp/zp
end