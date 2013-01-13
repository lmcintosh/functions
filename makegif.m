% usage: [im,map] = makegif(im,map,figidx,frameidx,numframes,filename,dither,delaytime,loopcount)
function [im,map] = makegif(im,map,figidx,frameidx,numframes,filename,dither,delaytime,loopcount)

    f = getframe(figidx);
    if frameidx == 0
        [im,map] = rgb2ind(f.cdata,2^8,dither);
        im(1,1,1,numframes) = 0;
    else
        im(:,:,1,frameidx) = rgb2ind(f.cdata,map,dither);
    end

    if frameidx == numframes
        imwrite(im,map,filename,'DelayTime',delaytime,'LoopCount',loopcount);
    end
