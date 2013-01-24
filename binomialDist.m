function [P] = binomialDist(N,p)
% binomialDist - first line is short help used for various help functions
%           such as "lookfor" and "help directory"
% More description if required... - just one line above is best
% Keep it short. Let input/output descriptions and examples suffice
% 
% Usage: [out1,out2,...] = binomialDist(in1,in2,...)
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
%    1. [out11,out21,...] = binomialDist(in11,in21,...)
%           shows how to...
% 
%    2. [out11,out21,...] = binomialDist(in11,in21,...)
%           shows how to...
%
%12345678901234567890123456789012345678901234567890123456789012345678901234567890

for n = 1 : N

    P(n) = nchoosek(N,n) * (p^n) * ((1-p)^(N-n));

end

% count = 0;
% for p = 0.01 : 0.01 : 1
%     count = count + 1;
%     P(count) = nchoosek(N,n) * (p^n) * ((1-p)^(N-n));
% end


return

% Author: kowahln      04/12/06
% RCS History:
%  $Log$
% End RCS History:

% SUBFUNCTION --------------------------------------------------

% function another()
