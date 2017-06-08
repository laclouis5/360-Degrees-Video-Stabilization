function [ ] = saveVideo( video )

    vidOut = VideoWriter('Out.mp4', 'MPEG-4');
    
    open(vidOut);

    for i = 1:1:video.nbImg
        video.frames{i}.img = cropImg(video.frames{i}.img, videoSize);
        writeVideo(vidOut, video.frames{i}.img); 
    end

    close(vidOut);
end

