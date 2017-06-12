classdef Vid < handle
    
    properties 
        definition;
        ips;
        nbImg;
        frames;
        angles;
        sumAngle;    
    end
    
    
    methods
        
        function obj = Vid()
            
            obj.definition = [0 0];
            obj.ips = 0;
            obj.nbImg = 0;
            obj.frames = cell(0);
            obj.angles = zeros(0);
            obj.sumAngle = zeros(0);       
        end
        
        
        function addImg(video, Img)
            
            if (video.nbImg == 0)
                video.definition = Img.definition;
                video.angles(1) = 0;
                video.sumAngle(1) = 0;
            end
            
            
            video.frames{video.nbImg + 1} = Img;
            video.nbImg = video.nbImg + 1;
        end
        
        
        function calcFeatures(video, step)
            
            calcFeaturesInterp(video, step);
        end
        
        function getAngle(video, step)
            
            video.calcFeatures(step);
            
            getAngleInterp(video, step);
        end
        
        
        function corrAngle(video, step)
            
            video.getAngle(step);
            
            for i = 2:video.nbImg
                
                angle = video.sumAngle(i);
                frame = video.frames{i}.img;
                sz = video.frames{i}.definition;
                
                tform = calcTformInv(angle);
                
                video.frames{i}.img = corRot(frame, tform, sz);    
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
    end
end
