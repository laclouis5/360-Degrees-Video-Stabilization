clear
close all
clc

N = 100;

r     = ones(1, N);
theta = zeros(1, N);
phi   = -pi/4:pi/2/N:pi/4 - 1/N;

a = pi/4;
b = pi/4;
c = 0;

rot_x = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)];
rot_y = [cos(b), 0, sin(b); 0, 1, 0; -sin(b), 0, cos(b)];
rot_z = [cos(c), -cos(c), 0; sin(c), cos(c), 0; 0, 0, 1];

xyz = [r.*cos(theta).*cos(phi); r.*sin(theta).*cos(phi); r.*sin(phi)];
xyzRot = rot_y*rot_x*xyz;

[X, Y, Z] = sphere(100);

figure, plot3(xyz(1, :), xyz(2, :), xyz(3, :), 'x');
axis equal;
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid minor;
plot3(X, Y, Z);

plot3(xyzRot(1, :), xyzRot(2, :), xyzRot(3, :), 'x');