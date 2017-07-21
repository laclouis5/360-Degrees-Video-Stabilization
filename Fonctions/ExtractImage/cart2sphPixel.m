function [ az, el ] = cart2sphPixel(hImage, wImage, X, Y, Z )
    
    d1 = (wImage - 1)/2/pi;
    d2 = (hImage - 1)/pi;
    
    [az, el] = cart2sph(X, Y, Z);

    az = floor(az*d1 + wImage/2 + 0.5);
    el = hImage - floor(el*d2 + hImage/2 + 0.5) + 1;
end

