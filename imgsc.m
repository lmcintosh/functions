%% imagesc + axis image + colorbar
function h = imgsc(img, scale)

    if nargin < 2
        imagesc(img);
    else
        imagesc(img, scale);
    end

    axis image;
    colorbar;
    set(gca,'XTick',[],'YTick',[]);
    colormap gray;
