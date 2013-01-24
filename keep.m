function keep(varargin)
% keep - Keep listed variables in workspace, clear all others
%
% Useage: keep(varargin)
%
% Input:  varargin: list of variable names
%
% Example:  keep(gData Params);

% Author: mathworks central file exchange
% RCS History:
%  $Log: keep.m,v $
%  Revision 1.0  2002-05-24 18:13:39-07  khr
%  Initial revision
%
% End RCS History:

global TRANSFER__
evalin('caller','global TRANSFER__, TRANSFER__=who;');

for i=1:length(varargin)
  idx=strmatch(varargin{i},TRANSFER__);
  TRANSFER__(idx)=[];
end

for i=1:length(TRANSFER__)
  evalin('caller',['clear ',TRANSFER__{i}]);
end

clear global TRANSFER__
