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
    end
    
    
    methods

        function obj = Vid(path, step, scale, sizeOut)
            
            if nargin == 1
                
                vidIn = VideoReader(path);
                
                % set param
                obj.definition = [vidIn.height vidIn.Width];
                obj.ips        = vidIn.frameRate;
                obj.nbImg      = vidIn.Duration*vidIn.frameRate;
                
                % mem alloc
                obj.frames = cell(0);
                
                % Filling of attributes
                count = 1;

                while hasFrame(vidIn)

                    frame = readFrame(vidIn);
                    img   = Img(frame);

                    obj.frames{count}  = img;

                    count = count + 1;
                end
            end
            
            if nargin > 1
                
                vidIn = VideoReader(path);

                % set param
                obj.definition = [vidIn.height vidIn.Width];
                obj.ips        = vidIn.frameRate;
                obj.nbImg      = vidIn.Duration*vidIn.frameRate;
                obj.nbFeat     = 0;
                obj.scale      = scale;
                obj.step       = step;
                obj.sizeOut    = sizeOut;

                % mem alloc
                obj.frames    = cell(0);
                obj.framesSc  = cell(0);
                obj.framesOut = cell(0);
                obj.angles    = zeros(0);
                obj.sumAngle  = zeros(0);

                % Initialisation
                obj.angles(1)     = 0;
                obj.sumAngle(1)   = 0;

                % Filling of attributes
                count = 1;

                while hasFrame(vidIn)

                    frame = readFrame(vidIn);
                    img   = Img(frame);

                    obj.frames{count}  = img;
                    obj.framesSc{count} = Img(imresize(rgb2gray(frame), scale));

                    count = count + 1;
                end
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
        end
        
        
        function showAngle(video)  
            
           plot(video.angles);
           title('instant angle X');
           xlabel('frame number');
           ylabel('angle in degree per frame');
        end
        
        
        function showSumAngle(video)
            
           plot(video.sumAngle);
           title('angle evolution X');
           xlabel('frame number');
           ylabel('angle in degree');
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
