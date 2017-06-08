%% test edge detection
clear
close all
clc

%% Parameters
videoSize = [540 960];
step = 1;

%% Creation
video = createVideo('/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Stages/Stage_2A/Project/findRotationAndScale/Videos/IMG_6918.mov');

%% Correction
video.corrAngle(step);
video.showAngle;

%% Save
% saveVideo(video);