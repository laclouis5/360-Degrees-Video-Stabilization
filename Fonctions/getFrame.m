function [ x, y, z ] = getFrame( rotation, angle, ratio )
    
    % parameters
    angleW = angle*pi/180;
    angleH = angleW/ratio;

    intervTheta = [- angleW/2, angleW/2];
    intervPhi   = [- angleH/2, angleH/2];
    
    
    % extractions of the frame
    [vlX, vlY, vlZ] = verticalLine(intervTheta(1), rotation);
    [vrX, vrY, vrZ] = verticalLine(intervTheta(2), rotation);
    [hlX, hlY, hlZ] = horizontalLine(intervPhi(1), rotation);
    [hrX, hrY, hrZ] = horizontalLine(intervPhi(2), rotation);
    
    x = {vlX; vrX; hlX; hrX};
    y = {vlY; vrY; hlY; hrY};
    z = {vlZ; vrZ; hlZ; hrZ};
    
    % show
    figure, hold on;
    for i = 1:2
        
        fplot3(x{i}, y{i}, z{i}, intervPhi, 'x');
    end
    
    for i = 3:4
        
        fplot3(x{i}, y{i}, z{i}, intervTheta, 'x');
    end
end
