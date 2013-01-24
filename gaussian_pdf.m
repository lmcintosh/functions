function P = gaussian_pdf(x,mu,sig)
%% x = evaluation point
%% mu = mean
%% sig = standard deviation


P = (1/(sig*sqrt(2*pi))) * exp((-(x-mu).^2) / (2*sig^2));

