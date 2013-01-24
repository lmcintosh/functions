function addSubs(direct)
%%
%  add directory (string) and all sub-folders to path
%%
%  nrk 2/2004
%%

m = dir(direct);

for aa = 1 : length(m)      %% start with real files    
    if m(aa).isdir        
        %% account for '.'
        if length(m(aa).name) == 1            
            if m(aa).name ~= '.'                
                subPath = [direct filesep m(aa).name];        
                addSubs(subPath)                
            end        
        %% accoutn for '..'    
        elseif length(m(aa).name) == 2            
            if m(aa).name ~= '..'                
                subPath = [direct filesep m(aa).name];        
                addSubs(subPath)                
            end            
        %% accoutn for '.svn'    
        elseif length(m(aa).name) == 4            
            if m(aa).name ~= '.svn'                
                subPath = [direct filesep m(aa).name];        
                addSubs(subPath)                
            end
        else            
            subPath = [direct filesep m(aa).name];        
            addSubs(subPath)            
        end            
    end      
end    

%% parent folders get path preference by being added last
addpath(direct) 

