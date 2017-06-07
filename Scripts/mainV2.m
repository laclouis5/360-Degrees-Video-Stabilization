%% test edge detection
clear
close all
clc
   

video = Vid;
vidIn = VideoReader('/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Stages/Stage_2A/Project/findRotationAndScale/Videos/IMG_6918.mov');
vidOut = VideoWriter('Out.mp4', 'MPEG-4');
videoSize = [540 960];

step = 5;

%%
while hasFrame(vidIn)
    
    frame = readFrame(vidIn);
    
    img = Img(frame);
    video.addImg(img);
end

%%
video.corrAngle(step);
video.showAngle;

%%
open(vidOut);

for i = 1:1:video.nbImg
    video.frames{i}.img = cropImg(video.frames{i}.img, videoSize);
    writeVideo(vidOut, video.frames{i}.img); 
end

close(vidOut);

%% test
step = 2;
nb = 232;
N = nb - 1;

            nbMatch1 = floor(N/step);
            nbMatch2 = N - step*nbMatch1;
            
            i1 = 1;
            f1 = step*nbMatch1 + i1;
            
            i2 = f1 + 1;
            f2 = nbMatch2 + f1;