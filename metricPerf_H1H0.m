function [Pfa, Pd, pdThresh, StatMat] = metricPerf_H1H0(H1data,H0data,plotOpt,tStr)
%% plotOpt
%% 1: Modeling results and 2 and 3 below (all plots)
%% 2: Empirical ROC curve and 3 below
%% 3: ROC curve only

if exist('tStr','var')
    switch class(tStr)
        case 'cell'
        otherwise
            tStr = {tStr};
    end
else
    tStr = '';
end

if ~exist('plotOpt','var')
    plotOpt = 0;
end

switch class(H1data)
    case 'double' %% assume single vector input for now
        H1data = {H1data};
        H0data = {H0data};
end

for ii = 1 : length(H1data)
    
%     if any(isnan(H1data{ii})) | any(isnan(H0data{ii})) %% if nan kickout
%         H1data{ii} = 0; H0data{ii} = 0;
%     end
    
    if mean(H1data{ii}) < mean(H0data{ii}) %% handle sign flip
        H1data{ii} = -H1data{ii};
        H0data{ii} = -H0data{ii};
    end

    hiMet = max(H1data{ii});
    loMet = min(H0data{ii});

    %% PLOT H1 and H0
    edgeBuf = (hiMet - loMet) * 0.1;
    X = [loMet-edgeBuf hiMet+edgeBuf];
    N = 100;%length(H1data{ii}) / 3;
    X = linspace(X(1),X(2),N); %% define bins
    [N_H1] = hist(H1data{ii},X);
    [N_H0] = hist(H0data{ii},X);

    if 0 %% do rigorous parametric fir
        m_H0(ii) = (N_H0 * X') / (sum(N_H0));
        m_H1(ii) = (N_H1 * X') / (sum(N_H1));
        s_H0(ii) = sqrt(((X - m_H0(ii)).^2) * (N_H0' / sum(N_H0)));
        s_H1(ii) = sqrt(((X - m_H1(ii)).^2) * (N_H1' / sum(N_H1)));
        mnX2_h1 = NaN; mnX2_h0 = NaN;
    elseif 1 %% do simple parametric fit
        m_H1(ii) = mean(H1data{ii});
        m_H0(ii) = mean(H0data{ii});
        s_H1(ii) = std(H1data{ii});
        s_H0(ii) = std(H0data{ii});
        mnX2_h1 = NaN; mnX2_h0 = NaN;
    elseif 1 %% do X2 fit
        [m_H1(ii), vari, mnX2_h1] = fitGauss(H1data{ii},0);
        s_H1(ii) = sqrt(vari);
        [m_H0(ii), vari, mnX2_h0] = fitGauss(H0data{ii},0);
        s_H0(ii) = sqrt(vari);
    elseif 0 %% do X2 fit on cdf for clipped data

        %% delegate to subfunction
        [m_H1(ii) s_H1(ii) mnX2_h1 m_H0(ii) s_H0(ii) mnX2_h0] = ...
            clipDataFit(H1data{ii},H0data{ii});

    elseif 0 %% use gaussian kernals with hn ~ P(1-P)/n (not functional)
        pdf_H1 = [];
        pdf_H0 = [];
        for jj = 1 : length(N_H1)
            P = N_H1(jj) / sum(N_H1);
            sigma = P*(1 - P) * length(X);
            %             sigma = N_H1(jj) / sqrt(length(X));
            if sigma > 0
                pdf_H1(jj,:)  = normpdf_nrk(X,X(jj),sigma) * N_H1(jj);
            end

            P = N_H0(jj) / sum(N_H0);
            sigma = P*(1 - P) * length(X);
            %             sigma = N_H0(jj) / sqrt(length(X));
            if sigma > 0
                pdf_H0(jj,:)  = normpdf_nrk(X,X(jj),sigma) * N_H0(jj);
            end
        end

        pdf_H1 = sum(pdf_H1);
        pdf_H1 = pdf_H1 / trapz(X,pdf_H1);

        pdf_H0 = sum(pdf_H0);
        pdf_H0 = pdf_H0 / trapz(X,pdf_H0);

        figure
        plot(X,pdf_H0)
        hold on
        plot(X,pdf_H1,'r')
        hold off

    end

    if plotOpt == 1
%         dX = diff(X);
%         Xfull = min(X(1)-dX(1),1.5*m_H0(ii)):dX(1):X(end);
%         X = Xfull;

        hHist = figure; hold on

        %% normalize histogram output
        N_H1 = N_H1 / sum(N_H1);
        N_H0 = N_H0 / sum(N_H0);

        y_pdf_H1 = gaussian_pdf(X,m_H1(ii), s_H1(ii));
        y_pdf_H1 = y_pdf_H1 / sum(y_pdf_H1);
        plot(X,y_pdf_H1,'r','linewidth',3)

        y_pdf_H0 = gaussian_pdf(X,m_H0(ii), s_H0(ii));
        y_pdf_H0 = y_pdf_H0 / sum(y_pdf_H0);
        plot(X,y_pdf_H0,'linewidth',3)

        bar(X,[zeros(1,length(X)-length(N_H1)) N_H1])
        h = findobj(gca,'Type','patch');
        set(h,'FaceColor','r','EdgeColor','w','FaceAlpha',0.7)
        bar(X,[zeros(1,length(X)-length(N_H0)) N_H0])
        legend(['H_1; minX^2= ' num2str(mnX2_h1)], ...
            ['H_0; minX^2= ' num2str(mnX2_h0)],0)

        hold off
        xlabel('Metric Output')%,'fontsize',16)
        ylabel('Frequency')%,'fontsize',16)
        %set(gca,'fontsize',14)
        if length(tStr)>=ii && ~isempty(tStr{ii})
            title([tStr{ii}])%,'fontsize',16)
        end
    end
end

%% PLOT ROC CURVES
if plotOpt == 1 | plotOpt == 2 | plotOpt == 3
    plotROC = 1;
else
    plotROC = 0;
end
% pfa = 1e-7;
pd = sqrt(0.95);
if plotROC
    figure; hold on
end
colorVec = ['brgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkm'];
for ii = 1 : length(m_H0) %% for each metric row input
    thresh{ii} = linspace(m_H0(ii),m_H1(ii),150);
    if ii < 5
        linSpc = colorVec(ii);
    elseif ii < 10
        linSpc = [colorVec(ii) '--'];
    end
    [pdThresh(ii), Pfa{ii}, Pd{ii}] = mkROC(m_H0(ii),s_H0(ii),m_H1(ii),s_H1(ii),thresh{ii},linSpc,pd,plotROC);
    for jj = 1 : length(thresh{ii})
        PfaEmp{ii}(jj) = sum(H0data{ii} > thresh{ii}(jj)) / length(H0data{ii});
        PdEmp{ii}(jj) = sum(H1data{ii} > thresh{ii}(jj)) / length(H1data{ii});
    end
    if length(tStr)>=ii && ~isempty(tStr{ii})
        lgnd{ii} = tStr{ii};
    else
        lgnd{ii} = ['Metric ' num2str(ii)];
    end
end

if plotOpt == 1 | plotOpt == 2
    for ii = 1 : length(PdEmp)
        %% plot empirical ROC results (avoid legend order problem)
        linSpc = colorVec(ii);
        burdick(PfaEmp{ii},PdEmp{ii},[linSpc '--']);
    end
end

if plotROC
    legend(lgnd,0)
    hold off
end

StatMat = [m_H0; m_H1; s_H0; s_H1]';

% figure(hHist); hold on
% ax = axis;
% plot(-[pfaThresh pfaThresh],[ax(3) ax(4)],'k-x')
% hold off

return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% subfunction
function [mu_H1 sigma_H1 mnX2_H1 mu_H0 sigma_H0 mnX2_H0] = clipDataFit(H1data,H0data)

doPlot = 0;

%% H1
[cdf, X] = empiricalCDF(H1data);
muVec = linspace(-15,0,100); %% tune here
sigmaVec = linspace(1e-5,10,1000); %% tune here

X2 = zeros(length(muVec),length(sigmaVec)) + 1e5;
for mm = 1 : length(muVec)
    for nn = 1 : length(sigmaVec)
        [ncdf] = normcdf_nrk(X,muVec(mm),sigmaVec(nn)); ncdf = 1 - ncdf;
        X2(mm,nn) = sum((ncdf(2:end) - cdf(2:end)) .^ 2);
    end
end
[mnX2_H1 mnInd] = min(X2(:));
[muInd sigmaInd] = ind2sub([mm nn],mnInd);
if (muInd == 1) | (muInd == length(muVec)) |(sigmaInd == 1) | (sigmaInd == length(sigmaVec))
    error('Grid search out of bounds')
end
mu = muVec(muInd);
sigma = sigmaVec(sigmaInd);
[ncdf] = normcdf_nrk(X,mu,sigma); ncdf = 1 - ncdf;

if doPlot
    dX = diff(X);
    Xfull = 1.5*mu:dX(1):X(end);
    [fullcdf] = normcdf_nrk(Xfull,mu,sigma); fullcdf = 1 - fullcdf;
    cdfF = figure;
    subplot(2,1,1)
    hold on
    plot(Xfull,[zeros(1,length(Xfull)-length(cdf)) cdf])
    plot(Xfull,fullcdf,'r')
    hold off
    legend('Empirical CDF',['X^2 = ' num2str(mnX2_H1)],'Location','Best')
    xlabel('C_t [min]')
    ylabel('Cumulative Distribution')
    title('H_1 CDF Fit')
end
if doPlot
    figure; subplot(2,1,1); hold on
    title('H_1 CDF Fit')
    xlabel('C_t [min]')
    ylabel('Cumulative Distribution')
    plot(X,cdf)
    plot(X,ncdf,'r')
    hold off
    legend('Empirical CDF',['X^2 = ' num2str(mnX2_H1)],'Location','Best')
    subplot(2,1,2)
    imagesc(log10(X2))
    title(['Optimal \mu= ' num2str(mu) ' \sigma= ' num2str(sigma)])
    ylabel('\mu')
    xlabel('\sigma')
    xTick = str2num(get(gca,'XTickLabel'));
    yTick = str2num(get(gca,'YTickLabel'));
    xTick = round(sigmaVec(xTick)*100) / 100;
    yTick = round(muVec(yTick)*100) / 100;
    set(gca,'XTickLabel',xTick,'YTickLabel',yTick)
end
mu_H1 = mu;
sigma_H1 = sigma;

%% H0
[cdf, X] = empiricalCDF(H0data);
muVec = linspace(-75,-5,200); %% tune here
sigmaVec = linspace(1e-5,50,1000); %% tune here

X2 = zeros(length(muVec),length(sigmaVec)) + 1e5;
for mm = 1 : length(muVec)
    for nn = 1 : length(sigmaVec)
        [ncdf] = normcdf_nrk(X,muVec(mm),sigmaVec(nn)); ncdf = 1 - ncdf;
        X2(mm,nn) = sum((ncdf(2:end) - cdf(2:end)) .^ 2);
    end
end
[mnX2_H0 mnInd] = min(X2(:));
[muInd sigmaInd] = ind2sub([mm nn],mnInd);
if (muInd == 1) | (muInd == length(muVec)) |(sigmaInd == 1) | (sigmaInd == length(sigmaVec))
    error('Grid search out of bounds')
end
mu = muVec(muInd);
sigma = sigmaVec(sigmaInd);
[ncdf] = normcdf_nrk(X,mu,sigma); ncdf = 1 - ncdf;

if doPlot
    dX = diff(X);
    Xfull = min(1.5*mu,X(1)):dX(1):X(end);
    [fullcdf] = normcdf_nrk(Xfull,mu,sigma); fullcdf = 1 - fullcdf;
    figure(cdfF)
    subplot(2,1,2)
    hold on
    plot(Xfull,[zeros(1,length(Xfull)-length(cdf)) cdf])
    plot(Xfull,fullcdf,'r')
    hold off
    title('H_0 CDF Fit')
    xlabel('C_t [min]')
    ylabel('Cumulative Distribution')
    legend('Empirical CDF',['X^2 = ' num2str(mnX2_H0)],'Location','Best')
end
if doPlot
    figure; subplot(2,1,1); hold on
    title('H_0 CDF Fit')
    xlabel('C_t [min]')
    ylabel('Cumulative Distribution')
    plot(X,cdf)
    plot(X,ncdf,'r')
    hold off
    legend('Empirical CDF',['X^2 = ' num2str(mnX2_H0)],'Location','Best')
    subplot(2,1,2)
    imagesc(log10(X2))
    title(['Optimal \mu= ' num2str(mu) ' \sigma= ' num2str(sigma)])
    ylabel('\mu')
    xlabel('\sigma')
    xTick = str2num(get(gca,'XTickLabel'));
    yTick = str2num(get(gca,'YTickLabel'));
    xTick = round(sigmaVec(xTick)*100) / 100;
    yTick = round(muVec(yTick)*100) / 100;
    set(gca,'XTickLabel',xTick,'YTickLabel',yTick)
end
mu_H0 = mu;
sigma_H0 = sigma;

return
