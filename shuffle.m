% Randomly shuffle rows of a matrix
% Niru Maheswaranathan
% Tue Sep 18 12:11:43 2012
% y = shuffle(x)

function y = shuffle(x)

    indices = randperm(size(x,1));
    y = x(indices,:);
