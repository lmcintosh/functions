%% imagesc + axis image + colorbar
function h = imgsc(img)
    imagesc(img);
    axis image;
    colorbar;
    set(gca,'XTick',[],'YTick',[]);
