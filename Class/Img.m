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
            obj.definition = size(obj.img);
        end
        
        
        function getPts(obj)
            obj.pts = detectSURFFeatures(obj.img);
        end
        
        
        function getFeatures(obj)
           obj.features = extractFeatures(obj.img, obj.pts); 
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

