clear
close all
clc

%%
path = '/Users/laclouis5/Downloads/Videos_thetaSC/IMG_7276.MP4';
mainVideo = VideoReader(path);

vid1 = VideoWriter('/Users/laclouis5/Downloads/vid1', 'MPEG-4');

[x, y, z]    = getRectWindow(angle, ratio, def);
[x1, y1, z1] = moveWindow(x, y, z, 0, 0, -pi/2);

[az, el]   = cart2sphPixel(mainVideo.Height, mainVideo.Width, x, y, z);
[az1, el1] = cart2sphPixel(mainVideo.Height, mainVideo.Width, x1, y1, z1);

%%
open(vid1);
while hasFrame(mainVideo)
    
    frame = readFrame(mainVideo);
    imgS  = getImage(frame, az, el);
    imgS1 = getImage(frame, az1, el1);
   
    writeVideo(vid1, imgS);
end
close(vid1);

%%
% imgC = colorImage(image, x, y, z);
% imgC = colorImage(imgC, x1, y1, z1);

% figure, imshow(imgC);
% figure, imshow(imgS);
% figure, imshow(imgS1);

% [X, Y, Z] = sphere(100);
% figure, surf(x, y, z, 'EdgeColor', 'none');
% axis equal, xlabel('X'), ylabel('Y'), zlabel('Z'), grid minor, hold on;
% plot3(X, Y, Z, 'LineStyle', ':', 'Color', [0.4 0.4 0.4]);
