function [ angle, status ] = getAngle( frame1, frame2 )

    pairs = matchFeatures(frame1.features, frame2.features);

    matched1 = frame1.pts(pairs(:, 1), :);
    matched2 = frame2.pts(pairs(:, 2), :);
    
    [tForm, ~, ~, status] = estimateGeometricTransform(matched1, matched2, 'similarity');
    
    if (status == 0)
        
        S1 = tForm.T(2, 1);
        S2 = tForm.T(1, 1);

        angle = 1.13*atan2(S1, S2)*180/pi;
    end
    
    if (status == 1 || status == 2)
        
        angle = 0;
end