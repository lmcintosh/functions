function timeStr = time_nrk
%% hours:minutes:seconds

clk = clock;


timeStr = [num2str(clk(4)) ':' num2str(clk(5)) ':' ...
    num2str(round(clk(6)))];