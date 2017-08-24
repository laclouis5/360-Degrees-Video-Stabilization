clear
close all
clc

%%
path = '/Users/laclouis5/Downloads/ThetaSC_Work/Photos_ThetaSC/ESL_FLAT.JPG';

image = imread(path);

[h, w, ~] = size(image);

angle = 70;
ratio = 4/3;
def   = 750;

[x, y, z]    = getRectWindow(angle, ratio, def);
[x1, y1, z1] = moveWindow(x, y, z, pi/2, pi/2 - pi/6, pi/2 + pi/2);

[az, el] = cart2sphPixel(h, w, x1, y1, z1);

%%

imgS = getImage(image, az, el);
imwrite(imgS, 'cederberg.jpg');

%%
% imgC = colorImage(image, x, y, z);
imgC = colorImage(image, x1, y1, z1);

figure, imshow(imgC);
figure, imshow(imgS);
% figure, imshow(imgS1);

[X, Y, Z] = sphere(100);
figure, surf(x1, y1, z1, 'EdgeColor', 'none');
axis equal, xlabel('X'), ylabel('Y'), zlabel('Z'), grid minor, hold on;
plot3(X, Y, Z, 'LineStyle', ':', 'Color', [0.4 0.4 0.4]);
