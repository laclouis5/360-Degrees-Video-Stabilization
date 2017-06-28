clear
close all
clc

%%
path = 'Images/360degreesImages/canyon.jpg';
image = imread(path);

%%
[x, y, z] = sphere(100);
figure, warp(x, y, z, flipud(image));

%%
landareas = shaperead('landareas.shp','UseGeoCoords',true);
axesm('eqdcylin', 'Frame', 'on', 'Grid', 'on');
geoshow(landareas,'FaceColor',[1 1 .5],'EdgeColor',[.6 .6 .6]);

%%
outImage = equirectangularToStereographic(path);
imshow(outImage);