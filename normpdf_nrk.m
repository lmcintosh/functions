function y = normpdf_nrk(x, mu, sigma)
% normpdf_nrk - pull Gaussian probability
%           
% Usage: y = normpdf_nrk(x, mu, sigma)
% 
% Input:
%    x          - x location
%    mu         - distribution mean
%    sigma      - distribution standard deviation
% 
% Output:
%    y          - Gaussian probability function output
% 
% Restrictions:
%    1.
% 
% Notes
%    1. from normpdf.m -- mathworks on the web 
% 
% Examples:
%    1. y = normpdf_nrk(x, mu, sigma)
%           returns the Gaussian probabilty, y, at point x for the
%           distribution characterized by mean, mu, and deviation, sigma
% 
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

y = (1 / (sigma * sqrt(2 * pi))) *  exp((-(x - mu) .^ 2) ./ (2 * (sigma ^ 2)));


return

% Author: nkowahl      11/18/10
% RCS History:
%  $Log$
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
