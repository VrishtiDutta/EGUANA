function [x3dc,y3dc,z3dc,phic,thetac]=HeadCorrectionVgivedata(x3dr,y3dr,z3dr,...
    numbercoil,x3d,y3d,z3d,phi,theta)

%project virtual points need to correct angles
[nax,nay,naz]=sph2cart(phi,theta,1);
napx=x3d+nax;
napy=y3d+nay;
napz=z3d+naz;




%data perparation
siz=size(x3d);
motionData=zeros([ siz(1),siz(2)*2 ,3 ]);
motionData(:,:,1)=[x3d,napx];
motionData(:,:,2)=[y3d,napy];
motionData(:,:,3)=[z3d,napz];

motionDataref=zeros([ 1, siz(2) , 3]);

motionDataref(:,:,1)=mean(x3dr);
motionDataref(:,:,2)=mean(y3dr);
motionDataref(:,:,3)=mean(z3dr);



%% head correction to bite plane

[transPar,RT,R,T,resid,us]=...
    pose_estimation(motionData(:,numbercoil,:),...
    motionDataref(1,numbercoil,:),3,0);

A=RT.position;

clear data  transPar RT R T resid us

motionDatacorrected=zeros(size(motionData(:,:,1:3)));

for i=1:length(motionData)
    B=squeeze(motionData(i,:,1:3))';
    C=squeeze(A(1:3,1:3,i));
    D=[squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i)),...
        squeeze(A(1:3,4,i))];
    
    motionDatacorrected(i,:,:)=((C')*B+D)';
    
end
x3dc = squeeze(motionDatacorrected(:,1:12,1));
y3dc = squeeze(motionDatacorrected(:,1:12,2));
z3dc = squeeze(motionDatacorrected(:,1:12,3));
napx = squeeze(motionDatacorrected(:,13:24,1));
napy = squeeze(motionDatacorrected(:,13:24,2));
napz = squeeze(motionDatacorrected(:,13:24,3));


% %% Rafael reference axes method to line to head coils in the y axes
% 
% %virtual meddle point of mastoids head coils, these point will be the
% %axes zero (point (0,0,0))
% MP=[x3dr(1,numbercoil(3))+x3dr(1,numbercoil(2)),...
%     y3dr(1,numbercoil(3))+y3dr(1,numbercoil(2)),...
%     z3dr(1,numbercoil(3))+z3dr(1,numbercoil(2))]/2;
% 
% %Reference axes calculation
% EPL=[x3dr(1,numbercoil(3)),y3dr(1,numbercoil(3)),z3dr(1,numbercoil(3))];
% EPR=[x3dr(1,numbercoil(2)),y3dr(1,numbercoil(2)),z3dr(1,numbercoil(2))];
% uyi=(EPL-EPR)';
% uy=uyi/norm(uyi);
% uzi=[0;0;1];
% uxi=cross(uy,uzi);
% ux=uxi/norm(uxi);
% uz=cross(ux,uy);
% AX=[ux,uy,uz];
% 
% %incialization of matrix that will save corrected data
% HCP=zeros(24,3,siz(1));
% 
% for i=1:siz(1)
%     P=[x3dci(i,1),y3dci(i,1),z3dci(i,1);
%         x3dci(i,2),y3dci(i,2),z3dci(i,2);
%         x3dci(i,3),y3dci(i,3),z3dci(i,3);
%         x3dci(i,4),y3dci(i,4),z3dci(i,4);
%         x3dci(i,5),y3dci(i,5),z3dci(i,5);
%         x3dci(i,6),y3dci(i,6),z3dci(i,6);
%         x3dci(i,7),y3dci(i,7),z3dci(i,7);
%         x3dci(i,8),y3dci(i,8),z3dci(i,8);
%         x3dci(i,9),y3dci(i,9),z3dci(i,9) ;
%         x3dci(i,10),y3dci(i,10),z3dci(i,10);
%         x3dci(i,11),y3dci(i,11),z3dci(i,11);
%         x3dci(i,12),y3dci(i,12),z3dci(i,12);
%         napxi(i,1),napyi(i,1),napzi(i,1);
%         napxi(i,2),napyi(i,2),napzi(i,2);
%         napxi(i,3),napyi(i,3),napzi(i,3);
%         napxi(i,4),napyi(i,4),napzi(i,4);
%         napxi(i,5),napyi(i,5),napzi(i,5);
%         napxi(i,6),napyi(i,6),napzi(i,6);
%         napxi(i,7),napyi(i,7),napzi(i,7);
%         napxi(i,8),napyi(i,8),napzi(i,8);
%         napxi(i,9),napyi(i,9),napzi(i,9) ;
%         napxi(i,10),napyi(i,10),napzi(i,10);
%         napxi(i,11),napyi(i,11),napzi(i,11);
%         napxi(i,12),napyi(i,12),napzi(i,12);
%         ];
%     
%     Rx=(P(:,1)-MP(1));
%     Ry=(P(:,2)-MP(2));
%     Rz=(P(:,3)-MP(3));
%     RelP=[Rx,Ry,Rz];
%     
%     %calculate corrected position
%     HCP(:,:,i)=RelP*AX;
%     
% end
% 
% x3dc=squeeze(HCP(1:12,1,:))';
% y3dc=squeeze(HCP(1:12,2,:))';
% z3dc=squeeze(HCP(1:12,3,:))';
% napx = squeeze(HCP(13:24,1,:))';
% napy = squeeze(HCP(13:24,2,:))';
% napz = squeeze(HCP(13:24,3,:))';

nax=napx-x3dc;
nay=napy-y3dc;
naz=napz-z3dc;

[phic,thetac,r]=cart2sph(nax,nay,naz);

end