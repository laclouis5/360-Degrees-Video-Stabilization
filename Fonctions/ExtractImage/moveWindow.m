function [ xR, yR, zR ] = moveWindow( X, Y, Z, angleX, angleY, angleZ )

    a = angleX;
    b = angleY;
    c = angleZ;
    
    xyz = {X; Y; Z};

    rot_x = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)];
    rot_y = [cos(b), 0, sin(b); 0, 1, 0; -sin(b), 0, cos(b)];
    rot_z = [cos(c), -sin(c), 0; sin(c), cos(c), 0; 0, 0, 1];

    rot_xyz = rot_z*rot_y*rot_x;

    xR = zeros(size(X));
    yR = zeros(size(Y));
    zR = zeros(size(Z));

    for i = 1:3     

        xR = xR + rot_xyz(1, i).*xyz{i};
        yR = yR + rot_xyz(2, i).*xyz{i};
        zR = zR + rot_xyz(3, i).*xyz{i};
    end
end

