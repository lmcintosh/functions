% add path to functions folder
% addpath('~/Research/functions/');                       % useful helper functions

% add toolboxes
% toolboxes = {'arfit','circstat','fastICA','powerlawfit','SICE','signal processing'};
% for j = 1:length(toolboxes)
    % addpath(['~/Documents/toolbox/' toolboxes{j} '/']);
% end

% default figure properties
defaultfigureproperties;

% email preferences
setpref('Internet','E_mail','contact@niru.org');
setpref('Internet','SMTP_Server','mail');

% change directory
cd '~/Dropbox/'; ls;

% turn beep off
beep off;
