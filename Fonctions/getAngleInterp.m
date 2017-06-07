function [ angle ] = getAngleInterp( video, step )
     
    M = step + 2;
    
    % nbPairs = floor(video.nbImg/(M + 1));
    
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
        video.sumAngle(i + 1) = video.sumAngle(i) + angle;
    end
    
    for j = 1:M:video.nbImg - 1
        
    end
end

