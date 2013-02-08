function hist2(H0,H1)
% this just plots the distributions in the same figure
% INPUTS: H0, H1
% OUTPUTS: none

figure; hold on
hist(H0)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','FaceAlpha',0.7)
% set(gca,'fontsize',16)
hist(H1)
hold off
% xlabel('log_1_0 Signal Intensity')
legend('x_0', 'x_1')