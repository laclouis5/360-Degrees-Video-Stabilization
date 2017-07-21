clear
close all
clc

path = '/Users/laclouis5/Downloads/film2.mp4';

VidIn   = VideoReader(path);
nbFrame = ceil(VidIn.Duration*VidIn.FrameRate);

vid1 = VideoWriter('/Users/laclouis5/Downloads/VidOut', 'MPEG-4');

open(vid1);

i = 1;

while hasFrame(VidIn)
    
    avancement = i/nbFrame*100
    
    frame = readFrame(VidIn);

    frame = frame(60:1019, :, :);  
    
    writeVideo(vid1, frame);
    
    i = i + 1;
    
end

close(vid1);
