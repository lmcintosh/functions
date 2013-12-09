function [Sigma] = cov_full(x,y)
% each row is a variable, each column is a different sample

x_zeroed = x - mean(x,2)*ones(1,size(x,2));
y_zeroed = y - mean(y,2)*ones(1,size(y,2));
Sigma    = x_zeroed*y_zeroed';
