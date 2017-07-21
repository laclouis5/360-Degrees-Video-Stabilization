clear
close all
clc

path = '/Users/laclouis5/Downloads/Mon film.mp4';

VidIn   = VideoReader(path);
nbFrame = ceil(VidIn.Duration*VidIn.FrameRate);

vid1 = VideoWriter('/Users/laclouis5/Downloads/VidOut1', 'MPEG-4');
vid2 = VideoWriter('/Users/laclouis5/Downloads/VidOut2', 'MPEG-4');

open(vid1);
open(vid2);

i = 1;

while hasFrame(VidIn)
    
    avancement = i/nbFrame*100
    
    frame = readFrame(VidIn);

    frame = frame(1:960, 1:1920, :);
    
    frame1 = imrotate(frame(:, 1:960, :), - 90);
    frame2 = imrotate(frame(:, 961:1920, :), 90);
    
    writeVideo(vid1, frame1);
    writeVideo(vid2, frame2);
    
    i = i + 1;
    
end

close(vid1);
close(vid2);
