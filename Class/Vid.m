classdef Vid < handle
    
    properties 
        
        definition;
        ips;
        nbImg;
        nbFeat;
        
        step;
        scale;
        sizeOut;
        
        frames;
        framesSc;
        framesOut;
        
        angles;
        sumAngle;
        translX;
        translY;
        sumTranslX;
        sumTranslY;
    end
    
    
    methods
        
        function obj = Vid(path, step, scale, sizeOut)
            
            obj.definition = [0 0];
            obj.ips        = 0;
            obj.nbImg      = 0;
            obj.nbFeat     = 0;
            obj.scale      = scale;
            obj.step       = step;
            obj.sizeOut    = sizeOut;
            obj.frames     = cell(0);
            obj.framesSc   = cell(0);
            obj.framesOut  = cell(0);
            obj.angles     = zeros(0);
            obj.sumAngle   = zeros(0);
            obj.translX    = zeros(0);
            obj.translY    = zeros(0);
            obj.sumTranslX = zeros(0);
            obj.sumTranslY = zeros(0);
            
            obj.createVideo(path);
        end

        
        function createVideo( video, path )
    
            vidIn = VideoReader(path);

            while hasFrame(vidIn)

                frame = readFrame(vidIn);

                img = Img(frame);
                video.addImg(img);
            end 

            video.createFrameSc;
        end
        
        
        function addImg(video, Img)
            
            if (video.nbImg == 0)
                
                video.definition    = Img.definition;
                video.angles(1)     = 0;
                video.sumAngle(1)   = 0;
                video.translX(1)    = 0;
                video.translY(1)    = 0;
                video.sumTranslX(1) = 0;
                video.sumTranslY(1) = 0;
            end
            
            video.frames{video.nbImg + 1} = Img;
            video.nbImg = video.nbImg + 1;
        end
        
        
        function createFrameSc(video)
            
            for i = 1:1:video.nbImg
                
                img = rescale(rgb2gray(video.frames{i}.img), video.scale);
                video.framesSc{i} = Img(img);
            end
        end
        
        
        function [i1, f1, i2, f2] = calcLimits1(video)
            
            stp      = video.step;
            N        = video.nbImg - 1;
            nbMatch1 = floor(N/stp);
            nbMatch2 = N - stp*nbMatch1;
            
            i1 = 1;
            f1 = stp*nbMatch1 + i1;
            
            i2 = f1 + 1;
            f2 = nbMatch2 + f1;
        end
               
        
        function [i1, f1, i2, f2] = calcLimits2(video)

            stp      = video.step;
            N        = video.nbImg - 1;
            nbMatch1 = floor(N/stp) - 1;
            nbMatch2 = N - stp*nbMatch1 - 1;
            
            i1 = 1;
            f1 = stp*nbMatch1 + i1;
            
            i2 = f1 + stp;
            f2 = nbMatch2 + f1;
        end
        
        
        function calcFeatures(video, interpMode)
            
            if strcmp(interpMode,'mean')
                
                calcFeaturesMean(video);
                
            elseif strcmp(interpMode, 'linear')
                
                calcFeaturesLinear(video);
            end
        end
        
        
        function getAngle(video, interpMode)
         
            video.calcFeatures(interpMode);
            
            if strcmp(interpMode, 'mean')
                
                getAngleMean(video);
                
            elseif strcmp(interpMode, 'linear')
                
                getAngleLinear(video);
            end
        end
        
        
        function corrAngle(video, interpMode)
            
            video.getAngle(interpMode);
            
            for i = 1:video.nbImg
                
                angle = video.sumAngle(i);
                frame = video.frames{i}.img;
                
                tform = calcTformInv(angle);
                
                video.framesOut{i} = Img(cropImg(corRot(frame, tform), video.sizeOut));
            end
        end
        
        
        function showAngle(video)  
            
           plot(video.angles);
           title('instant angle');
           xlabel('frame number');
           ylabel('angle in degree per frame');
        end
        
        
        function showSumAngle(video)
            
           plot(video.sumAngle);
           title('angle evolution');
           xlabel('frame number');
           ylabel('angle in degree');
        end
        
        
        function showTranslX(video)
            
            plot(video.translX);
            title('translation on X axis');
            xlabel('frame number');
            ylabel('tranlation in pixels');
        end
        
        
        function showTranslY(video)
            
            plot(video.translY);
            title('translation on Y axis');
            xlabel('frame number');
            ylabel('tranlation in pixels');
        end
        
        
        function showSumTranslX(video)
            
            plot(video.sumTranslX);
            title('translation on X axis');
            xlabel('frame number');
            ylabel('tranlation in pixels');
        end
        
        
        function showSumTranslY(video)
            
            plot(video.sumTranslY);
            title('translation on Y axis');
            xlabel('frame number');
            ylabel('tranlation in pixels');
        end
        
        
        function showVideo(video)
            
            for i = 1:video.nbImg  
                
                image = video.frames{i}.img;    
                figure, imshow(image);    
                colormap(gray);
            end
        end
    
    
        function saveVideo(video, name)

            vidOut = VideoWriter(name, 'MPEG-4');

            open(vidOut);

            for i = 1:1:video.nbImg

                writeVideo(vidOut, video.framesOut{i}.img); 
            end

            close(vidOut);
        end
    end
end
