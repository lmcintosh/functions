% Normalize a vector to make it a unit vector
% Niru Maheswaranathan
% Mon Aug  6 13:18:46 2012
% y = normalize(x)

function [y len] = normalize(x)

    len = sqrt(sum(x.^2));
    y = x./(ones(size(x,1),1)*len);
    y(isnan(y)) = 0;
