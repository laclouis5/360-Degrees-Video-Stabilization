function [ ] = calcFeaturesLinear( video )
    
    M = video.step + 2;
    
    for i = 1:M:video.nbImg - 1
        
        img1 = video.framesSc{i};
        img2 = video.framesSc{i + 1};
        
        img1.calcFeatures;
        img2.calcFeatures;
        
        video.nbFeat = video.nbFeat + 2;
    end
    
    i1 = i + 1;
    
    if i1 < video.nbImg
        
        for j = i1 + 1:video.nbImg
            
            img = video.framesSc{j};
            img.calcFeatures;
            
            video.nbFeat = video.nbFeat + 1;
        end
    end
end

