function [mnInd mn] = findClose(A,b)
% find closest indicies in A for elements of b

for ii = 1 : length(b)
    [mn(ii) mnInd(ii)] = min(abs(A-b(ii)));
end