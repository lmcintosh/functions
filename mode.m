function x = mode(y)




[cnts xs] = hist(y,sort(y));

xind = find(max(cnts) == cnts);

x = y(xind(1));

if length(x) == length(y)
    disp('Could not find mode. No repeated values.')
    x = [];
end