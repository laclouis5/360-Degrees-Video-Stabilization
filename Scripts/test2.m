clc
clear
close all

%%
path  = 'Images/360degreesImages/canyon.jpg';
image = imread(path);

[hImage, wImage, dImage] = size(image);

%%
N = 100;

r = ones(1, N);
theta = zeros(1, N);
phi = -pi/4:pi/2/N:pi/4 - 1/N;

alpha = 20;

C1 = r.*sin(theta);
C2 = r.*cos(theta);

r_y     = sqrt(C1.^2 + C2.^2);
theta_y = acos((C2.*cos(alpha) - C1.*sin(alpha).*cos(phi))./(r_y));
phi_y   = atan(C1.*sin(phi)./(C1.*cos(alpha).*cos(phi) + C2.*sin(alpha)));

[x, y, z] = sph2cart(theta, phi, r);
[x1, y1, z1] = sph2cart(theta_y, phi_y, r_y);

[X, Y, Z] = sphere(100);

figure, plot3(x, y, z, 'x');
axis equal;
grid minor;
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(x1, y1, z1, 'x');
plot3(X, Y, Z);

%%
N = 100;
r = ones(1, N);
theta = zeros(1, N);
phi = -pi/4:pi/2/N:pi/4 - 1/N;

alpha = 20;

rot_y = [cos(alpha), 0, sin(alpha); 0, 1, 0; -sin(alpha), 0, cos(alpha)];

xyz = [r.*sin(theta).*cos(phi); r.*sin(theta).*sin(phi); r.*cos(theta)];
xyzRotY = rot_y*xyz;
xyz = xyz';

figure, fsurf(xyz(1), xyz(2), xyz(3));