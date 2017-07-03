clear
close all
clc

%%
path = 'Images/360degreesImages/canyon.jpg';
image = imread(path);

%%
l = 50;
[x, y, z] = sphere(l);
a = 0;
b = 0;
c = pi/4;

figure, surf(x, y, z, flipud(image), 'FaceColor', 'texturemap', 'EdgeColor', 'none');

%%
figure, h = warp(x, y, z, flipud(image));
xlabel('X');
ylabel('Y');
zlabel('Z');

x1 = h.XData;
y1 = h.YData;
z1 = h.ZData;


rotX = [1, 0     , 0      ;
        0, cos(a), -sin(a);
        0, sin(a), cos(a) ];  
   
rotY = [cos(b) , 0, sin(b);
        0      , 1, 0     ;
        -sin(b), 0, cos(b)];
   
rotZ = [cos(c), -sin(c), 0;
        sin(c), cos(c) , 0;
        0     , 0      , 1];

A = cat(3, x1, y1, z1);

for i = 1:1:l+1
    for j = 1:1:l+1
        
        vect = A(i, j, :);
        vect2 = rotZ*rotY*rotX*permute(vect, [3, 1, 2]);
        
        B(i, j, :) = vect2;
    end
end

x1 = B(:, :, 1);
y1 = B(:, :, 2);
z1 = B(:, :, 3);

figure, h2 = warp(x1, y1, z1, flipud(image));

xlabel('X');
ylabel('Y');
zlabel('Z');

x2 = h2.XData;
y2 = h2.YData;
z2 = h2.ZData;

%%
x3 = x2(:, 1:floor(l/2) + 1);
y3 = y2(:, 1:floor(l/2) + 1);
z3 = z2(:, 1:floor(l/2) + 1);

figure, h3 = warp(x3, y3, z3, flipud(image));

xlabel('X');
ylabel('Y');
zlabel('Z');

x3 = h3.XData;
y3 = h3.YData;
z3 = h3.ZData;

%%
% outImage = equirectangularToStereographic(path);
% figure, imshow(outImage);