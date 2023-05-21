function costs = heuristicCalc(goal,map)

   
   for i = 1:length(map)
       for j = 1:width(map)

       distance = distanceCalc(goal(1),goal(2),i,j);
       %distanceRound = round(distance);
       costs(i,j) = distance;
       end
   end
   


end