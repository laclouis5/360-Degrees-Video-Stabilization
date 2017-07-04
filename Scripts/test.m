clc
clear
close all

%%
t = 100;
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

% lim1 = floor((t + 1)/2 - (t + 1)/2/pi*theta2);
% lim2 = floor(lim1 + (t + 1)/2/pi*angleW);
% 
% lim3 = floor((t + 1)/2 - (t + 1)/pi*phi2);
% lim4 = floor(lim3 + (t + 1)/pi*angleH);

%%
[theta, phi, r] = cart2sph(x, y, z);

Theta = theta.*((theta > theta1) & (theta < theta2) & (phi > phi1) & (phi < phi2));
Phi = phi.*((theta > theta1) & (theta < theta2) & (phi > phi1) & (phi < phi2));
R = r.*((theta > theta1) & (theta < theta2) & (phi > phi1) & (phi < phi2));

[X, Y, Z] = sph2cart(Theta, Phi, R);

% X = X(lim3:lim4, lim1:lim2);
% Y = Y(lim3:lim4, lim1:lim2);
% Z = Z(lim3:lim4, lim1:lim2);

h = surf(X, Y, Z);
rotate(h, [0, 1, 0], 25);
rotate(h, [1, 0, 0], 5);
axis equal;