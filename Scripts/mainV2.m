%% test edge detection
clear
close all
clc

%% Parameters
videoSize = [540 960];
step = 6;

%% Creation
video = createVideo('Videos/IMG_6918.mov');

%% Correction
video.corrAngle(step);
video.showAngle;

%% Save
saveVideo(video, videoSize);