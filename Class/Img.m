classdef Img < handle
    
    properties
        img;
        definition;
        pts;
        features;     
    end
   
    
    methods
        
        function obj = Img(img)
            obj.img = img;
            obj.getDefinition;
        end;
        
        
        function getDefinition(obj)
            obj.definition = size(rgb2gray(obj.img));
        end
        
        
        function getPts(obj)
            obj.pts = detectSURFFeatures(rescale(rgb2gray(obj.img), 0.3), 'MetricThreshold', 1000, 'NumOctave', 4, 'NumScaleLevels', 3);
        end
        
        
        function getFeatures(obj)
           obj.features = extractFeatures(rescale(rgb2gray(obj.img), 0.3), obj.pts); 
        end
        
        
        function calcFeatures(obj)
            obj.getPts;
            obj.getFeatures;
        end
        
        
        function showImg(m_obj)
            figure, imshow(m_obj.img);
            hold on;
            plot(m_obj.pts);
        end
    end
end

