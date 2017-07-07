clc
clear
close all

path  = 'Images/360degreesImages/stellies.jpeg';
image = imread(path);

[hImage, wImage, dImage] = size(image);

a = 0;
b = -90;
c = 0;

%%
coordAz = (0:1:wImage - 1)*2*pi/wImage;
coordEl = (0:1:hImage - 1)*pi/hImage;

[X, Y] = meshgrid(coordAz, coordEl);

%%
theta = X - floor(wImage/2)/wImage*2*pi; % between [-pi, pi]
phi   = - Y + floor(hImage/2)/hImage*pi;
r     = ones(hImage, wImage);
r(2304/2-100:2304/2 + 100, 4608/2 - 100:4608/2+100) = 0;

%%
[x, y, z] = sph2cart(theta, phi, r);

h = surf(x, y, z, 'EdgeColor', 'none');

rotate(h, [0, 1, 0], b, [0, 0, 0]);

x1 = h.XData;
y1 = h.YData;
z1 = h.ZData;

figure, surf(x1, y1, z1, 'EdgeColor', 'none');