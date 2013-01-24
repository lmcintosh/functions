function [sequenceC] = complement(sequence)
% Computes the [complement] of an input sequence. 
% 
% Usage: sequenceC = complement(sequence);
% 
% Input:
%    sequence(char**)  - Sequence of nucleotides.
% 
% Output:
%    sequenceC(char**) - Complement of input sequence.
%  
% Restrictions:
%    1. The input sequence must be a character array consisting of only
%       the upper case letters 'A', 'C', 'G' and 'T'.
%
% Notes:
%    1. None.
%
% Examples:
%    1. [sequenceC] = complement(sequence);

% Author: yashar      08/20/01
% RCS History:
%  $Log: complement.m,v $
%  Revision 1.0  2002-02-01 16:25:58-08  brons
%  Initial revision
%
%  Revision 1.0  2001-11-05 11:32:20-08  brons
%  Initial revision
%
%  Revision 1.1  2001-08-30 14:52:14-07  yashar
%  made faster
%
%  Revision 1.0  2001-08-27 12:05:11-07  yashar
%  Initial revision
%
% End RCS History:

% ruler --1234567890123456789012345678901234567890123456789012345678901234567890

if isempty(sequence)
   sequenceC = [];
else
   sequenceC = sequence;
   sequenceC(sequence=='A') = 'T';
   sequenceC(sequence=='C') = 'G';
   sequenceC(sequence=='G') = 'C';
   sequenceC(sequence=='T') = 'A';
end