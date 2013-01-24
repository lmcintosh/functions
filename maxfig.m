function maxfig(varargin)
%% maximize current figure

if size(varargin) == 0
   h = gcf; 
else
    h = varargin{:};
end

p = 1 - 0.95; %% gap fraction

scrdim = get(0, 'ScreenSize');
set(h,'OuterPosition', ... 
    [p*scrdim(3) p*scrdim(4) (1 - 2*p)*(scrdim(3)-100) (1 - 2*p)*scrdim(4)]) %% maximize

figure(h)

