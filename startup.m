% default figure properties
defaultfigureproperties;

% email preferences
setpref('Internet','E_mail','contact@niru.org');
setpref('Internet','SMTP_Server','mail');

% turn beep off
beep off;

% load shortcuts
load shortcuts;

% number format
format short g

% Add additional directories to the path
setenv('PATH', [getenv('PATH') ':/usr/local/bin:/usr/texbin']);

% change directory
cd '~/Dropbox/'; %ls; whos;
