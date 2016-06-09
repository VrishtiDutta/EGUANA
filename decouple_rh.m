function [newx,newy]=decouple_rh(signal1x,signal1y,signaljx,signaljy,rate)

%Rafael Henriques 31/08/11

%Westbury citation: ' angle=.52*xp -> where by convention, numerical 
%                    values for xp are adjusted to a range negatively,
%                    from a high value of zero when the jaw is most closed 
%                    to some negative value when the jaw is most open.
% xp is the principal componet of jaw motion between 


angpar=0.52; % 0.52 is the defaut

%principal component
temp(:,1)=signaljx;
temp(:,2)=signaljy;
signaljpc=pca_pvl1rh(temp);


jcoefs=corrcoef(signaljy,signaljpc);

if jcoefs(1,2) < 0
   signaljpc=signaljpc*(-1); 
end

%if mintemp > 0
%    signaljpc=signaljpc*(-1);
%end

%maximun have to be zero
rp=max(signaljpc);
xp=signaljpc-rp;
angle=angpar*xp;%degrees
angle=angle*pi/180;%radians

lenSig=length(signaljx);
newx=zeros(lenSig,1);
newy=zeros(lenSig,1);


for i=1:lenSig
    newx(i)=((signal1x(i)-signaljx(i))*cos(angle(i)))+((signal1y(i)-signaljy(i))*sin(angle(i)));
    newy(i)=((signal1y(i)-signaljy(i))*cos(angle(i)))-((signal1x(i)-signaljx(i))*sin(angle(i)));
end


     
