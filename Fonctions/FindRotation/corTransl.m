function [ imgS ] = corTransl( imgE, tx, ty, sizeCrop )

    [H, W, ~] = size(imgE);
    h = sizeCrop(1);
    w = sizeCrop(2);
    
    XStart = floor((W - w)/2 - tx);
    YStart = floor((H - h)/2 - ty);
    
    imgS = imcrop(imgE, [XStart, YStart, w - 1, h - 1]);
    
end
