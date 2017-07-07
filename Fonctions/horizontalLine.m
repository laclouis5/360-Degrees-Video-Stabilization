function [ x, y, z, r, az, el ] = horizontalLine( phi, rotation )

    % parameters
    R = 1;
    syms theta;

    x = R.*cos(theta).*cos(phi);
    y = R.*sin(theta).*cos(phi);
    z = R.*sin(phi);
    
    % rotation matrix
    a = rotation(1);
    b = rotation(2);
    c = rotation(3);
    
    rot_x = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)];
    rot_y = [cos(b), 0, sin(b); 0, 1, 0; -sin(b), 0, cos(b)];
    rot_z = [cos(c), -sin(c), 0; sin(c), cos(c), 0; 0, 0, 1];

    rot = rot_z*rot_y*rot_x;
    
    % extraction of x, y, and z functions
    xyz = rot*[x; y; z];
    
    x = xyz(1);
    y = xyz(2);
    z = xyz(3);
    
    r  = sqrt(x.*x + y.*y + z.*z);
    az = asin(z./R);
    el = atan(y./x);

    x = symfun(x, theta);
    y = symfun(y, theta);
    z = symfun(z, theta);
    
    r  = symfun(r, theta);
    az = symfun(az, theta);
    el = symfun(el, theta);
end