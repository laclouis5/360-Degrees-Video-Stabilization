function [ X, Y, Z ] = getRectWindow( angle, ratio, def )

    N = def;
    M = def*ratio;

    angleW = angle*pi/180;
    angleH = angleW/ratio;

    theta1 = -angleW/2;
    theta2 = angleW/2;

    phi1 = -angleH/2;
    phi2 = angleH/2;

    theta = theta1:(theta2 - theta1)/(M - 1):theta2;
    phi   = phi1:(phi2 - phi1)/(N - 1):phi2;

    [T, P] = meshgrid(theta, phi);

    X = cos(T).*cos(P);
    Y = sin(T).*cos(P);
    Z = sin(P);
end

