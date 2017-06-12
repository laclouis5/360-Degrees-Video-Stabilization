function [ imgS ] = rescale( imgE, div )
    
    imgS = imgE(1:div:end, 1:div:end, :);
    
end

