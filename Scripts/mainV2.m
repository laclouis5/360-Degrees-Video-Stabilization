%% test edge detection
clear
close all
clc
   
%% 
video = Vid;
vidIn = VideoReader('videos/IMG_6915.MOV');
vidOut = VideoWriter('Out.mp4', 'MPEG-4');
videoSize = [540 960];

samplingRate = 1;

while hasFrame(vidIn)
    
    frame = readFrame(vidIn);
    
    img = Img(frame);
    video.addImg(img);
end

video.corrAngle(samplingRate);
video.showAngle;

%%
open(vidOut);

for i = 1:1:video.nbImg
    video.frames{i}.img = cropImg(video.frames{i}.img, videoSize);
    writeVideo(vidOut, video.frames{i}.img); 
end

close(vidOut);
