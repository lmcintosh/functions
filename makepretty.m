%% better plotting function
%  Niru Maheswaranathan
%  3 Feb 2012

function makepretty(varargin)

    set(gca,'TickDir','out','Box','off');
    grid on;
    %set(gca,'FontName', 'Helvetica','FontSize',14,'FontWeight','bold');
    %set([hTitle, hXLabel, hYLabel], ...
        %'FontName'   , 'AvantGarde');
    %set([hXLabel, hYLabel]  , ...
        %'FontSize'   , 14          );
    %set( hTitle                    , ...
        %'FontSize'   , 18          , ...
        %'FontWeight' , 'bold'      );

    set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.01 .01] , ...
    'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'off'      , ...
    'XGrid'       , 'off'      , ...
    'LineWidth'   , 1         );
    %'YMinorGrid'  , 'on'      , ...
    %'XMinorGrid'  , 'on'      , ...
    %'XColor'      , 0.8*ones(1,3), ...
    %'YColor'      , 0.8*ones(1,3), ...
