function [ image ] = addRectangle( image, X, Y, width, height, color, border )
    
    rectW = X:X + width - 1;
    rectH = Y:Y + height - 1;
    
    
    
    for i = 1:1:3
        
        image(Y:Y + border, rectW, i) = color(i);
        image(Y + height - border:Y + height, rectW, i) = color(i);
        image(rectH, X:X + border, i) = color(i);
        image(rectH, X + width - border:X + width, i) = color(i);
    end
end