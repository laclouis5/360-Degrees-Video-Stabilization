function [ X, Y, Z, h, w ] = getRectWindowCartCoord( angle, ratio, precision )

    t = precision;
    [x, y, z] = sphere(t);
    
    angleW = angle*pi/180;
    angleH = angleW/ratio;

    theta1 = -angleW/2;
    theta2 = angleW/2;

    phi1 = -angleH/2;
    phi2 = angleH/2;

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
   [h, w, ~] = size(R);
end

