function [x,y,H]=hurst_larry_rafael(sig)

% len=length(sig);
% 
% winMin = 4;
% winMax = round(len / 4);
% 
% winSize=winMin:winMax;
% nw=length(winSize);
% 
% x=winSize;
% y=zeros(1,nw);
% 
% for i = 1 : nw
% 	nWin = floor(len / winSize(i));
% 	last = nWin * winSize(i);
% 	v_nW = reshape(sig(1:last), winSize(i), nWin);
% 	
%     R=max(v_nW)-min(v_nW);
%     S=std(v_nW);
%     
%     y(i)=mean(R)/mean(S);
% 	
% end
% 
% logx=log(x);
% logy=log(y);
% 
% p=polyfit(logx,logy,1); 
% H=p(1);

len=length(sig);

winMin = 4;
winMax = round(len / 4);

winSize=winMin:winMax;
nw=length(winSize);

x=winSize;
y=zeros(1,nw);

for i = 1 : nw
	nWin = floor(len / winSize(i));
	last = nWin * winSize(i);
	v_nW = reshape(sig(1:last), winSize(i), nWin);
	
    yn=zeros(size(v_nW));
    for j = 1:nWin
        medias=mean(v_nW);
        yn(:,j)=cumsum(v_nW(:,j)-medias(j));
    end
    
    R=max(yn)-min(yn);
    
    %R=max(v_nW)-min(v_nW);
    S=std(v_nW);
    
    y(i)=mean(R)/mean(S);
	
end

logx=log(x);
logy=log(y);

p=polyfit(logx,logy,1); 
H=p(1);