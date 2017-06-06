%%
clear
close all
clc

%% Param images
imgNumber = 4;
imgFolder = 'Images/rotationX8FullSize';
imgName = 'IMG_';
imgStartNum = 6748;
imgSize = size(imread(sprintf('%s/%s%d.JPG',imgFolder, imgName, imgStartNum)));

scale = 0.25;

%% Param. sortie
videoSize = [1080 1920];

%% Init
imgFile  = cell(imgNumber, 1);
mat      = cell(imgNumber, 1);
angle    = zeros(imgNumber, 1);
sumAngle = zeros(imgNumber, 1);
tForm    = cell(imgNumber, 1);
transl   = zeros(2, imgNumber);


%% Process
for i = 1:imgNumber
    
    imgFile{i} = sprintf('%s/%s%d.JPG',imgFolder, imgName, imgStartNum + i - 1);
    
end

%% Init
angle(1)     = 0;
sumAngle(1)  = 0;
mat{1}       = [1 0 0; 0 1 0; 0 0 1];
transl(:, 1) = 0;

for j = 1:imgNumber - 1
    
    img1 = rescale(imread(imgFile{j}), scale);
    img2 = rescale(imread(imgFile{j + 1}), scale);
    
    [angle(j + 1), ~] = getAngle(img1, img2);
    sumAngle(j + 1)   = sumAngle(j) + angle(j + 1);
    tForm{j + 1} = calcTformInv(sumAngle(j + 1));
    
    imgE   = cropImg(img1, videoSize);
    imgTMP = corRot(img2, tForm{j + 1}, videoSize); 
    imgS   = corRot(img2, tForm{j + 1}, imgSize);
    
    [tx, ty] = getTransl(imgTMP, imgE);
    transl(1, j + 1) = tx;
    transl(2, j + 1) = ty;
    
    imgF = corTransl(imgS, tx, ty, videoSize);
    
    figure, imshow(imgF);
    
end

figure,
subplot(211), plot(angle), grid minor;
subplot(212), plot(sumAngle), grid minor;
