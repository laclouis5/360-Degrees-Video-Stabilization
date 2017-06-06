%% test
clear
close all

angle = 0;
tx = 0;
ty = 0;

for i = 0:6
    
    img1 = imread(sprintf('Images/rotationX8FullSize/IMG_%d.JPG', 6748 + i));
    img2 = imread(sprintf('Images/rotationX8FullSize/IMG_%d.JPG', 6748 + i + 1));

    angle = getAngle(img1, img2) + angle;
    tform = calcTformInv(angle);

    imgS   = corRot(img2, tform, size(img1));
    imgTmp = corRot(img2, tform, [1080 1920]);
    imgE   = cropImg(img1, [1080 1920]);

    [tx, ty] = getTransl(imgTmp, imgE);
    
    imgF = corTransl(imgS, tx, ty, [1080 1920]);
    % figure, imshow(imgS);
    % figure, imshow(imgTmp);
    figure, imshow(imgF);
    
end