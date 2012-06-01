% Niru Maheswaranathan
% performs linear regression on two variables
% 4/18/11
% [P, r2, xlin, ylin, yhat] = linfit(x,y,showplot);

function [P, r2, xlin, ylin, yhat] = linfit(x,y,showplot);
    xlin = linspace(min(x), max(x), 1e4);
    P = polyfit(x,y,1);
    yhat = polyval(P,x);
    ylin = polyval(P,xlin);

    ssreg = sum((y-yhat).^2);
    sstot = sum((y-mean(y)).^2);
    r2 = 1-ssreg/sstot;

    if showplot
        plot(xlin,ylin,'c-',x,y,'r.','LineWidth',2.5,'MarkerSize',25); makepretty;
        title(['y = ' num2str(P(1)) 'x + ' num2str(P(2)) ', r^2 = ' num2str(r2)]);
    end
end
