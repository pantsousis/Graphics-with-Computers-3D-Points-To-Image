function result = sort_faces_by_depth(faces,depth)
    %This function simply sorts the faces by depth, from largest to
    %smallest depth. It returns a sorted faces array.
    faces_depth=zeros(length(faces),1);
    %Calculate each triangle depth and store in faces_depth
    for i=1:length(faces)
        faces_depth(i) = 1/3*sum(depth(faces(i,:)));
    end
    
    %sort faces_depth
    [faces_depth,I] = sort(faces_depth,'descend');
    %Rearrange faces based on the sorted indices of faces_depth
    result = faces(I,:);
    
end