function P = poisson_pdf(n,v)
%% n = x position to be evaluated
%% v = var and mean

P = ((v .^ n) * exp(-v)) ./ factorial(n);