function [integ] = trapInt(x,y)
% trapInt - trapezoidal integration
% 
% Usage: [out1,out2,...] = trapInt(in1,in2,...)
% 
% Input:
%    x       
%    y        
% 
% Output:
%    integ       
% 
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

if (length(x) ~= length(y)) | length(x) == 1
    error('Incorrect Input Arguments.  Input equal length vectors.')
end

%% make sure x is mono increasing
[x srtIdx] = sort(x);
y = y(srtIdx);

%% perform trap integration
midPoints = y(1:(end-1)) + (diff(y)/2);
integ = sum(midPoints .* diff(x));


return

% Author: kowahln      04/04/06
% RCS History:
%  $Log$
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
