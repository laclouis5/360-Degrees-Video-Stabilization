function [ imgS ] = rescale( imgE, scale )

    div = floor(1/scale);
    
    imgS = imgE(1:div:end, 1:div:end, :);
    
end

