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
path      = '/Users/laclouis5/Downloads/vid1.mp4';
videoSize = [720, 720*4/3];

sc   = 4;
step = 5;

%% Main
video1 = Vid(path, step, sc, videoSize);

%%
video1.corrAngle('mean');

%% Show
figure, video1.showAngle;
grid minor;
figure, video1.showSumAngle;
grid minor;

%% Save
video1.saveVideo('/Users/laclouis5/Downloads/Out1.mp4');

%% Correct the second one
ratio = 4/3;
def   = 720;
angle = 120;

p   = '/Users/laclouis5/Downloads/Videos_thetaSC/R0010647_er.MP4';
vid = VideoReader(p);

vidF = VideoWriter('/Users/laclouis5/Downloads/vidF', 'MPEG-4');

[x, y, z] = getRectWindow(angle, ratio, def);

open(vidF);

for i = 1:video1.nbImg
    
    [X, Y, Z] = moveWindow(x, y, z, 0, deg2rad(video1.sumAngle(i)), -pi/2);
    [az, el]  = cart2sphPixel(vid.Height, vid.Width, X, Y, Z);
    
    img = getImage(readFrame(vid), az, el);
    
    writeVideo(vidF, img);
end

close(vidF);

%% correction 1st one 
