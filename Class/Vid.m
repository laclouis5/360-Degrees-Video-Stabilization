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
            
            N = video.nbImg - 1;
            nbMatch1 = floor(N/step);
            nbMatch2 = N - step*nbMatch1;
            
            i1 = 1;
            f1 = step*nbMatch1 + i1;
            
            i2 = f1 + 1;
            f2 = nbMatch2 + f1;
        end
               
        
        function [i1, f1, i2, f2] = calcLimits2(video, step)

            N = video.nbImg - 1;
            nbMatch1 = floor(N/step) - 1;
            nbMatch2 = N - step*nbMatch1 - 1;
            
            i1 = 1;
            f1 = step*nbMatch1 + i1;
            
            i2 = f1 + step;
            f2 = nbMatch2 + f1;
        end
        
        
        function calcFeatures(video, step)
            
            [i1, f1, i2, f2] = video.calcLimits1(step);
            
            for i = i1:step:f1
               
                img = video.frames{i};
                img.calcFeatures;
            end
            
            if f2 >= i2
                
                for j = i2:1:f2
                    
                    img = video.frames{j};
                    img.calcFeatures;
                end
            end
        end
        
        
        function getAngle(video, step)
            
            video.calcFeatures(step);
            
            [i1, f1, i2, f2] = video.calcLimits2(step);
            
            for i = i1:step:f1
                
                frame1 = video.frames{i};
                frame2 = video.frames{i + step};
        
                angle = getAngle(frame1, frame2);
                
                for j = 1:step
                    
                    video.angles(i + j) = angle/step;
                    video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle/step;
                end
            end
            
            if f2 >= i2
                for k = i2:1:f2

                    frame1 = video.frames{k};
                    frame2 = video.frames{k + 1};

                    angle = getAngle(frame1, frame2);

                    video.angles(k + 1) = angle;
                    video.sumAngle(k + 1) = video.sumAngle(k) + angle;
                end
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
