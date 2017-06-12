function [ angle ] = getAngleInterp( video )
     
    M = video.step + 2;
    
    for i = 1:M:video.nbImg - 1
                
        frame1 = video.frames{i};
        frame2 = video.frames{i + 1};

        pairs = matchFeatures(frame1.features, frame2.features);

        matched1 = frame1.pts(pairs(:, 1), :);
        matched2 = frame2.pts(pairs(:, 2), :);

        [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

        S1 = tForm.T(2, 1);
        S2 = tForm.T(1, 1);

        angle = atan2(S1, S2)*180/pi;
        
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
            
            frame1 = video.frames{j};
            frame2 = video.frames{j + 1};

            pairs = matchFeatures(frame1.features, frame2.features);

            matched1 = frame1.pts(pairs(:, 1), :);
            matched2 = frame2.pts(pairs(:, 2), :);

            [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

            S1 = tForm.T(2, 1);
            S2 = tForm.T(1, 1);

            angle = atan2(S1, S2)*180/pi;
        
            video.angles(j + 1) = angle;
            video.sumAngle(j + 1) = video.sumAngle(j) + angle;
        end
    end
end

