function [ x, y, z, az, el ] = horizontalLine( R, theta, phi, intP, rot )
  
    % parameters
    phi = 0.*phi;
    
    x = R.*cos(theta).*cos(phi);
    y = R.*sin(theta).*cos(phi);
    z = R.*sin(phi);
    
    % first rotation on y-axis
    angle = -intP;
    rot_y = [cos(angle), 0, sin(angle); 0, 1, 0; -sin(angle), 0, cos(angle)];
    xyz   = rot_y*[x; y; z];
    
    x = xyz(1);
    y = xyz(2);
    z = xyz(3);
    
    % extraction of x, y, and z functions
    xyz = rot*[x; y; z];
    
    x = xyz(1);
    y = xyz(2);
    z = xyz(3);
    
    az = asin(z);
    el = atan(y./x);
end
