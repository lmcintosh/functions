function [Pfa, Pd] = metricPerf(metricMat,H1inds,H0inds,plotOpt,tStr)
%% metricMat: row matrix containing metric output
%% H1inds: vector indicies of H1 events in metric output
%% H0inds: vector indicies of H0 events in metric output
%% plotOpt: plotting option (0 1 2 or 3)
%% tStr: title string (cell array for each row in metricMat


if exist('tStr') ~= 1
    tStr = cell(1,size(metricMat,1));
end

if ~isempty(H1inds) & ~isempty(H0inds)

    doRig = 1;

    for ii = 1 : size(metricMat,1)

        metric = metricMat(ii,:);

        loMet = min(metric);
        hiMet = max(metric);
        
        if loMet == hiMet
            continue
        end

        %% PLOT METRIC OUTPUT
        if plotOpt == 1
            figure; hold on
            plot(metric)
            plot(H1inds,metric(H1inds),'ro')
            plot(H0inds,metric(H0inds),'bo')
            hold off
            xlabel('Sample Number','fontsize',16)
            ylabel('Metric Output','fontsize',16)
            legend('Data','H_1 Data','H_0 Data',0)
            set(gca,'fontsize',14)
            if ~isempty(tStr)
                title([tStr{ii}],'fontsize',16)
            end
        end

        %% PLOT H1 and H0        
        edgeBuf = (hiMet - loMet) * 0.1;
        X = [loMet-edgeBuf hiMet+edgeBuf];
        N = 50;
        X = linspace(X(1),X(2),N); %% define bins
        [N_H1] = hist(metric(H1inds),X);
        [N_H0] = hist(metric(H0inds),X);

        if doRig
            m_H0(ii) = (N_H0 * X') / (sum(N_H0));
            m_H1(ii) = (N_H1 * X') / (sum(N_H1));
            s_H0(ii) = sqrt(((X - m_H0(ii)).^2) * (N_H0' / sum(N_H0)));
            s_H1(ii) = sqrt(((X - m_H1(ii)).^2) * (N_H1' / sum(N_H1)));
        else
            m_H1(ii) = mean(metric(H1inds));
            m_H0(ii) = mean(metric(H0inds));
            s_H1(ii) = std(metric(H1inds));
            s_H0(ii) = std(metric(H0inds));
        end

        if plotOpt == 1 | plotOpt == 2
            hHist = figure; hold on
             
            %% normalize histogram output
            N_H1 = N_H1 / sum(N_H1(1:end-1).*diff(X));            
            N_H0 = N_H0 / sum(N_H0(1:end-1).*diff(X));            
            
            y_pdf_H1 = gaussian_pdf(X,m_H1(ii), s_H1(ii));
            y_pdf_H1 = y_pdf_H1 * (max(N_H1) / max(y_pdf_H1));
            plot(X,y_pdf_H1,'r','linewidth',3)

            y_pdf_H0 = gaussian_pdf(X,m_H0(ii), s_H0(ii));
            y_pdf_H0 = y_pdf_H0 * (max(N_H0) / max(y_pdf_H0));
            plot(X,y_pdf_H0,'linewidth',3)                  
            
            bar(X,N_H1)
            h = findobj(gca,'Type','patch');
            set(h,'FaceColor','r','EdgeColor','w','FaceAlpha',0.7)
            bar(X,N_H0)
            legend('H_1','H_0',0)

            hold off
            xlabel('Metric Output','fontsize',16)
            ylabel('Frequency','fontsize',16)
            set(gca,'fontsize',14)
            if ~isempty(tStr)
                title([tStr{ii}],'fontsize',16)
            end
        end
    end

    %% PLOT ROC CURVES
    if plotOpt == 1 | plotOpt == 2 | plotOpt == 3
        plotROC = 1;
    else
        plotROC =0;
    end
    pfa = 1e-4;
    if plotROC        
        figure; hold on
    end
    colorVec = ['brgkmbrgkmbrgkmbrgkmbrgkmbrgkmbrgkm'];
    for ii = 1 : length(m_H0) %% for each metric row input
        thresh = linspace(m_H0(ii),m_H1(ii),150);
        linSpc = colorVec(ii);
        [pfaThresh, Pfa{ii}, Pd{ii}] = mkROC(m_H0(ii),s_H0(ii),m_H1(ii),s_H1(ii),thresh,linSpc,pfa,plotROC);
        lgnd{ii} = ['Metric ' num2str(ii)];
    end
    if plotROC
        legend(lgnd,0)
        hold off
    end

    
    % figure(hHist); hold on
    % ax = axis;
    % plot(-[pfaThresh pfaThresh],[ax(3) ax(4)],'k-x')
    % hold off

else

    figure
    plot(metricMat')

end

return

