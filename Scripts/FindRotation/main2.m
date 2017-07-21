clear
close all
clc

%%
path  = 'Images/360degreesImages/canyon.jpg';
image = imread(path);

%%
border = 10;
color  = [255 0 0];   %R
color1 = [0 255 0];   %G
color2 = [0 0 255];   %B
color3 = [255 255 0]; %Y

ratio  = 4/3;
angleW = 60;
angleH = angleW/ratio;
ratioH = angleH/180;
ratioW = angleW/360;

[h, w, p] = size(image);

center = [floor(w/2), floor(h/2)];
left   = [floor(w/4), floor(h/2)];
right  = [floor(w*3/4), floor(h/2)];
back   = [floor(w), floor(h/2)];

hImage = floor(ratioH*h);
wImage = floor(ratioW*w);

coordInit  = center - [floor(wImage/2), floor(hImage/2)];
coordInit1 = left - [floor(wImage/2), floor(hImage/2)];
coordInit2 = right - [floor(wImage/2), floor(hImage/2)];
coordInit3 = back - [floor(wImage/2), floor(hImage/2)];

%%
imageF  = extractImage(image, coordInit(1), coordInit(2), wImage, hImage);
imageF1 = extractImage(image, coordInit1(1), coordInit1(2), wImage, hImage);
imageF2 = extractImage(image, coordInit2(1), coordInit2(2), wImage, hImage);
imageF3 = extractImage(image, coordInit3(1), coordInit3(2), wImage, hImage);

image = addRectangle(image, coordInit(1), coordInit(2), wImage, hImage, color, border);
image = addRectangle(image, coordInit1(1), coordInit1(2), wImage, hImage, color1, border);
image = addRectangle(image, coordInit2(1), coordInit2(2), wImage, hImage, color2, border);
image = addRectangle(image, coordInit3(1), coordInit3(2), wImage, hImage, color3, border);

%%
figure, imshow(image);
figure, imshow(imageF);
figure, imshow(imageF1);
figure, imshow(imageF2);
figure, imshow(imageF3);