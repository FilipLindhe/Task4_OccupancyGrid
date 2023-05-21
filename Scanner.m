function [newMap] = Scanner(map,mapKnown,x,i)
    
    SDX = 2; %%Scanner dimension X SDX*2+1
    SDY = 2; %%Scanner dimension Y SDY*2+1
    map(x(i,1)-SDX:x(i,1)+SDX,x(i,2)-SDY:x(i,2)+SDY) = mapKnown(x(i,1)-SDX:x(i,1)+SDX,x(i,2)-SDY:x(i,2)+SDY);
        

    newMap = map;

end