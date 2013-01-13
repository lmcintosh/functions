% removes shortcut from mat file
% Niru Maheswaranathan
% Mon Sep 17 20:07:21 2012

function removeshortcut(str)
eval(['clearvars -except str; load shortcuts; clear ' str ';']);
fprintf(['Removed ' str ' from shortcuts.\n']);
save('~/Documents/Code/functions/shortcuts.mat');
clear; load shortcuts;
