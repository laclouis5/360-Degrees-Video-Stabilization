function [ Theta, Phi ] = getFrame( rotation, angle, ratio )
    
    % parameters
    angleW = angle*pi/180;
    angleH = angleW/ratio;
    
    nbIterations = 1;
    
    intTheta = [-angleW/2, angleW/2];
    intPhi   = [-angleH/2, angleH/2];

    intervTheta = (-nbIterations/2:1:nbIterations/2)*angleW/nbIterations;
    intervPhi = (-nbIterations/2:1:nbIterations/2)*angleH/nbIterations;
    
    R = 1;
    syms phi theta;
    
    % rotation matrix
    a = rotation(1);
    b = rotation(2);
    c = rotation(3);
    
    rot_x = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)];
    rot_y = [cos(b), 0, sin(b); 0, 1, 0; -sin(b), 0, cos(b)];
    rot_z = [cos(c), -sin(c), 0; sin(c), cos(c), 0; 0, 0, 1];

    rot = rot_z*rot_y*rot_x;
    
    %Mem alloc
    x = sym([2, nbIterations + 1]);
    y = sym([2, nbIterations + 1]);
    z = sym([2, nbIterations + 1]);
    
    Theta = sym([2, nbIterations + 1]);
    Phi = sym([2, nbIterations + 1]);
    
    % extractions of the frame
    for index = 1:nbIterations + 1 
        
        [x(1, index), y(1, index), z(1, index), Theta(1, index), Phi(1, index)] = verticalLine(R, theta, phi, intervTheta(index), rot);
        [x(2, index), y(2, index), z(2, index), Theta(2, index), Phi(2, index)] = horizontalLine(R, theta, phi, intervPhi(index), rot);
    end
    
    % show
    figure, hold on;
    for hor = 1:nbIterations + 1
        
        fplot3(x(1, hor), y(1, hor), z(1,  hor), intPhi, 'x');
    end
    
    for ver = 1:nbIterations + 1
        
        fplot3(x(2, ver), y(2, ver), z(2, ver), intTheta, 'x');
    end
end
