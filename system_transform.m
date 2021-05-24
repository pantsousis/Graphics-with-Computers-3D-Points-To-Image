function dp = system_transform(cp,transform)
    
    %get size of input
    [~,wid]=size(cp);
    %Extend cp
    cp = [cp;ones(1,wid)];
    %cp array must be as follows
    %   x   x   x   x
    %   y   y   y   y
    %   z   z   z   z
    
    %Initialize dp array
    dp = zeros(4,wid);
    
    %Inverse transformation table
    L = transform.T;
    %Apply transformation on every point
    for i = 1:wid
       dp(:,i) = L*cp(:,i); 
    end
    
    dp = dp(1:3,:);
end