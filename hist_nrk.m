function [N, X] = hist_nrk(yVals,binC,doPlot)

if exist('doPlot') ~= 1
    doPlot = 0;
end

X = binC;

for ii = 1 : length(X)
       
    if ii == 1
        
        rEdge = X(ii) + ((X(ii+1) - X(ii)) / 2);
        N(ii) = length(find(yVals<=rEdge));
                
    elseif ii == length(X)
        
        lEdge = X(ii) - ((X(ii) - X(ii-1)) / 2);
        N(ii) = length(find(yVals>lEdge));
        
    else
        
        rEdge = X(ii) + ((X(ii+1) - X(ii)) / 2);
        lEdge = X(ii) - ((X(ii) - X(ii-1)) / 2);
        
        N(ii) = length(find(yVals>lEdge & yVals<=rEdge));
        
    end
    
end

if doPlot
    figure
    bar(X,N)
end