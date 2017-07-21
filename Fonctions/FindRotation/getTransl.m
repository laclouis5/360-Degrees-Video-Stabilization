function [ tx, ty ] = getTransl( frame1, frame2 )

    pairs = matchFeatures(frame1.features, frame2.features);

    matched1 = frame1.pts(pairs(:, 1), :);
    matched2 = frame2.pts(pairs(:, 2), :);

    [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

    tx = tForm.T(3, 1);
    ty = tForm.T(3, 2);
end
