function qOpenTemp = checkForDoublettes(qOpenTemp,adjacent)
    
    
    
    for i = 1:length(adjacent(:,1))
        doubletteCheck = 1;
        for j = 1:length(qOpenTemp(:,1))
            if adjacent(i,1) == qOpenTemp(j,1) && adjacent(i,2) == qOpenTemp(j,2) 
                    if adjacent(i,8) < qOpenTemp(j,8)
                        qOpenTemp(j,:) = adjacent(i,:);
                    end
                    doubletteCheck = 2;
                    break;
     
            end
        end
        if doubletteCheck == 1
            qOpenTemp(end+1,:) = adjacent(i,:);
        end
        
        
    end


end