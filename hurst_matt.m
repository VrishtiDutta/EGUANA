function [hurst] = hurst_matt(d,str)   % data set

%[filename,PathName] = uigetfile('*.txt','Select a file');
%data0=load([PathName '\' filename]);
%plot(data0);
% Based on estimate_hurst_exponent: This algorithm is far faster than a full-blown implementation of Hurst's
% algorithm.  I got the idea from a 2000 PhD dissertation by Hendrik J 
% Blok, and I make no guarantees whatsoever about the rigor of this approach
% or the accuracy of results.  Use it at your own risk.
%
% Bill Davidson
% 21 Oct 2003

data0=d';
data=data0;         % make a local copy


[M,npoints]=size(data0);

yvals=zeros(1,npoints);
xvals=zeros(1,npoints);
data2=zeros(1,npoints);

index=0;
binsize=1;

while npoints>4
    
    y=std(data);
    index=index+1;
    xvals(index)=binsize;
    yvals(index)=binsize*y;
    
    npoints=fix(npoints/2);
    binsize=binsize*2;
    for ipoints=1:npoints % average adjacent points in pairs
        data2(ipoints)=(data(2*ipoints)+data((2*ipoints)-1))*0.5;
    end
    data=data2(1:npoints);
    
end % while

xvals=xvals(1:index);
yvals=yvals(1:index);


logx=log(xvals);
logy=log(yvals);
%title1 = strcat(['log-log plot for relative phase of signals: ' str]);
%figure;
%plot(logx,logy);
%title(title1);
%xlabel('log x');
%ylabel('log y');
p2=polyfit(logx,logy,1);
hurst=p2(1); % Hurst exponent is the slope of the linear fit of log-log plot

