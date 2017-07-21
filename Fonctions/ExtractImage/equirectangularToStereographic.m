%% nor from me (http://www.semifluid.com/2014/04/20/equirectangular-to-stereographic-projections-little-planets-in-matlab/)

function outImage = equirectangularToStereographic(FILENAME,OUTSIZE,CAMDIST,WORLDROTATION)
    if nargin < 2
        OUTSIZE = [1080,1920];
    end
    if nargin < 3
        CAMDIST = 8;
    end
    if nargin < 4
        WORLDROTATION = 0;
    end

    inImage = imread(FILENAME);
    inImage = im2double(inImage);

    w = size(inImage,2);
    h = size(inImage,1);
    z = w/CAMDIST;      % Distance of the camera to the "planet"
    rads = 2*pi/w;
    d = @(i,j) i - j/2; % Calculate locations offset by bounds
    r = @(x,y) sqrt(d(x,w).^2 + d(y,h).^2);
    rho = @(x,y) r(x,y) ./ z;
    theta = @(x,y) 2 * atan(rho(x,y));
    a = @(x,y) atan2(d(y,h),d(x,w));

    [pixX,pixY] = meshgrid(1:w,1:h);
    % Calculate polar coordinates
    lat = theta(pixX,pixY);
    lon = a(pixX,pixY) - pi/4;
    % Wrap the lat & lon coordinates using mod
    lat = mod(lat + pi,pi) - pi/2;
    lon = mod(lon + pi + WORLDROTATION,pi*2) - pi;
    % Back to equirectangular for sampling
    xe = w/2.0 - (-lon/rads);
    ye = h/2.0 - (lat/rads);

    outImage = zeros(size(inImage,1),size(inImage,2),size(inImage,3));
    % If there are multiple color channels, we need to sample them
    for i = 1:size(inImage,3)
        outImage(:,:,i) = interp2(inImage(:,:,i),xe,ye,'cubic');
        outImage(:,:,i) = inpaint_nans(outImage(:,:,i));
    end
    if OUTSIZE(2)/OUTSIZE(1) >= size(outImage,2)/size(outImage,1)
        outImage = imresize(outImage,[NaN OUTSIZE(2)]);
        outImage = imcrop(outImage,[0 floor((size(outImage,1)-OUTSIZE(1))/2) OUTSIZE(2) OUTSIZE(1)]);
    else
        outImage = imresize(outImage,[OUTSIZE(1) NaN]);
        outImage = imcrop(outImage,[floor((size(outImage,2)-OUTSIZE(2))/2) 0 OUTSIZE(2) OUTSIZE(1)]);
    end
end
