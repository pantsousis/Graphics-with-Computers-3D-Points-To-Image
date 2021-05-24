classdef transformation_matrix < handle
    
    properties
        %Initialize transformation matrix
        T = eye(4);
       
    end
    
    methods 
        
        function rotate(obj,angle,u)
            %Create Rodrigues matrix based on input
            ux = u(1);
            uy = u(2);
            uz = u(3);
            c1 = cos(angle);
            c2 = sin(angle);
            c3 = 1-cos(angle);
            
            R = [
                 c3*ux^2+c1 c3*ux*uy-c2*uz c3*ux*uz+c2*uy;...
                 c3*uy*ux+c2*uz c3*uy^2+c1 c3*uy*uz-c2*ux;...
                 c3*uz*ux-c2*uy c3*uz*uy+c2*ux c3*uz^2+c1 ...
                ];
            %Update transformation table
            obj.T(1:3,1:3)=R;
            
        end
        
        function translate(obj,t)
            %update transformation table based on input
            obj.T(1,4) = t(1);
            obj.T(2,4) = t(2);
            obj.T(3,4) = t(3);
            
        end
        
    end
end