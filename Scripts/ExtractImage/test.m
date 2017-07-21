clc
clear
close all

%%
path  = '/Users/laclouis5/Downloads/Photos_ThetaSC/ESL_FLAT.JPG';
image = imread(path, 'jpeg');

[hImage, wImage, dImage] = size(image);

ratio = 4/3;
angle = 60;

rotation  = 0;
azimuth   = 0;
elevation = pi/4;

rotation2  = 0;
azimuth2   = 90;
elevation2 = pi/4;

d1 = (wImage - 1)/2/pi;
d2 = (hImage - 1)/pi;

%%
[X, Y, Z, hNewImage, wNewImage] = getRectWindowCartCoord(angle, ratio, 2500);

%% rotation
H = surface(X, Y, Z, 'EdgeColor', 'none');

rotate(H, [1, 0, 0], rotation, [0, 0, 0]); % x-axis
rotate(H, [0, 1, 0], elevation, [0, 0, 0]); % y-axis
rotate(H, [0, 0, 1], azimuth, [0, 0, 0]); % z-axis
axis equal;

H2 = surface(X, Y, Z, 'EdgeColor', 'none');

rotate(H2, [1, 0, 0], rotation2, [0, 0, 0]); % x-axis
rotate(H2, [0, 1, 0], elevation2, [0, 0, 0]); % y-axis
rotate(H2, [0, 0, 1], azimuth2, [0, 0, 0]); % z-axis i
axis equal;

%% reconstruction

X1 = H.XData;
Y1 = H.YData;
Z1 = H.ZData;

[AZ1, EL1, R1] = cart2sph(X1, Y1, Z1);

AZ1 = floor(AZ1*d1 + wImage/2 + 0.5);
EL1 = floor(EL1*d2 + hImage/2 + 0.5);

X2 = H2.XData;
Y2 = H2.YData;
Z2 = H2.ZData;

[AZ2, EL2, R2] = cart2sph(X2, Y2, Z2);

AZ2 = floor(AZ2*d1 + wImage/2 + 0.5);
EL2 = floor(EL2*d2 + hImage/2 + 0.5);

%% show
imageFace = zeros(hNewImage, wNewImage, 3);
imageSide = zeros(hNewImage, wNewImage, 3);

for i = 1:hNewImage
    for j = 1:wNewImage
        
        imageFace(i, j, :) = image(EL1(i, j), AZ1(i, j), :);
        imageSide(i, j, :) = image(EL2(i, j), AZ2(i, j), :);
        
        image(EL1(i, j), AZ1(i, j), :) = [255, 0, 0];
        image(EL2(i, j), AZ2(i, j), :) = [255, 0, 0];
    end
end

figure, imshow(image);   
figure, imshow(uint8(imageFace));
figure, imshow(uint8(imageSide));