% Error Patch Plot: plots line with patch showing standard deviation or error
% Niru Maheswaranathan
% Thu Sep  6 16:34:02 2012
% h = epplot(x,y,e,color)
% plots the line y vs. x with error patch given by e, with given RGB color
% returns handle to patch in h(1), handle to line in h(2)

function h = epplot(x,y,e,color)

    % store figure handles
    h = zeros(2,1);

    if nargin < 4
        color = [0.2 0.2 0.2];
    end

    % get dimmer patch color
    temp = rgb2hsv(color); temp(3) = temp(3) + 0.5*(1-temp(3));
    patchcolor = hsv2rgb(temp);

    % plot line
    h(1) = patch([x fliplr(x)], [y-e fliplr(y+e)], patchcolor); hold on;
    h(2) = plot(x,y,'-','Color',color); hold off;
    set(h(1),'FaceAlpha',0.2,'EdgeAlpha',0);
    makepretty; grid on;
