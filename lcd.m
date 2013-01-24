function lcdOut = lcd(d1,d2)

%% find lowest common denominator 

lcdOut = d1 * d2;

for ii = min([d1,d2]) : lcdOut    
    if (rem(ii,d1) == 0) && (rem(ii,d2) == 0)        
        lcdOut = ii;        
        return        
    end
end
        
