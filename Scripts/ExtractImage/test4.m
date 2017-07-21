%%
clear
clc
close all

%%
path  = 'Images/360degreesImages/canyon.jpg';
image = imread(path, 'jpg');

[hImage, wImage, dImage] = size(image);

%%
ratio = 4/3;
angle = 60;

N = 2;

az  = 0;
el  = 0;
rot = 0;

%%
angleW = angle*pi/180;
angleH = angleW/ratio;

intT = [-angleW/2, angleW/2];
intP = [-angleH/2, angleH/2];

%%
[theta, phi] = getFrame([rot, el, az], angle, ratio);

xlabel('X'), ylabel('Y'), zlabel('Z'), grid minor, axis equal;
axis([-1 1 -1 1 -1 1]);
[X, Y, Z] = sphere(100);
surf(X, Y, Z, 'EdgeColor', 'none');

%%
% syms var;
% z = 0*var;
% 
% figure, hold on;
% 
% fplot3(phi(1, 1), theta(1, 1), z, intT);
% fplot3(phi(1, N), theta(1, N), z, intT);
% fplot3(phi(2, 1), theta(2, 1), z, intP);
% fplot3(phi(2, N), theta(2, N), z, intP);
% 
% axis equal;