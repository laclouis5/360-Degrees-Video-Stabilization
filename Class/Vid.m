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
        
        
        function [i1, f1, i2, f2] = calcLimits1(video, step)
            
            nb = video.nbImg;
            N = nb - 1;
            nbMatch1 = floor(N/step);
            nbMatch2 = N - step*nbMatch1;
            
            i1 = 1;
            f1 = step*nbMatch1 + i1;
            
            i2 = f1 + 1;
            f2 = nbMatch2 + f1;
        end
               
        
        function [i1, f1, i2, f2] = calcLimits2(video, step)
            
            nb = video.nbImg;
            N = nb - 1;
            nbMatch1 = floor(N/step) - 1;
            nbMatch2 = N - step*nbMatch1 - 1;
            
            i1 = 1;
            f1 = step*nbMatch1 + i1;
            
            i2 = f1 + step;
            f2 = nbMatch2 + f1;
        end
        
        
        function calcFeatures(video, step)
            
            [i1, f1, i2, f2] = video.calcLimits1(video, step);
            
            for i = i1:step:f1
               
                img = video.frames{i};
                img.calcFeatures;
            end
            
            for j = i2:1:f2
                img = video.frames{i};
                img.calcFeatures;
            end
        end
        
        
        function getAngle(video, step)
            
            video.calcFeatures(step);
            
            [i1, f1, i2, f2] = video.calcLimits2(video, step);
            
            for i = i1:step:f1
                
                frame1 = video.frames{i};
                frame2 = video.frames{i + step};
                
                pairs = matchFeatures(frame1.features, frame2.features);
                
                matched1 = frame1.pts(pairs(:, 1), :);
                matched2 = frame2.pts(pairs(:, 2), :);
                
                [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');
                
                S1 = tForm.T(2, 1);
                S2 = tForm.T(1, 1);
        
                angle = atan2(S1, S2)*180/pi;
                
                for j = 1:step
                    
                    video.angle(i + j) = angle/step;
                    video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle/step;
                end
            end
            
            for i = i2:1:f2
                
                frame1 = video.frames{i};
                frame2 = video.frames{i + 1};
                
                pairs = matchFeatures(frame1.features, frame2.features);
                
                matched1 = frame1.pts(pairs(:, 1), :);
                matched2 = frame2.pts(pairs(:, 2), :);
                
                [tForm] = estimateGeometricTransform(matched1, matched2, 'similarity');
                
                S1 = tForm.T(2, 1);
                S2 = tForm.T(1, 1);
        
                angle = atan2(S1, S2)*180/pi;
                             
                video.angle(i + j) = angle;
                video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle;
            end
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
