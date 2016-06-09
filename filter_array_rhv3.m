% filter_array.m
%
% function file voor filteren met verwijdering van de inslinger-effecten 
% Fs is de sample frequentie
% Fcl is de (hoge) afkapfrequentie 
% Fch is de (lage) doorlaatfrequentie
% 
% Syntax:  [x]=filter_array(x,Fs,Fcl,Fch)

%last updata: fast performance (by Rafael H)

function [x, xlp]=filter_array_rhv3(x,Fs,Fcl,Fch)

Fs=Fs./2;

% make cyclic
n1=length(x);
n2=fix(n1/2);
y=zeros(n2*2+n1+1,1);
% for i=1:n1,
%    y(i+n2)=x(i);
% end

y(n2+1:n2+n1,1)=x;
y(1:n2,1)=x(n2:-1:1);
y(n2+n1+1:n2*2+n1+1,1)=x(n1:-1:n1-n2);

% for i=1:n2,
%    y(n2-i+1)=x(i);
%    y(n1+n2+i)=x(n1-i+1);
% end


%filter
smooth = y;

if (Fcl ~= 0)
   [B,A]=butter(7,Fcl/Fs);           %7e orde october 2000
   smooth = filtfilt(B,A,y);
end

y = smooth;

if nargout>1
    xlp(1:n1,1)=smooth(n2+1:n2+n1,1);
end

if (Fch ~=0)
   [B,A]=butter(7,Fch/Fs,'High');     %7e orde sept '03
   smooth = filtfilt(B,A,y);
end

% for i=1:n1,
%    x(i)=smooth(i+n2);
% end

x(1:n1,1)=smooth(n2+1:n2+n1,1);