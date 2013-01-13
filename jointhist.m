% Plots joint histogram
% Niru Maheswaranathan
% Wed Aug 22 10:42:54 2012
% h = jointhist(bins,x,y,stylestr);
% bins discretizes the space, x and y are the variables

function h = jointhist(bins,x,y,stylestr);

    if nargin < 4
        stylestr = 'k-';
    end

    subplot(3,3,[2 3 5 6]); % scatterplot
    [bx by] = meshgrid(bins(1:end-1));
    C = zeros(size(bx));
    for r = 1:length(bins)-1
        for c = 1:length(bins)-1
            C(r,c) = sum(x >= bins(c) & x < bins(c+1) & y >= bins(r) & y < bins(r+1));
        end
    end
    contour(bx,by,C,'LineWidth',2);
    %h(1) = plot(x,y,stylestr{1});
    axis([bins(1) bins(end) bins(1) bins(end)]);

    cy = hist(y,bins); cy = cy./sum(cy);
    cx = hist(x,bins); cx = cx./sum(cx);
    maxval = 1.2*max([col(cy); col(cx)]);

    subplot(3,3,[1 4]);
    h(1) = plot(cy,bins,stylestr);
    axis([0 maxval bins(1) bins(end)]);

    subplot(3,3,[8 9]);
    h(2) = plot(bins,cx,stylestr);
    axis([bins(1) bins(end) 0 maxval]);
