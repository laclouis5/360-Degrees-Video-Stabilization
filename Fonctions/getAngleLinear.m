function [ ] = getAngleLinear( video )
     
    M = video.step + 2;
    
    for i = 1:M:video.nbImg - 1
                
        frame1 = video.framesSc{i};
        frame2 = video.framesSc{i + 1};

        angle = getAngle(frame1, frame2);
        
        video.angles(i + 1) = angle;
            
        if i ~= 1
            
            a = (video.angles(i + 1) - video.angles(i + 1 - M))/M;
            b = video.angles(i + 1) - a*(i + 1);
                
            for k = i - video.step:i
                
                video.angles(k) = a*k + b;
                video.sumAngle(k) = video.sumAngle(k - 1) + video.angles(k);
            end
        end
        
        video.sumAngle(i + 1) = video.sumAngle(i) + video.angles(i + 1);
    end
    
    i1 = i + 1;
    
    if i1 < video.nbImg
        
        for j = i1:video.nbImg - 1
            
            frame1 = video.framesSc{j};
            frame2 = video.framesSc{j + 1};
            
            angle = getAngle(frame1, frame2);
        
            video.angles(j + 1) = angle;
            video.sumAngle(j + 1) = video.sumAngle(j) + angle;
        end
    end
end

