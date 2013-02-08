function [samples] = gaussian(mean,var,number_samples)
% INPUTS: Mean, var, number_samples
% OUTPUT: row vector of samples

samples = sqrt(var)*randn(number_samples,1)+mean;

end
