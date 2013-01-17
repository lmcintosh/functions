% reshapes a vector into a square matrix
% Niru Maheswaranathan
% Wed Jan 16 16:06:27 2013
% A = imsq(x)

function A = imsq(x)

    sz = sqrt(length(x));
    if mod(sz,1) ~= 0
        warning('Length is not a perfect square. Truncating elements.\n');
        sz = floor(sz);
    end

    A = reshape(x(1:sz*sz), sz, sz);
