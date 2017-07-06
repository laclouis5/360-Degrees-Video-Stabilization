%%
clear
clc
close all

%%
path  = 'Images/360degreesImages/canyon.jpg';
image = imread(path);

[hImage, wImage, dImage] = size(image);

%%
ratio = 4/3;
angle = 60;

az  = 0;
el  = pi/4;
rot = pi/4;

%%
[x, y, z] = getFrame([rot, el, az], angle, ratio);
% [x, y, z] = verticalLine(0, [0, 0, 0]);

xlabel('X'), ylabel('Y'), zlabel('Z'), grid minor, axis equal;
axis([-1 1 -1 1 -1 1]);
[X, Y, Z] = sphere(100);
surf(X, Y, Z, 'EdgeColor', 'none');
