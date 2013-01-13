% plots an anonymous function
% Niru Maheswaranathan
% Thu Sep 27 10:48:51 2012

function h = plotfun(f,bounds)

    if nargin < 2
        bounds = [-10 10];
    end

    x = linspace(bounds(1), bounds(2), 1e3);
    h = plot(x,f(x));
