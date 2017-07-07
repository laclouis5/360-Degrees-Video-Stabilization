clc
clear
close all

%%
path  = 'Images/360degreesImages/stellies.jpeg';
image = imread(path);

[hImage, wImage, dImage] = size(image);

t = 2700;
[x, y, z] = sphere(t);

azimuth = 0;
elevation = 0;

ratio = 4/3;

angleW = 60*pi/180;
angleH = angleW/ratio;

theta1 = azimuth - angleW/2;
theta2 = azimuth + angleW/2;

phi1 = elevation - angleH/2;
phi2 = elevation + angleH/2;

d1 = wImage/2/pi;
d2 = hImage/pi;

%%
[theta, phi, r] = cart2sph(x, y, z);

theta = theta(1:2:end, :);
phi   = phi(1:2:end, :);

mask = (theta > theta1) & (theta < theta2) & (phi > phi1) & (phi < phi2);

[row, col] = find(mask);
limT1      = col(1);
limT2      = col(end);
limP1      = row(1);
limP2      = row(end);

Theta = theta(limP1:limP2, limT1:limT2);
Phi   = phi(limP1:limP2, limT1:limT2);
R     = r(limP1:limP2, limT1:limT2);

[X, Y, Z] = sph2cart(Theta, Phi, R);

H = surf(X, Y, Z);
rotate(H, [1, 0, 0], 0, [0, 0, 0]); % x-axis
rotate(H, [0, 1, 0], -90, [0, 0, 0]); % y-axis
rotate(H, [0, 0, 1], 0, [0, 0, 0]); % y-axis
axis equal;

X1 = H.XData;
Y1 = H.YData;
Z1 = H.ZData;

[AZ1, EL1, R1] = cart2sph(X1, Y1, Z1);

AZ2 = ceil(AZ1*d1 + wImage/2);
EL2 = ceil(EL1*d2 + hImage/2);

hNewImage = limP2 - limP1 + 1;
wNewImage = limT2 - limT1 + 1;
dNewImage = dImage;

imageF = zeros(hNewImage, wNewImage, dImage);

for i = 1:hNewImage
    for j = 1:wNewImage
        
        imageF(i, j, :) = image(EL2(i, j), AZ2(i, j), :);
    end
end

for i = 1:hNewImage
    for j = 1:wNewImage
        
        image(EL2(i, j), AZ2(i, j), :) = [255 0 0];
    end
end

% for j = 1:wNewImage
%     
%     for k = 1:20
%         image(EL2(k, j), AZ2(k, j), :) = [255 0 0];
%         image(EL2(end - k + 1, j), AZ2(end - k + 1, j), :) = [0 0 255];
%     end
% end
% 
% for i = 1:hNewImage
%     
%     for k = 1:20
%         image(EL2(i, k), AZ2(i, k), :) = [255 255 0];
%         image(EL2(i, end - k + 1), AZ2(i, end - k + 1), :) = [0 255 255];
%     end
% end

figure, imshow(image);   
figure, imshow(uint8(imageF));