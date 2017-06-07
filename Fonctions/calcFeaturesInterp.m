function [ ] = calcFeaturesInterp( video, step )
    
    M = step + 2;
    
    for i = 1:M:video.nbImg - 1
        
        img1 = video.frames{i};
        img2 = video.frames{i + 1};
        
        img1.calcFeatures;
        img2.calcFeatures;
    end
    
    i1 = i + 1;
    
    if i1 < video.nbImg
        
        for j = i1 + 1:video.nbImg
            img = video.frames{j};
            img.calcFeatures;
        end
    end
end

