function [ ] = getAngleMean( video )

    stp = video.step;

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
end

