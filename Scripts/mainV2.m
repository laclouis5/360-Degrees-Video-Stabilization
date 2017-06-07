%% test edge detection
clear
close all
clc
   

video = Vid;
vidIn = VideoReader('/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Stages/Stage_2A/Project/findRotationAndScale/Videos/IMG_6918.mov');
vidOut = VideoWriter('Out.mp4', 'MPEG-4');
videoSize = [540 960];

step = 1;

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