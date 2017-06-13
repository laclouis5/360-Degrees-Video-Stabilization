function [ imgS ] = cropImg( imgE, sizeCrop )

    [H, W, ~] = size(imgE);
    h         = sizeCrop(1);
    w         = sizeCrop(2);
    
    XStart = floor((W - w)/2);
    YStart = floor((H - h)/2);
    
    imgS = imcrop(imgE, [XStart, YStart, w - 1, h - 1]);
    
end

