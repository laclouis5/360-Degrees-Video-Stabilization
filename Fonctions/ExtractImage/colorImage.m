function [ imgS ] = colorImage( imgE, X, Y, Z )

    [hImage, wImage, ~]       = size(imgE);
    [hNewImage, wNewImage, ~] = size(X);
    
    d1 = (wImage - 1)/2/pi;
    d2 = (hImage - 1)/pi;
    
    [az, el] = cart2sph(X, Y, Z);

    az = floor(az*d1 + wImage/2 + 0.5);
    el = hImage - floor(el*d2 + hImage/2 + 0.5) + 1;
    
    imgS = imgE;
    
    for i = 1:hNewImage
        
        for j = 1:wNewImage

            imgS(el(hNewImage - i + 1, j), az(hNewImage - i + 1, j), :) = [255, 0, 0];
        end
    end
    
    imgS = uint8(imgS);
end

