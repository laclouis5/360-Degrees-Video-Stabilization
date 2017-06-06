function [ tx, ty ] = getTransl( img1, img2 )

image1 = rgb2gray(img1);
image2 = rgb2gray(img2);

% Interest point research and matching
pts1 = detectSURFFeatures(image1);
pts2 = detectSURFFeatures(image2);

[feat1, valid1] = extractFeatures(image1, pts1);
[feat2, valid2] = extractFeatures(image2, pts2);

idxPairs = matchFeatures(feat1, feat2);

matched1 = valid1(idxPairs(:, 1), :);
matched2 = valid2(idxPairs(:, 2), :);

[tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');

tx = tForm.T(3, 1);
ty = tForm.T(3, 2);

end
