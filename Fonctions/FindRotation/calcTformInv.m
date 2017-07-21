function [ tForm ] = calcTformInv( angle )

    theta = angle*pi/180;
    
    mat = [cos(theta) -sin(theta) 0; ...
        sin(theta) cos(theta) 0; 0 0 1];
    
    tForm = affine2d(mat);
    Tinv = tForm.invert.T;
    tForm.T = Tinv;

end

