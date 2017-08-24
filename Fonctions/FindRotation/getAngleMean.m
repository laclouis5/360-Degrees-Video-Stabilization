function [ ] = getAngleMean( video )

    stp = video.step;

    [i1, f1, i2, f2] = video.calcLimits2;

    for i = i1:stp:f1

        frame1 = video.framesSc{i};
        frame2 = video.framesSc{i + stp};

        [angle, status] = getAngle(frame1, frame2);
        
        for j = 1:stp

            if (status == 0)
                
                video.angles(i + j) = angle/stp;
            end
            
            
            if (status == 1 || status == 2)
                
                video.angles(i + j) = video.angles(i + j - 1);
            end
            
            % video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle/stp;
        end
    end

    
    if f2 >= i2
        for k = i2:1:f2

            frame1 = video.framesSc{k};
            frame2 = video.framesSc{k + 1};

            angle = getAngle(frame1, frame2);

            video.angles(k + 1) = angle;
            
            % video.sumAngle(k + 1) = video.sumAngle(k) + angle;
        end
    end
    
    % filtering
    % video.angles = medfilt1(video.angles, 9);
    video.angles = hampel(video.angles);
    
    for l = 2:1:video.nbImg
        
        video.sumAngle(l) = video.sumAngle(l - 1) + video.angles(l);
    end
end

