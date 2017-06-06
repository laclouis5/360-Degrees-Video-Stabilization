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
                
        
        function calcFeatures(video, samplingRate)
            
            for i = 1:samplingRate:video.nbImg
               
                img = video.frames{i};
                img.calcFeatures;
            end
        end
        
        
        function getAngle(video, samplingRate)
            
            video.calcFeatures(samplingRate);
            
            for i = 1:samplingRate:floor((video.nbImg - 1)/samplingRate)*samplingRate          
                frame1 = video.frames{i};
                frame2 = video.frames{i + samplingRate};
                
                pairs = matchFeatures(frame1.features, frame2.features);
                
                matched1 = frame1.pts(pairs(:, 1), :);
                matched2 = frame2.pts(pairs(:, 2), :);
                
                [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');
                
                S1 = tForm.T(2, 1);
                S2 = tForm.T(1, 1);

                for j = 0:samplingRate - 1
                    
                    video.angles(j + i + 1) = atan2(S1, S2)*180/pi/samplingRate;
                    video.sumAngle(j + i + 1) = video.sumAngle(j + i) + video.angles(j + i + 1);
                end
            end
            
            for k = 0:mod(video.nbImg - 1, samplingRate) - 1
                
                    i = video.nbImg - samplingRate + 1;
                    
                    video.angles(k + i + 1) = video.angles(i);
                    video.sumAngle(k + i + 1) = video.sumAngle(k + i) + video.angles(k + i + 1);
            end
        end
        
        
        function corrAngle(video, samplingRate)
            
            video.getAngle(samplingRate);
            
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
           title('instant angle (degrees)');
           grid minor;
           subplot(212), plot(video.sumAngle);
           title('angle evolution (degrees)');
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
