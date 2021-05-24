function cq = affine_transform(cp,transform)
    %get size of input
    [~,wid]=size(cp);
    
    %cp array must be as follows
    %   x   x   x   x
    %   y   y   y   y
    %   z   z   z   z
    
    %Extend so that we can multiply
    cp_extended = [cp;transpose(ones(wid,1))];
    
    %Apply transformation on every point given
    for i = 1:wid
       cq(:,i) = transform.T*cp_extended(:,i); 
    end
    
    %Output only the 3D coordinates
    cq = cq(1:3,:);
    
end