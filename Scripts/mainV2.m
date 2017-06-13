% Louis LAC
% Digital stabilization of an on-board camera
% June to August 2017
% 4th year of Engineering studies internship
% Stellenbosch University, South Africa

%% test edge detection
clear
close all
clc

%% Init
path      = 'Videos/IMG_6918.mov';
videoSize = [540 960];

sc    = 4;
step1 = 10;
step2 = 6;
step3 = 1;

%% Main
tic
video1 = Vid(path, step1, sc, videoSize);
video2 = Vid(path, step2, sc, videoSize);
video3 = Vid(path, step3, sc, videoSize);
toc

tic
video1.corrAngle('linear');
video2.corrAngle('mean');
video3.corrAngle('mean');
toc

figure, video1.showAngle;
hold on;
video2.showAngle;
video3.showAngle;
grid minor;

figure, video1.showSumAngle;
hold on;
video2.showSumAngle;
video3.showSumAngle;
grid minor;

%% Save
tic
video1.saveVideo('Out1.mp4');
video2.saveVideo('Out2.mp4');
video3.saveVideo('Out3.mp4');
toc