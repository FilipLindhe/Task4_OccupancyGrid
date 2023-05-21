function map = InverseLaserModel(currentPose,currentReading,sensorAngles,sensorMaxDis, xSize, ySize, laserWidth, resolution)
    mapTemp = zeros(xSize,ySize);
    for i = 1:xSize
        for j = 1:ySize
            xGridDistance = (i-currentPose(1))^2;
            yGridDistance = (j-currentPose(2))^2;
            distanceGrid = sqrt(xGridDistance + yGridDistance); %%Distance to grid from current Pose
            
            robotAngle = currentPose(3);
            angleToGrid = atan2(j-currentPose(2), i-currentPose(1));
            angleToGrid = mod(angleToGrid - robotAngle + pi, 2*pi) - pi;

            absAngle = abs(angleToGrid-sensorAngles); 
            [min_absAngle,index] = min(absAngle); %% Gets the angle which is closest to the grid Angle.

            if  min_absAngle > laserWidth/2 || distanceGrid > min(sensorMaxDis,currentReading(index) + resolution/2) 
                mapTemp(i,j) = 0.5; %% If the grid is outside the sensors fov/range, set it to 0.5 since we don't have any information about the grid. 
            elseif currentReading(index) < sensorMaxDis && abs(distanceGrid-currentReading(index)) < resolution/2
                mapTemp(i,j) = 0.7; %% If the grid is inside the sensors range and the distance between the grid and the sensor value is smaller than w/2 .
            elseif min_absAngle < laserWidth/2 && distanceGrid < currentReading(index)
                mapTemp(i,j) = 0.2; %% If the grid is inside the sensors fov/range, but located "before" the sensor, set it to 0.3 
            end
        end
    end
    map = mapTemp;
end