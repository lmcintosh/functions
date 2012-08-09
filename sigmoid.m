% Sigmoid nonlinearity function
% Niru Maheswaranathan
% Thu Jul 26 12:27:22 2012
% f = sigmoid(x, varargin)

function f = sigmoid(x, varargin)

p = inputParser;
addRequired(p,'x',@isnumeric);
addParamValue(p,'gain',1,@isnumeric);
addParamValue(p,'threshold',0,@isnumeric);
addParamValue(p,'maximum',1,@isnumeric);
parse(p,x,varargin{:});

f = p.Results.maximum./(1+exp(-p.Results.gain*(p.Results.x-p.Results.threshold)));
