function [ex, vari, mnX2] = fitGauss(y,doPlot)
% fitGauss - fit random set of data, y, to gaussian pdf
%
% Usage: [out1,out2,...] = fitGauss(in1,in2,...)
% 
% Input:
%    y        - ensemble to fit
% 
% Output:
%    ex       - mean
%    vari     - variance
% 
% Restrictions:
%    1.
%    2.
% 
% Notes
%    1. yak yak yak
%    2. yuk yuk yuk
% 
% Examples:
%    1. [out11,out21,...] = fitGauss(in11,in21,...)
%           shows how to...
% 
%    2. [out11,out21,...] = fitGauss(in11,in21,...)
%           shows how to...
%
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

if nargin == 1
    doPlot = 0;
end

%% eliminate nan and inf
y(isnan(y)) = [];
y(isinf(y)) = [];

if isempty(y)
    ex = NaN; vari = NaN; mnX2 = NaN;
    return
end

lenY = length(y);
mnY = min(y);
mxY = max(y);

if length(y) > 200
    X = linspace(mnY,mxY,ceil(lenY/20));
else
    X = linspace(mnY,mxY,10);
end


N = hist(y,X);
N = N / sum(N);

[exS, variS] = rigStats(X,N); %% find seeds

exVec = linspace(exS - (exS*0.5),exS + (exS*0.5),100);
vrVec = linspace(variS - (variS*0.75),variS + (variS*0.75),100);

for ii = 1 : length(exVec)
    for jj = 1 : length(vrVec)
        
        y = normpdf_nrk(X, exVec(ii), sqrt(vrVec(jj)));
        X2(ii,jj) = sum(((y/sum(y)) - N) .^ 2);
        
    end
end

[mnX2 ind] = min(X2(:));
[I J] = ind2sub(size(X2),ind);
ex = exVec(I);
vari = vrVec(J);

if doPlot
    y = normpdf_nrk(X, ex, sqrt(vari));  
    y = y / sum(y);
    figure
    hold on
    plot(X,N,'*-')
    plot(X,y,'r','linewidth',3)
    hold off
    legend('Data In',['Fit: \mu = ' num2str(ex) '; \sigma^2 = ' num2str(vari)],0)
    
    figure
    imagesc(X2)
    xlabel('~\sigma^2')
    ylabel('~\mu')
    title('X^2 Map')
end

return

% Author: kowahln      04/05/06
% RCS History:
%  $Log$
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
