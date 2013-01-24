function filtData = meanWindow(data,winLen)

% meanWindow - Smoothes the data by applying a simple window mean (each
% point is replaced by the mean of the range of 10 points ahead and 10
% points behind the data point).
% 
% Usage: filtData = meanWindow(data)
% 
% Input:
%    data         - A column vector of sensor data values (or matrix)
% 
% Output:
%    filtData     - a column vector of smoothed data values
% 
% Examples:
%    1. filtData = meanWindow(data(dataIdx))
%
% Author: dld      01/24/03
% RCS History:
%  $Log: meanWindow.m,v $
%  Revision 1.0  2005-10-17 12:51:43-07  kowahln
%  Initial revision
%
% End RCS History:
%
%12345678901234567890123456789012345678901234567890123456789012345678901234567890
window = floor(winLen/2);
dataLen = size(data,1); 
if dataLen == 1; data = data'; dataLen = size(data,1); end 
filtData = data;  % Initialize variables

% Go down the column and smooth the data
for ii = window + 1:dataLen-window
    filtData(ii,:) = mean(data(ii-window:ii+window,:),1);
end
filtData(1:window+1,:) = repmat(mean(data(1:window+1,:),1),length(1:window+1),1);
filtData(end-(window+1):end,:) = repmat(mean(data(end-(window+1):end,:),1),size(filtData(end-(window+1):end,:),1),1);