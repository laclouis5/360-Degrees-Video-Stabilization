function [ video ] = createVideo( path )

    video = Vid;
    vidIn = VideoReader(path);
    
    while hasFrame(vidIn)

        frame = readFrame(vidIn);

        img = Img(frame);
        video.addImg(img);
    end
end

