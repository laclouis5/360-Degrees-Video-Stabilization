function [ ] = getAngleMean( video )

    stp = video.step;

    [i1, f1, i2, f2] = video.calcLimits2;

    for i = i1:stp:f1

        frame1 = video.framesSc{i};
        frame2 = video.framesSc{i + stp};

        angle    = getAngle(frame1, frame2);
        [tx, ty] = getTransl(frame1, frame2);

        for j = 1:stp

            video.angles(i + j)   = angle/stp;
            video.translX(i + j) = tx/stp;
            video.translY(i + j) = ty/stp;
            
            video.sumAngle(i + j) = video.sumAngle(i + j - 1) + angle/stp;
            video.sumTranslX(i + j) = video.sumTranslX(i + j - 1) + video.translX(i + j);
            video.sumTranslY(i + j) = video.sumTranslY(i + j - 1) + video.translY(i + j);
           
        end
    end

    if f2 >= i2
        for k = i2:1:f2

            frame1 = video.framesSc{k};
            frame2 = video.framesSc{k + 1};

            angle    = getAngle(frame1, frame2);
            [tx, ty] = getTransl(frame1, frame2);

            video.angles(k + 1)   = angle;
            video.translX(k + 1) = tx;
            video.translY(k + 1) = ty;
            
            video.sumAngle(k + 1) = video.sumAngle(k) + angle;
            video.sumTranslX(k + 1) = video.sumTranslX(k) + video.translX(k + 1);
            video.sumTranslY(k + 1) = video.sumTranslY(k) + video.translY(k + 1);
        end
    end
end

