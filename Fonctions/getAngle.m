function [ angle ] = getAngle( frame1, frame2 )

    pairs = matchFeatures(frame1.features, frame2.features);

    matched1 = frame1.pts(pairs(:, 1), :);
    matched2 = frame2.pts(pairs(:, 2), :);

    [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

    S1 = tForm.T(2, 1);
    S2 = tForm.T(1, 1);

    angle = atan2(S1, S2)*180/pi;
end