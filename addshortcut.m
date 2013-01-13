% adds shortcut to shortcuts mat file
% Niru Maheswaranathan
% Mon Jul  2 23:53:25 2012
% addshortcut(str)

function addshortcut(str)
eval([str ' = pwd;']);
fprintf(['Saved ' pwd ' as shortcut ' str '.\n']);
eval(['save(''~/Documents/Code/functions/shortcuts.mat'', ''' str ''', ''-append'');']);
