clear
close all
clc

%%
N = 100;

r     = 1;
theta = 0;
phi   = -pi/4:pi/2/N:pi/4 - 1/N;

a = pi/2;
b = pi/4;
c = 0;

rot_x = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)];
rot_y = [cos(b), 0, sin(b); 0, 1, 0; -sin(b), 0, cos(b)];
rot_z = [cos(c), -sin(c), 0; sin(c), cos(c), 0; 0, 0, 1];


[X, Y, Z] = sphere(100);

%%
x = r.*cos(theta).*cos(phi);
y = r.*sin(theta).*cos(phi);
z = r.*sin(phi);

xyzRot = rot_y*rot_x*[x; y; z];
xR = xyzRot(1, :);
yR = xyzRot(2, :);
zR = xyzRot(3, :);

figure, plot3(x, y, z, 'x');
axis equal, xlabel('X'), ylabel('Y'), zlabel('Z'), grid minor, hold on;
plot3(X, Y, Z, 'LineStyle', ':', 'Color', [0.4 0.4 0.4]);
plot3(xR, yR, zR, 'x');