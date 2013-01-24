function y = kde_nrk(x, bw)
%% x: variables belonging to the same distribution 
%% bw: gaussian kernel bandwidth 
%% y: probability density estimate

if ~nargin
    mu = rand*100;
    sig = rand*5;
    x = randn(1e3,1)*sig + mu;
    
    %% bandwidth model
    bw = 1;    
    bw = std(x)/2;
    bw = length(x) * (max(x) - min(x)) / 1.5e4;
    
end


xx = linspace(min(x),max(x),100);
y = zeros(size(xx));
for ii = 1 : length(x)
    y = y + gaussian_pdf(xx,x(ii),bw);
end
y = y / sum(y)


if ~nargin
    figure
    plot(xx,y)
    hold on
    plot(xx,gaussian_pdf(xx,mu,sig)/sum(gaussian_pdf(xx,mu,sig)),'r')
    hold off
    legend('kde','truth')
    title({['\mu_x: ' num2str(mean(x)) ' \sigma_x: ' num2str(std(x))]; ...
        ['\mu_{tru}: ' num2str(mu) ' \sigma_{tru}: ' num2str(sig)]})
end
