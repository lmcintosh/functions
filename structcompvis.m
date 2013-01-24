function structcompvis(s1,s2)
% STRUCTCOMPVIS     Use visual differencing tool to compare two structures
%
% STRUCTCOMPVIS(s1,s2) opens an HTML differencing report comparing two 
% structures.  
%
% KNOWN ISSUE: If the longest field names of the 2 structures are different
% lengths, you may get very poor results.  I know this seems like a stupid
% restriction, but you'll understand why when you try it and look at my
% code.


% Scott Hirsch.  shirsch@mathworks.com
% Usual disclaimer applies - I wrote this for fun.  Feel free to pass along
% feedback, but no guarantees that I'll do anything!


% Write temp text files for structs
f1 = [tempdir 's1.m']
f2 = [tempdir 's2.m'];


% Sort structures, to ignore order
s1 = orderfields(s1);
s2 = orderfields(s2);

% Write structures to temp files
diary(f1);     % Create diary file
disp(s1)
diary off

diary(f2);     % Create diary file
disp(s2)
diary off

% Take a best guess at character width of structure display
lengthNames = max([size(char(fieldnames(s1)),2) size(char(fieldnames(s2)),2)]);
% lengthFields  % Too painful to get.
fieldWidth = floor(2*lengthNames);        % Change this if you like

% Use visual differencing report
visdiff(f1,f2,fieldWidth)

% Delete temp files.  Feel free to keep these.
delete(f1)
delete(f2)
