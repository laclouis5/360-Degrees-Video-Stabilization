function [ image ] = addRectangle( image, X, Y, width, height, color, border )

    [~, w, p] = size(image);
    
    rectH = Y:Y + height - 1;
    
    if X > w
        
        X = X - w;
    end
    
    if X + width - 1 <= w
    
        for i = 1:p
            
            rectW = X:X + width - 1;

            image(Y:Y + border, rectW, i) = color(i);
            image(Y + height - border:Y + height, rectW, i) = color(i);
            
            image(rectH, X:X + border, i) = color(i);
            image(rectH, X + width - border:X + width, i) = color(i);
        end
    end
    
    if X + width - 1 > w
        
        lim1 = w;
        lim2 = X + width - 1 - w;
        
        for i = 1:p
            
            rectW1 = X:lim1;
            rectW2 = 1:lim2;

            image(Y:Y + border, rectW1, i) = color(i);
            image(Y:Y + border, rectW2, i) = color(i);

            image(Y + height - border:Y + height, rectW1, i) = color(i);
            image(Y + height - border:Y + height, rectW2, i) = color(i);
            
            if X + border <= w
                
                image(rectH, X:X + border, i) = color(i);
            end
            
            if X + border > w
                
                image(rectH, X:w, i) = color(i);
            end
            
            if lim2 - border >= 1
                
                image(rectH, lim2 - border:lim2, i) = color(i);
            end
            
            if lim2 - border < 1
                
                image(rectH, 1:lim2, i) = color(i);
            end
        end
    end
end