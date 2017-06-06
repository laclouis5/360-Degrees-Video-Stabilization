function [ imgS ] = corRot( imgE, tForm, CropSize )

    imgS = imwarp(imgE, tForm);
    imgS = cropImg(imgS, CropSize);

end

