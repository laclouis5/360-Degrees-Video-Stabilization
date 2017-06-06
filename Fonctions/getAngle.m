function [ angle, scale] = getAngle( img1, img2 )

image1 = rgb2gray(img1);
image2 = rgb2gray(img2);

% Interest point research and matching

pts1 = detectSURFFeatures(image1, 'MetricThreshold', 1000, 'NumOctave', 4, 'NumScaleLevels', 3);
pts2 = detectSURFFeatures(image2, 'MetricThreshold', 1000, 'NumOctave', 4, 'NumScaleLevels', 3);


[feat1, valid1] = extractFeatures(image1, pts1);
[feat2, valid2] = extractFeatures(image2, pts2);

idxPairs = matchFeatures(feat1, feat2);

matched1 = valid1(idxPairs(:, 1), :);
matched2 = valid2(idxPairs(:, 2), :);

[tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

% Angle and scale estimation
S1 = tForm.T(2, 1);
S2 = tForm.T(1, 1);

scale = sqrt(S1*S1 + S2*S2);
angle = atan2(S1, S2)*180/pi;

end

