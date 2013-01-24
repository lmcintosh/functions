function res = chiSq(x,nu)
% chiSq - first line is short help used for various help functions
%           such as "lookfor" and "help directory"
% More description if required... - just one line above is best
% Keep it short. Let input/output descriptions and examples suffice
% 
% Usage: [out1,out2,...] = chiSq(in1,in2,...)
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
%    1. [out11,out21,...] = chiSq(in11,in21,...)
%           shows how to...
% 
%    2. [out11,out21,...] = chiSq(in11,in21,...)
%           shows how to...
%
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

nu2 = nu./2;
res = 1./(2.^(nu2).*gamma(nu2)) .* x.^(nu2 - 1) .* exp(-0.5.*x);

return

% Author: ctl      01/18/05
% RCS History:
%  $Log: chiSq.m,v $
%  Revision 1.0  2005-05-18 09:29:29-07  kowahln
%  Initial revision
%
%  Revision 1.0  2005-01-19 11:58:07-08  ctl
%  Initial revision
%
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
