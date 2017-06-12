classdef Vid < handle
    
    properties 
        definition;
        ips;
        nbImg;
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
            
            obj.definition = [0 0];
            obj.ips        = 0;
            obj.nbImg      = 0;
            obj.scale      = scale;
            obj.step       = step;
            obj.sizeOut    = sizeOut;
            obj.frames     = cell(0);
            obj.framesSc   = cell(0);
            obj.framesOut  = cell(0);
            obj.angles     = zeros(0);
            obj.sumAngle   = zeros(0);
            
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
                
                video.definition  = Img.definition;
                video.angles(1)   = 0;
                video.sumAngle(1) = 0;
            end
            
            video.frames{video.nbImg + 1} = Img;
            video.nbImg = video.nbImg + 1;
        end
        
        
<<<<<<< HEAD
        function calcFeatures(video, step)
            
            calcFeaturesInterp(video, step);
        end
        
        function getAngle(video, step)
=======
        function createFrameSc(video)
            
            for i = 1:1:video.nbImg
                
                img = rescale(rgb2gray(video.frames{i}.img), video.scale);
                video.framesSc{i} = Img(img);
            end
        end
        
        
        function [i1, f1, i2, f2] = calcLimits1(video)
            
            stp = video.step;
            N = video.nbImg - 1;
            nbMatch1 = floor(N/stp);
            nbMatch2 = N - stp*nbMatch1;
            
            i1 = 1;
            f1 = stp*nbMatch1 + i1;
            
            i2 = f1 + 1;
            f2 = nbMatch2 + f1;
        end
               
        
        function [i1, f1, i2, f2] = calcLimits2(video)

            stp = video.step;
            N = video.nbImg - 1;
            nbMatch1 = floor(N/stp) - 1;
            nbMatch2 = N - stp*nbMatch1 - 1;
            
            i1 = 1;
            f1 = stp*nbMatch1 + i1;
            
            i2 = f1 + stp;
            f2 = nbMatch2 + f1;
        end
        
        
        function calcFeatures(video)
            
            [i1, f1, i2, f2] = video.calcLimits1;
            
            for i = i1:video.step:f1
               
                img = video.framesSc{i};
                img.calcFeatures;
            end
            
            if f2 >= i2
                
                for j = i2:1:f2
                    
                    img = video.framesSc{j};
                    img.calcFeatures;
                end
            end
        end
        
        
        function getAngle(video)
>>>>>>> master
            
            stp = video.step;
            video.calcFeatures;
            
<<<<<<< HEAD
            getAngleInterp(video, step);
=======
            [i1, f1, i2, f2] = video.calcLimits2;
            
            for i = i1:stp:f1
                
                frame1 = video.framesSc{i};
                frame2 = video.framesSc{i + stp};
        
                angle = getAngle(frame1, frame2);
                
                for j = 1:stp
                    
                    video.angles(i + j) = angle/stp;
                    video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle/stp;
                end
            end
            
            if f2 >= i2
                for k = i2:1:f2

                    frame1 = video.framesSc{k};
                    frame2 = video.framesSc{k + 1};

                    angle = getAngle(frame1, frame2);

                    video.angles(k + 1) = angle;
                    video.sumAngle(k + 1) = video.sumAngle(k) + angle;
                end
            end
>>>>>>> master
        end
        
        
        function corrAngle(video)
            
            video.getAngle;
            
            
            for i = 1:video.nbImg
                
                angle = video.sumAngle(i);
                frame = video.frames{i}.img;
                sz = video.frames{i}.definition;
                
                tform = calcTformInv(angle);
                
                video.framesOut{i} = Img(cropImg(corRot(frame, tform, sz), video.sizeOut));
            end
        end
        
        
        function showAngle(video)  
            
           figure, subplot(211), plot(video.angles);
           title('instant angle');
           xlabel('frame number');
           ylabel('angle in degree per frame');
           grid minor;
           subplot(212), plot(video.sumAngle);
           title('angle evolution');
           xlabel('frame number');
           ylabel('angle in degree');
           grid minor;  
        end
        
        
        function showVideo(video)
            
            for i = 1:video.nbImg      
                image = video.frames{i}.img;    
                figure, imshow(image);    
                colormap(gray);
            end
        end
    
    
        function saveVideo(video)

            vidOut = VideoWriter('Out.mp4', 'MPEG-4');

            open(vidOut);

            for i = 1:1:video.nbImg

                writeVideo(vidOut, video.framesOut{i}.img); 
            end

            close(vidOut);
        end
    end
end
