% Causal Influence in Stock Markets 
% This example program computes directed informations between the Hang Seng
% Index in China and Dow Jones Index in the US from 1990 to 2011 on a daily
% scale. The results show that Dow Jones Index has a significant causal
% influence on the Hang Seng Index but there is little in the reverse
% direction.

close all;
clear all;
clc

D=3; %CTW tree depth
year_shift=0.25; % the first portion is used only for training the CTW but not for calculating the actual DI 
st1='^HSI';st2='^DJI';year='1990';

[hist_date1, hist_high1, hist_low1, hist_open1, hist_close1, hist_vol1] =get_hist_stock_data(st1,year);
[hist_date2, hist_high2, hist_low2, hist_open2, hist_close2, hist_vol2] =get_hist_stock_data(st2,year);

stock1=zeros(size(hist_date1));
stock2=stock1;

i1=1;i2=1;j=0;
while (i1<length(hist_date1)) | (i2<length(hist_date2))
    str1=hist_date1{i1};
    str2=hist_date2{i2};
    if strcmp(str1,str2)
        j=j+1;
        if j==1 start_year=str2num(str1(1:4));end;%str2num(str1(1:4));end;
        stock1(j)=hist_close1(i1);
        stock2(j)=hist_close2(i2);
        i1=i1+1;i2=i2+1;
        end_year=str2num(str1(1:4));%str2num(str1(1:4));
    else
    a=str1>str2;
    b=str1<str2;
    t=a-b;
    [R,C,v] = find(t);  
        if v(1)==1
            i2=i2+1;
        elseif v(1)==-1
            i1=i1+1;
        end;
    end;
end;

%% Discretize the stock index into -1,0 and 1. Value -1 means the index goes down in one day by more than del (here is 0.008), value 1 means it goes up in one day by more than del, value 0 means the absolute change is less than del.
Nx=3;
del=0.008;
X=(2*(stock1(2:j)./stock1(1:j-1)<(1-del)))'+((stock1(2:j)./stock1(1:j-1))>(1+del))';
Y=(2*(stock2(2:j)./stock2(1:j-1)<(1-del)))'+((stock2(2:j)./stock2(1:j-1))>(1+del))';
n_data=length(X);

figure;
plot(linspace(start_year,end_year,j), stock1(1:j),'r');
hold on
plot(linspace(start_year,end_year,j),stock2(1:j),'b');
xlabel('Year');
title('Stock Market Index as Time Series');
legend(st1(2:end),st2(2:end),'Location','northwest');
axis([start_year,end_year, min(min(stock1),min(stock1)), 1.05*max(max(stock1),max(stock1))]  )
disp('---stock market index as time series plotted.')

figure;
max_y=0.22;
[B_MI, B_DI, B_rev_DI]=compute_DI_MI(X,Y,Nx,D,'E1',year_shift,0,0);
disp('---directed information estimator 1 calculated.')
actual_start_year=start_year+((end_year-start_year)*year_shift);
subplot(2,2,1)
plot(linspace(actual_start_year,end_year,length(B_MI)),B_MI./[1:length(B_MI)],'b');
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_DI./[1:length(B_DI)],'r');
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_rev_DI./[1:length(B_rev_DI)],'k');
axis([actual_start_year end_year -0.02 max_y]);
xlabel('Year');
legend('MI','DI','revDI');
title('Estimator 1');


[B_MI, B_DI, B_rev_DI]=compute_DI_MI(X,Y,Nx,D,'E2',year_shift,0,0);
disp('---directed information estimator 2 calculated.')
subplot(2,2,2)
plot(linspace(actual_start_year,end_year,length(B_MI)),B_MI./[1:length(B_MI)],'b')
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_DI./[1:length(B_DI)],'r')
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_rev_DI./[1:length(B_rev_DI)],'k')
title('Estimator 2')
axis([actual_start_year end_year -0.02 max_y])
xlabel('Year')
legend('MI','DI','revDI')

[B_MI, B_DI, B_rev_DI]=compute_DI_MI(X,Y,Nx,D,'E3',year_shift,0,0);
disp('---directed information estimator 3 calculated.')
subplot(2,2,3)
plot(linspace(actual_start_year,end_year,length(B_MI)),B_MI./[1:length(B_MI)],'b')
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_DI./[1:length(B_DI)],'r')
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_rev_DI./[1:length(B_rev_DI)],'k')
title('Estimator 3')
axis([actual_start_year end_year -0.02 max_y])
xlabel('Year')
legend('MI','DI','revDI')


[B_MI, B_DI, B_rev_DI]=compute_DI_MI(X,Y,Nx,D,'E4',year_shift,0,0);
disp('---directed information estimator 4 calculated.')
subplot(2,2,4)
plot(linspace(actual_start_year,end_year,length(B_MI)),B_MI./[1:length(B_MI)],'b');
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_DI./[1:length(B_DI)],'r');
hold on
plot(linspace(actual_start_year,end_year,length(B_MI)),B_rev_DI./[1:length(B_rev_DI)],'k');
title('Estimator 4');
axis([actual_start_year end_year -0.02 max_y]);
xlabel('Year');
legend('MI','DI','revDI');

