%%
clear
close all
clc

%% Param
path      = '/Users/laclouis5/Downloads/Videos_South_Africa/ThetaSC_Perso/IMG_7507.MP4';
ratio     = 4/3;
def       = 720;
videoSize = [def, def*ratio];
angle     = 100;

%% Init

video = VideoReader(path);
nbImg = video.Duration*video.frameRate;

Angle1 = zeros(1, floor(nbImg));
Angle2 = zeros(1, floor(nbImg));
Angle3 = zeros(1, floor(nbImg));

videoOut = VideoWriter('/Users/laclouis5/Downloads/videoOut.mp4', 'MPEG-4');

[x1, y1, z1] = getRectWindow(angle, ratio, def);
[x2, y2, z2] = moveWindow(x1, y1, z1, 0, 0, -pi/2);
[x3, y3, z3] = moveWindow(x1, y1, z1, 0, -pi/2, 0);

[az1, el1] = cart2sphPixel(video.Height, video.Width, x1, y1, z1);
[az2, el2] = cart2sphPixel(video.Height, video.Width, x2, y2, z2);
[az3, el3] = cart2sphPixel(video.Height, video.Width, x3, y3, z3);

%% Main algo
open(videoOut);

frame1 = readFrame(video);

for i = 1:1:nbImg - 1
    
    percent = floor(100*i/nbImg);
    
    clc;
    text = ['In progress... ', num2str(percent), ' %'];
    disp(text);

    
    % intit.
    frame2 = readFrame(video);
    
    imgS11 = getImage(frame1, az1, el1);
    imgS12 = getImage(frame1, az2, el2);
    imgS13 = getImage(frame1, az3, el3);
    
    imgS21 = getImage(frame2, az1, el1);
    imgS22 = getImage(frame2, az2, el2);
    imgS23 = getImage(frame2, az3, el3);

    % save image
    writeVideo(videoOut, imgS11);
    
    if (i == (nbImg - 1))
        
        writeVideo(videoOut, imgS21);
    end
    
    % calc pts
    ptsS11 = detectSURFFeatures(rgb2gray(imgS11));
    ptsS12 = detectSURFFeatures(rgb2gray(imgS12));
    ptsS13 = detectSURFFeatures(rgb2gray(imgS13));
    
    ptsS21 = detectSURFFeatures(rgb2gray(imgS21));
    ptsS22 = detectSURFFeatures(rgb2gray(imgS22));
    ptsS23 = detectSURFFeatures(rgb2gray(imgS23));
   
    % calc features
    featuresS11 = extractFeatures(rgb2gray(imgS11), ptsS11);
    featuresS12 = extractFeatures(rgb2gray(imgS12), ptsS12);
    featuresS13 = extractFeatures(rgb2gray(imgS13), ptsS13);
    
    featuresS21 = extractFeatures(rgb2gray(imgS21), ptsS21);
    featuresS22 = extractFeatures(rgb2gray(imgS22), ptsS22);
    featuresS23 = extractFeatures(rgb2gray(imgS23), ptsS23);
    
    % match features
    pairs1 = matchFeatures(featuresS11, featuresS21);
    pairs2 = matchFeatures(featuresS12, featuresS22);
    pairs3 = matchFeatures(featuresS13, featuresS23);

    matched11 = ptsS11(pairs1(:, 1), :);
    matched12 = ptsS21(pairs1(:, 2), :);
    
    matched21 = ptsS12(pairs2(:, 1), :);
    matched22 = ptsS22(pairs2(:, 2), :);
    
    matched31 = ptsS13(pairs3(:, 1), :);
    matched32 = ptsS23(pairs3(:, 2), :);
    
    % estimate geometric transform & get angle
    [tForm1, ~, ~, status1] = estimateGeometricTransform(matched11, matched12, 'similarity');
    [tForm2, ~, ~, status2] = estimateGeometricTransform(matched21, matched22, 'similarity');
    [tForm3, ~, ~, status3] = estimateGeometricTransform(matched31, matched32, 'similarity');
    
    if (status1 == 0)
        
        S11 = tForm1.T(2, 1);
        S12 = tForm1.T(1, 1);

        angle1 = atan2(S11, S12)*180/pi;
        
        if abs(angle1) > 30
            
            angle1 = Angle1(i - 1);
        end
    end
    
    if (status1 == 1 || status1 == 2)
        
        angle1 = Angle1(i - 1);
    end
    
    
    if (status2 == 0)
        
        S21 = tForm2.T(2, 1);
        S22 = tForm2.T(1, 1);

        angle2 = 1.13*atan2(S21, S22)*180/pi;
        
        if abs(angle2) > 30
            
            angle2 = Angle2(i - 1);
        end 
    end
    
    if (status2 == 1 || status2 == 2)
        
        angle2 = Angle2(i - 1);
    end
    
    
    if (status3 == 0)
        
        S31 = tForm3.T(2, 1);
        S32 = tForm3.T(1, 1);

        angle3 = 1.13*atan2(S31, S32)*180/pi;
        
        if abs(angle3) > 30
            
            angle3 = Angle3(i - 1);
        end 
    end
    
    if (status3 == 1 || status3 == 2)
        
        angle3 = Angle3(i - 1);
    end
    
    Angle1(i) = angle1;
    Angle2(i) = angle2;
    Angle3(i) = angle3;
    
    
    % get new windows
    [x1, y1, z1] = moveWindow(x1, y1, z1, deg2rad(angle1), deg2rad(angle2), deg2rad(angle3));
    [az1, el1]   = cart2sphPixel(video.Height, video.Width, x1, y1, z1);
    
    [x2, y2, z2] = moveWindow(x2, y2, z2, deg2rad(angle1), deg2rad(angle2), deg2rad(angle3));
    [az2, el2]   = cart2sphPixel(video.Height, video.Width, x2, y2, z2);
    
    [x3, y3, z3] = moveWindow(x3, y3, z3, deg2rad(angle1), deg2rad(angle2), deg2rad(angle3));
    [az3, el3]   = cart2sphPixel(video.Height, video.Width, x3, y3, z3);
    
    frame1 = frame2;
end

close(videoOut);

clc;
disp('Done!');

%% show
