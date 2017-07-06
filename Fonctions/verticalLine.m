function [ x, y, z ] = verticalLine( theta, rotation )

    % parameters
    r = 1;
    syms phi
    
    x = r.*cos(theta).*cos(phi);
    y = r.*sin(theta).*cos(phi);
    z = r.*sin(phi);
    
    
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

    x = symfun(xyz(1), phi);
    y = symfun(xyz(2), phi);
    z = symfun(xyz(3), phi);
end
