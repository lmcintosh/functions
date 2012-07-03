% adds shortcut to shortcuts mat file
% Niru Maheswaranathan
% Mon Jul  2 23:53:25 2012

function addshortcut(str)
eval([str ' = pwd;']);
eval(['save(''~/Documents/Code/functions/shortcuts.mat'', ''' str ''', ''-append'');']);
