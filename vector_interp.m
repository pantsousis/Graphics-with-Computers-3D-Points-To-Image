function result = vector_interp(p1,p2,a,V1,V2,dim)
    %In case the two pixels are the same, the resulting color is half of
    %each color.
    if (p1(1,1)==p2(1,1)) && (p1(1,2)==p2(1,2))
        result = 0.5*V1 + 0.5*V2;
    else
        %Each 'per' is the distance of point 'a' from point 'p1' or 'p2', expressed as a
        %fraction of the total distance (p2-p1), projected on the x or y axis
        per1_x = (p1(1)-a(1)) / (p1(1)-p2(1));
        per2_x = (p2(1)-a(1)) / (p2(1)-p1(1));
        per1_y = (p1(2)-a(2)) / (p1(2)-p2(2));
        per2_y = (p2(2)-a(2)) / (p2(2)-p1(2));

        %Cases of x and y linear interpolation. The closest the point 'a' is to
        %point 'p1', the lower the percentage is. Therefore, (1-per1_x)
        %expresses the percentage of the 3D value of a that 'a' must inherit from
        %'p1'. This applies to 'p2' and the y axis aswell.
        if dim == 1
            result = V1 * (1-per1_x) + V2 * (1-per2_x);
        elseif dim == 2
            result = V1 * (1-per1_y) + V2 * (1-per2_y);
        end
    end
end