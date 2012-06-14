% Creates a new figure 
% Niru Maheswaranathan
% Sat Jun  9 14:38:50 2012

function fig(figidx)
    if nargin < 1
        figidx = gcf;
    end

    figure(figidx); clf; dockf;
end
