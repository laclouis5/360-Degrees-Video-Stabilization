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

sc   = 4;
step = 5;

%% Main
tic
video1 = Vid(path, step, sc, videoSize);
toc

tic
video1.corrAngle('mean');
toc

%% Show
figure, video1.showAngle;
grid minor;
figure, video1.showSumAngle;
grid minor;
figure, video1.showTranslX;
grid minor;
figure, video1.showTranslY;
grid minor;
figure, video1.showSumTranslX;
grid minor;
figure, video1.showSumTranslY;
grid minor;

%% Save
tic
video1.saveVideo('Out1.mp4');
toc
