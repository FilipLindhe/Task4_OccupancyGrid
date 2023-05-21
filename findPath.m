function path = findPath(start,final)
    
i = 2;
x = 1;
y = 1;

parent_x = final(end,3); %% Set the first parent node
parent_y = final(end,4);

path(1,1) = final(end,1);
path(1,2) = final(end,2);


    while x ~= start(1,1) || y ~= start(1,2)
        
        temp = all(final(:,1:2) == [parent_x,parent_y],2);
        index = find(temp == 1);
        parent_x = final(index,3);
        parent_y = final(index,4);
    
    
        path(i,1) = final(index,1);
        path(i,2) = final(index,2);
    
        x = path(i,1);
        y = path(i,2);
    
        
    
        
        i = i+1;
    
    end


end