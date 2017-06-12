function [ ] = calcFeaturesMean( video )

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
