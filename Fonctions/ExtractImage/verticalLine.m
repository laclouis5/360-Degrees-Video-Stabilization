function [ x, y, z, az, el ] = verticalLine( R, theta, phi, intT, rot )


    % parameters
    theta = 0.*theta+ intT;
    
    x = R.*cos(theta).*cos(phi);
    y = R.*sin(theta).*cos(phi);
    z = R.*sin(phi);
    
    % extraction of x, y, and z functions
    xyz = rot*[x; y; z];
    
    x = xyz(1);
    y = xyz(2);
    z = xyz(3);
    
    az = asin(z);
    el = atan(y./x);
end
