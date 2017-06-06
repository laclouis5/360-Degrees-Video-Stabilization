%% test
clear
close all

%% 
image = imread('cameraman.tif');
theta = 0*pi/180;
scale = 1;

mat = [scale*cos(theta) -scale*sin(theta) 0; scale*sin(theta) scale*cos(theta) 0; 0 0 1];
tform = affine2d(mat);
imageS = imwarp(image, tform);

imageS = cropImg(imageS, [50 100]);

figure, imshow(image);
figure, imshow(imageS);