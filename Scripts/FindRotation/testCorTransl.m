%% test cor transl
clear
close all

x = 0;
y = 0;
    
for j = 0:3
    
    img1 = imread(sprintf('Images/translX5FullSize2/IMG_%d.JPG', 6771 + j));
    img2 = imread(sprintf('Images/translX5FullSize2/IMG_%d.JPG', 6771 + j + 1));

    [tx, ty] = getTransl(img1, img2);
    
    x = tx + x;
    y = ty + y;
    
    imgF = corTransl(img2, -x, -y, [1080 1920]);
    
    % figure, imshow(cropImg(img1, [1080 1920]));
    % figure, imshow(cropImg(img2, [1080 1920]));
    
    figure, imshow(imgF);
    
end