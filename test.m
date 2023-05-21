clc; clear; close all;

load scansAndPoses.mat
length(scans) == length(poses);


occMap = buildMap(scans,poses,10,19.2);


figure
show(occMap)
title('Occupancy Map of Garage')