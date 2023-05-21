clc; 
clear; 
close all;
%filename = "MapFiles\fr101.carmen.gfs.log";
%filename2 = "MapFiles\fr101.carmen.log";
filename = "MapFiles\Mitc\csail.corrected.log";
filename2 = "MapFiles\Mitc\csail-oldcarmen.log";
[sensorVal] = ReadData(filename,filename2);


%% Run from here to not run ReadData function since it's slow depending on the file
tic;
resolution = 5; % 1 grid is (1/resolution)m;
xSize = 100*resolution; %Gridsize X 
ySize = 100*resolution; %Gridsize Y each gridcell is 1M

robotPose = [sensorVal(:,sensorVal(1)+2),sensorVal(:,sensorVal(1)+3),sensorVal(:,sensorVal(1)+4)];
sensorReadings = sensorVal(:,2:sensorVal(1)+1);
robotPose(:,1:2) = robotPose(:,1:2) +50;

sensorReadings = sensorReadings*resolution;
robotPose(:,1:2) = robotPose(:,1:2)*resolution;



sensorDis = 5*resolution;

startAngle = -pi/2;

laserWidth = 1; % Size of "laser"

anglesTemp = (pi/2)/180;

for i = 1:360
    angles(i) = (-pi/2)+(anglesTemp*i);
end


figure;
plot(sensorVal(:,362),sensorVal(:,363)); %% Plots the path of the robot


map = 0.5 *ones(xSize,ySize); %% Initalizes the map to 0.5 since we have no information about the map.
 
L0 = log(map ./ (1-map)); %Initial Logmap
L = L0; %"Previous"Map


for i = 1:height(robotPose)
    
    currentPose = robotPose(i,:);
    currentReading = sensorReadings(i,:);

    inverseModel = InverseLaserModel(currentPose,currentReading,angles,sensorDis,xSize,ySize,laserWidth,resolution);
    LogInverse = log(inverseModel ./ (1-inverseModel));
    L = LogInverse + L - L0;
    
    map = exp(L) ./ (1 + exp(L));
    
    
    
    figure(1)
    imshow(map);
    drawnow;


end
toc;
%%
tic;
testmap = map;
testmap(testmap >= 0.5) = inf;
testmap(testmap < 0.5) = 0;

start = robotPose(1,1:2);
goal = robotPose(end,1:2);

goal = [285 450];

start = round(start);
goal = round(goal);


 Z = testmap == inf;
 Z = Z';
 figure(1)
 clf;
 image(Z);
 colormap colorcube;
 grid on
 grid minor
 axis xy
 axis([0.5 500 0.5 500]);
 sPos = start;
 gPos = [goal(2) goal(1)];
 text(sPos(2)-0.4,sPos(1)-1.4,'$$x_0$$','fontsize',15, 'interpreter', 'latex');
 text(gPos(2)-0.4,gPos(1)-1.4,'$$x_g$$','fontsize',15,'interpreter','latex');
 hold on


mapKnown = testmap;
mapNew = ones(size(testmap));
Hcosts = heuristicCalc(goal,mapNew);
%Hcosts = zeros(size(map));

finalPath = [];
k = 1;

final = aStar(mapNew, Hcosts, start, goal);

path = findPath(start,final);
i = length(path(:,1));
while( i ~= 1)
    
    mapNew = Scanner(mapNew,mapKnown,path,i);
    if mapNew(path(i-1,1),path(i-1,2)) == inf

        finalPath = [finalPath; flip(path(i:end,:))];

        final = aStar(mapNew, Hcosts, [path(i,1) path(i,2)], goal);
        path = findPath([path(i,1) path(i,2)],final);
        i = length(path(:,1));
        toc;
        
    end
    
    i = i - 1;
end
finalPath = [finalPath; flip(path(i:end,:))];



plot(finalPath(:,1),finalPath(:,2),'yellow');



