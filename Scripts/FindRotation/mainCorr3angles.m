% Louis LAC
% Digital stabilization of an on-board camera
% June to August 2017
% 4th year of Engineering studies internship
% Stellenbosch University, South Africa

%%
clear
close all
clc

%% Param
path      = '/Users/laclouis5/Downloads/ThetaSC_Work/videos_Test_Rot/60deg_s.MP4';
ratio     = 4/3;
def       = 720;
videoSize = [def, def*ratio];
angle     = 120;
sc        = 1;
step      = 1;

%% Initialisation
mainVideo = Vid(path);

[x, y, z]    = getRectWindow(angle, ratio, def);
[x1, y1, z1] = moveWindow(x, y, z, 0, 0, -pi/2);
[x2, y2, z2] = moveWindow(x, y, z, 0, -pi/2, 0);

[az1, el1] = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), x, y, z);
[az2, el2] = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), x1, y1, z1);
[az3, el3] = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), x2, y2, z2);

vid1 = VideoWriter('/Users/laclouis5/Downloads/vid1', 'MPEG-4');
vid2 = VideoWriter('/Users/laclouis5/Downloads/vid2', 'MPEG-4');
vid3 = VideoWriter('/Users/laclouis5/Downloads/vid3', 'MPEG-4');

%% main
open(vid1);
open(vid2);
open(vid3);

for i = 1:mainVideo.nbImg
    
    frame = mainVideo.frames{i}.img;
    
    imgS1 = getImage(frame, az1, el1);
    imgS2 = getImage(frame, az2, el2);
    imgS3 = getImage(frame, az3, el3);
    
    writeVideo(vid1, imgS1);
    writeVideo(vid2, imgS2);
    writeVideo(vid3, imgS3);
end

close(vid1);
close(vid2);
close(vid3);

%% Get angle
video1 = Vid('/Users/laclouis5/Downloads/vid1.mp4', step, sc, videoSize);
video2 = Vid('/Users/laclouis5/Downloads/vid2.mp4', step, sc, videoSize);
video3 = Vid('/Users/laclouis5/Downloads/vid3.mp4', step, sc, videoSize);

video1.corrAngle('mean');
video2.corrAngle('mean');
video3.corrAngle('mean');

sumAngle1 = video1.sumAngle;
sumAngle2 = video2.sumAngle;
sumAngle3 = video3.sumAngle;

%% Correction
vidF = VideoWriter('/Users/laclouis5/Downloads/vidF', 'MPEG-4');

open(vidF);

for i = 1:mainVideo.nbImg
    
    [X, Y, Z] = moveWindow(x, y, z, 0, 0, deg2rad(sumAngle3(i)));
    [AZ, EL]  = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), X, Y, Z);
    
    frame = mainVideo.frames{i}.img;
    img  = getImage(frame, AZ, EL);
    
    writeVideo(vidF, img);
end

close(vidF);

%% show
figure, plot(sumAngle1);
figure, plot(sumAngle2);
figure, plot(sumAngle3);