function [sensorVal] = ReadData(filename1,filename2)
%Odometry readings exists in sensorVal, altough be it less resolution (
%Fewer samples)
tic;
data = tdfread(filename1);
fns = fieldnames(data);
dataParams = tdfread(filename2);
fns2 = fieldnames(dataParams);

% for i = 1:170
%     if dataParams.(fns2{1})(i,1:24) == "PARAM localize_max_range"
%         MaxRange = dataParams.(fns2{1})(i,26:28);
%         break;        
%     end
% 
% end
% if ~exist("MaxRange")
%     MaxRange = 50;
% end
k = 1;
j = 1;

for i = 1:height(data.(fns{1}))

    %if data.(fns{1})(i,1) == "O"
       % odom{k,1} = data.(fns{1})(i,5:end);
      %  k = k + 1;
    if data.(fns{1})(i,1) == "F"
        sensor{j,1} = data.(fns{1})(i,7:end);
        %sensorToOdometry(j) = i-1;
        j = j + 1;
    end

end
%odomNew = [];
%odomTemp = cell2mat(odom);
sensorTemp = cell2mat(sensor);

% for i = 1:height(odomTemp)
%     To = 1;
%     From = 2;
%     k = 1;
%     for j = 2:length(odomTemp(i,:))
%         if odomTemp(i,j) == " "           
%             To = j-1;
%             if isempty(str2num(odomTemp(i,From:To))) == 1 
%                 break;
%             end            
%             odomNew(i,k) = str2num(odomTemp(i,From:To));
%             k = k + 1;                         
%             From = j + 1;           
%         end      
%     end
% end
for i = 1:height(sensorTemp)
    To = 1;
    From = 2;
    k = 1;
    for j = 2:length(sensorTemp(i,:))        
        if sensorTemp(i,j) == " "           
            To = j-1;
            if isempty(str2num(sensorTemp(i,From:To))) == 1 
                break;
            end           
            sensorNew(i,k) = str2num(sensorTemp(i,From:To));
            k = k + 1;                            
            From = j + 1;                       
        end                 
    end
end
%odometry = odomNew;
sensorVal = sensorNew;
%sensorToOdometry = sensorToOdometry.';
toc;
end