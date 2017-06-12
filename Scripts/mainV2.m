%% test edge detection
clear
close all
clc

%% Init
path = 'Videos/IMG_6918.mov';
videoSize = [540 960];
step = 4;
sc = 4;

%% Main
tic
video = Vid(path, step, sc, videoSize);
toc

tic
video.corrAngle('linear');
toc

video.showAngle;

% figure, plot(t), grid minor, xlabel('scale'), ylabel('time (s)'), title('Execution time');

%% Save
tic
video.saveVideo;
toc