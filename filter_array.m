% filter_array.m
%
% function file voor filteren met verwijdering van de inslinger-effecten 
% Fs is de sample frequentie
% Fcl is de (hoge) afkapfrequentie 
% Fch is de (lage) doorlaatfrequentie
% 
% Syntax:  [x]=filter_array(x,Fs,Fcl,Fch)

function [x]=filter_array(x,Fs,Fcl,Fch);

Fs=Fs./2;

% make cyclic
n1=length(x);
n2=fix(n1/2);
for i=1:n1,
   y(i+n2)=x(i);
end
for i=1:n2,
   y(n2-i+1)=x(i);
   y(n1+n2+i)=x(n1-i+1);
end

%filter
smooth = y;

if (Fcl ~= 0)
   [B,A]=butter(5,Fcl/Fs);           %7e orde october 2000; changed to 5th order July 2010 PvL
   smooth = filtfilt(B,A,y);
end

y = smooth;

if (Fch ~=0)
   [B,A]=butter(5,Fch/Fs,'High');     %5e orde sept '03
   smooth = filtfilt(B,A,y);
end

for i=1:n1,
   x(i)=smooth(i+n2);
end
