function result = render(vertices_2d,faces,vertex_colors,depth,renderer)
    
    img = ones(1200,1200,3);

    %Sort by depth
    faces_sorted = sort_faces_by_depth(faces,depth);

    if strcmp(renderer,'flat')
        
        for i=1:length(faces)

            points(1,:) = vertices_2d(faces_sorted(i,1),:);
            points(2,:) = vertices_2d(faces_sorted(i,2),:);
            points(3,:) = vertices_2d(faces_sorted(i,3),:);

            colors(1,:) = vertex_colors(faces_sorted(i,1),:);
            colors(2,:) = vertex_colors(faces_sorted(i,2),:);
            colors(3,:) = vertex_colors(faces_sorted(i,3),:);

            img = paint_triangle_flat(img,points,colors);

        end
        
    elseif strcmp(renderer,'gouraud')
        
        for i=1:length(faces)
    
            points(1,:) = vertices_2d(faces_sorted(i,1),:);
            points(2,:) = vertices_2d(faces_sorted(i,2),:);
            points(3,:) = vertices_2d(faces_sorted(i,3),:);

            colors(1,:) = vertex_colors(faces_sorted(i,1),:);
            colors(2,:) = vertex_colors(faces_sorted(i,2),:);
            colors(3,:) = vertex_colors(faces_sorted(i,3),:);

            img = paint_triangle_gouraud(img,points,colors);

        end
        
    else
        fprintf('Wrong input of renderer. Please enter ''flat'' or ''gouraud''\n');
    end
    
    result = img;
    
end