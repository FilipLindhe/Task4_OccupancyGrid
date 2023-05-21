function adjacent = findAdjacent(map,x,Hcosts,qClosed)
    k = 1;
    
    
    



    for i = 1:3
        
        for j = 1:3
        check = 1;
            if ((x(1)-2)+i ~= x(1) || (x(2)-2)+j ~=x(2))
                if map((x(1)-2)+i,(x(2)-2)+j) ~= inf
                    tempX = (x(1)-2)+i;
                    tempY = (x(2)-2)+j;
                    for e = 1:length(qClosed(:,1))
                        
                        if tempX == qClosed(e,1) && tempY == qClosed(e,2)
                            check = 2;
                        end
                        
                    end
                    if check ~= 2

                        if (i == 1 || i == 3) && (j == 1 || j == 3)
                            adjacent(k,1) = tempX;
                            adjacent(k,2) = tempY; 
                            adjacent(k,3) = x(1);
                            adjacent(k,4) = x(2);
                            adjacent(k,5) = Hcosts(x(1)-2+i, x(2)-2+j);
                            adjacent(k,6) = sqrt(2);
                            adjacent(k,7) = adjacent(k,6) + x(7);
                            adjacent(k,8) = adjacent(k,5) + adjacent(k,7);
                            k = k+1;
                        else
                            adjacent(k,1) = tempX;
                            adjacent(k,2) = tempY; 
                            adjacent(k,3) = x(1);
                            adjacent(k,4) = x(2);
                            adjacent(k,5) = Hcosts(x(1)-2+i, x(2)-2+j);
                            adjacent(k,6) = 1;
                            adjacent(k,7) = adjacent(k,6) + x(7);
                            adjacent(k,8) = adjacent(k,5) + adjacent(k,7);
                            k = k+1;
                        end
                    end
                end
            end
        end
    end
    
    if exist("adjacent")
        return
    else
        adjacent = 0;
        return
    end

end