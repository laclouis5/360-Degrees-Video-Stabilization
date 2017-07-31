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
path      = '/Users/laclouis5/Downloads/Videos_thetaSC/IMG_7276.MP4';
ratio     = 16/9;
def       = 720;
videoSize = [def, def*ratio];
angle     = 120;
sc        = 1;
step      = 2;

%% Initialisation
mainVideo = Vid(path);

vid1 = VideoWriter('/Users/laclouis5/Downloads/vid1', 'MPEG-4');

[x, y, z]    = getRectWindow(angle, ratio, def);
[x1, y1, z1] = moveWindow(x, y, z, 0, 0, -pi/2);

[az, el]   = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), x, y, z);
[az1, el1] = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), x1, y1, z1);

%% Read the video and extract frame
open(vid1);
for i = 1:mainVideo.nbImg
    
    frame = mainVideo.frames{i}.img;
    imgS  = getImage(frame, az, el);
    imgS1 = getImage(frame, az1, el1);
    
    writeVideo(vid1, imgS);
end
close(vid1);

%% Get the 1st angle
video1 = Vid('/Users/laclouis5/Downloads/vid1.mp4', step, sc, videoSize);
video1.corrAngle('mean');

sumAngle1 = video1.sumAngle;

%% Correct the second one
vidF = VideoWriter('/Users/laclouis5/Downloads/vidF', 'MPEG-4');

[x, y, z] = getRectWindow(angle, ratio, def);

open(vidF);
for i = 1:video1.nbImg
    
    [X, Y, Z] = moveWindow(x, y, z, 0, deg2rad(video1.sumAngle(i)), -pi/2);
    [az, el]  = cart2sphPixel(mainVideo.definition(1), mainVideo.definition(2), X, Y, Z);
    
    frame = mainVideo.frames{i}.img;
    img = getImage(frame, az, el);
    
    writeVideo(vidF, img);
end
close(vidF);

%%
video1 = Vid('/Users/laclouis5/Downloads/vidF.mp4', step, sc, videoSize);
video1.corrAngle('mean');

sumAngle2 = video1.sumAngle;

%% Correct the second one
vid  = VideoReader(path);
vidF = VideoWriter('/Users/laclouis5/Downloads/vidF2', 'MPEG-4');

[x, y, z] = getRectWindow(60, ratio, def);

open(vidF);
for i = 1:video1.nbImg
    
    [X, Y, Z] = moveWindow(x, y, z, deg2rad(sumAngle2(i)), deg2rad(sumAngle1(i)), -pi/2);
    [az, el]  = cart2sphPixel(vid.Height, vid.Width, X, Y, Z);
    
    img = getImage(readFrame(vid), az, el);
    
    writeVideo(vidF, img);
end
close(vidF);
