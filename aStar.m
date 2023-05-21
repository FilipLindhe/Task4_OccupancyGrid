function [final , Distance] = aStar(map, Hcosts, start, goal)

   % Final is a vector containing all points to travel
   % Map is logical map where 1 is obstacle, and 0 is free
   % costs is same size as map but with costs in each "cell"
   % Start is vector (xInit,yInit)
   % Goal is vector (xGoal,yGoal)

    %OPEN LIST FORMAT
    %--------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
    %--------------------------------------------------------------------------
    %EXPANDED ARRAY FORMAT
    %--------------------------------
    %|X val |Y val ||h(n) |g(n)|f(n)|
   
   maxLength = length(map)*width(map);

   qOpen(1,1) = start(1);
   qOpen(1,2) = start(2);
   qOpen(1,3) = start(1);
   qOpen(1,4) = start(2);
   qOpen(1,5) = Hcosts(qOpen(1,1),qOpen(1,2));
   qOpen(1,6) = 0;
   qOpen(1,7) =  qOpen(1,6);
   qOpen(1,8) =  qOpen(1,7) + qOpen(1,5);

   qClosed(1,:) = qOpen(1,:);
   
   

   distances(1) =  0;
   
   
   x = qOpen(1,:);
   k = 1;

    
   while x(1) ~= goal(1) || x(2) ~= goal(2)
        
        
       

        x = qOpen(1,:);
        
        
        adjacent = findAdjacent(map,x,Hcosts,qClosed); %Finds all adjacent nodes
        
        
        qOpenTemp = qOpen(2:end,:); 
        if adjacent(1) ~= 0
            
            qOpenTemp = checkForDoublettes(qOpenTemp,adjacent);
            
            qOpen = sortrows(qOpenTemp(1:end,:),8,'ascend');    %Sort adjacent nodes based on total cost to travel
            if k == 2
                qClosed(end+1,:) = x; %Adds the node to the closedqueue since it's the shortest distance to travel
            end
            k = 2;
        elseif adjacent == 0 %%Could not find any adjacent nodes that i don't have in the open Queue
            qOpen = qOpenTemp(1:end,:);
            qOpen = sortrows(qOpen(1:end,:),8,'ascend');
        end
             
   end
   

   final = qClosed;



end