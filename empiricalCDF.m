function [cdf, X] = empiricalCDF(data,X)
% empiricalCDF - first line is short help used for various help functions
%           such as "lookfor" and "help directory"
% More description if required... - just one line above is best
% Keep it short. Let input/output descriptions and examples suffice
% 
% Usage: [out1,out2,...] = empiricalCDF(in1,in2,...)
% 
% Input:
%    in1        - description1
%    in2        - description2
% 
% Output:
%    out1       - description1
%    out2       - description2
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
%    1. [out11,out21,...] = empiricalCDF(in11,in21,...)
%           shows how to...
% 
%    2. [out11,out21,...] = empiricalCDF(in11,in21,...)
%           shows how to...
%
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

if ~exist('X','var')
    X = linspace(min(data),max(data),50);    
end
% dX = diff(X);
% X = [(X(1)-dX(1)) X]; %% pad
% X = [X (X(end)+dX(1))];

n = histc(data,X);
n = n / sum(n);
cdf = cumsum(n);

%cdf = interp1(sort(data),linspace(0,1,length(data)),X);

%% shift data to correct edge based binning
% X(1) = [];
% cdf(end) = [];

return

% Author: kowahln      02/20/07
% RCS History:
%  $Log$
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
