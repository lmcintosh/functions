function cdf = normcdf_nrk(X, mu, sigma)


cdf = 0.5 * erfc((X - mu) / (sigma * sqrt(2)));
