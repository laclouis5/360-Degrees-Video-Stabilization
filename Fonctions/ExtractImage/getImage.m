function [ imgS ] = getImage( imgE, az, el )
    
    [hNewImage, wNewImage, ~] = size(az);
    
    az = reshape(az, [1, wNewImage*hNewImage]);
    el = reshape(el, [1, wNewImage*hNewImage]);
    
    imgS = impixel(imgE, az, el);
    imgS = permute(imgS, [1 3 2]);
    imgS = reshape(imgS, [hNewImage, wNewImage, 3]);
    imgS = imgS(end:-1:1, :, :);
    imgS = uint8(imgS);
end

