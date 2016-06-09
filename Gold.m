function [x3dc,y3dc,z3dc,phic,thetac]=Gold(path,trial,...
    numbercoil,x3d,y3d,z3d,phi,theta,refmolarcoil)
%note ref coil: 1- frontal coil,2- rigth coil and 3- left coil

%creat path for reference position (bite plane trial)
if trial(length(trial)) ~= 'c' && trial(length(trial)) ~= 'r'
    for i = 1:(4-length(trial))
        path = strcat(path, '0');
    end
    path = strcat(path, trial,'.pos');
else
    for i = 1:(5-length(trial))
        path = strcat(path, '0');
    end
    path = strcat(path, trial,'.pos');
end

if fopen(path,'r') == -1
    questdlg('File does not exist.  Please ensure Bite Trial is correct.',...
        'ERROR','OK','OK');
    x3dc=x3d;
    y3dc=y3d;
    z3dc=z3d;
    phic=phi;
    thetac=theta;
else
     
    %load reference data (bite plane)
    f = fopen(path, 'r');
    data = fread(f,[84 inf], 'single');
    data = data';
    xref=mean([data(:,1),data(:,8),data(:,15),data(:,22),data(:,29),...
        data(:,36),data(:,43),data(:,50),data(:,57),data(:,64),...
        data(:,71),data(:,78)]);
    
    yref=mean([data(:,2),data(:,9),data(:,16),data(:,23),data(:,30),...
        data(:,37),data(:,44),data(:,51),data(:,58),data(:,65),...
        data(:,72),data(:,79)]);
    
    zref=mean([data(:,3),data(:,10),data(:,17),data(:,24),data(:,31),...
        data(:,38),data(:,45),data(:,52),data(:,59),data(:,66),...
        data(:,73),data(:,80)]);
   
    %%%%%%%%%%%%%%%%%%
    %figure
    %plot3([xref(1,refmolarcoil(1)),xref(1,refmolarcoil(2)),xref(1,refmolarcoil(3))],[yref(1,refmolarcoil(1)),yref(1,refmolarcoil(2)),yref(1,refmolarcoil(3))],[zref(1,refmolarcoil(1)),zref(1,refmolarcoil(2)),zref(1,refmolarcoil(3))]);
    %%%%%%%%%%%%%%%%%%
    
    %% Rafael reference axes method to line to head coils in the y axes
    
    %virtual meddle point of mastoids head coils, these point will be the
    %axes zero (point (0,0,0))
    MP=[xref(1,numbercoil(3))+xref(1,numbercoil(2)),...
        yref(1,numbercoil(3))+yref(1,numbercoil(2)),...
        zref(1,numbercoil(3))+zref(1,numbercoil(2))]/2;
    
    %Reference axes calculation
    EPL=[xref(1,numbercoil(3)),yref(1,numbercoil(3)),zref(1,numbercoil(3))];
    EPR=[xref(1,numbercoil(2)),yref(1,numbercoil(2)),zref(1,numbercoil(2))];
    uyi=(EPL-EPR)';%vector left to right
    uy=uyi/norm(uyi);
    uzi=[0;0;1];
    uxi=cross(uy,uzi);
    ux=uxi/norm(uxi);
    uz=cross(ux,uy);
    AX=[ux,uy,uz];
    
    %figure 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %figure, hold all
    %plot3([0 ux(1)],[0 ux(2)],[0 ux(3)])
    %plot3([0 uy(1)],[0 uy(2)],[0 uy(3)])
    %plot3([0 uz(1)],[0 uz(2)],[0 uz(3)])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    P=[xref(refmolarcoil(1)),yref(refmolarcoil(1)),zref(refmolarcoil(1));
       xref(refmolarcoil(2)),yref(refmolarcoil(2)),zref(refmolarcoil(2));
       xref(refmolarcoil(3)),yref(refmolarcoil(3)),zref(refmolarcoil(3))];
    Rx=(P(:,1)-MP(1));
    Ry=(P(:,2)-MP(2));
    Rz=(P(:,3)-MP(3));
    RelP=[Rx,Ry,Rz];  
    HCP=RelP*AX;
    
    Rx=HCP(1:3,1)';
    Ry=HCP(1:3,2)';
    Rz=HCP(1:3,3)';
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %figure
    %plot3(Rx(:),Ry(:),Rz(:))
    %hold on
    %plot3([xref(1,refmolarcoil(1)),xref(1,refmolarcoil(2)),xref(1,refmolarcoil(3))],[yref(1,refmolarcoil(1)),yref(1,refmolarcoil(2)),yref(1,refmolarcoil(3))],[zref(1,refmolarcoil(1)),zref(1,refmolarcoil(2)),zref(1,refmolarcoil(3))]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %% put jaw reference coils in x-y plane
    C8C10=[Rx(2)-Rx(1),Ry(2)-Ry(1),Rz(2)-Rz(1)];
    C8C9=[Rx(3)-Rx(1),Ry(3)-Ry(1),Rz(3)-Rz(1)];
    JPN=cross(C8C9,C8C10);%JAW PLANE PERPENDICULAR VECTOR
    JPN=JPN/norm(JPN);
    PROJ=[-1;0;JPN(1)/JPN(3)];% vector related to interception of JAW plane with sagital plane
    nPROJ=norm(PROJ);
    r10=norm(C8C10);%distance of midle ref coil to molar coil
    r9=norm(C8C9);
    alfa10=acos(C8C10*PROJ/(r10*nPROJ));
    alfa9=acos(C8C9*PROJ/(r9*nPROJ));
    %
    RJAW1=[0,0,0];
    RJAW2=[-r10*cos(alfa10),-r10*sin(alfa10),0];
    RJAW3=[-r9*cos(alfa9),r9*sin(alfa9),0];
    
    %%%%%%%%%%%%%%%%%%%
    %figure
    %plot3([RJAW1(1),RJAW2(1),RJAW3(1)],[RJAW1(2),RJAW2(2),RJAW3(2)],[RJAW1(3),RJAW2(3),RJAW3(3)])
    %figure
    %plot3([0 PROJ(1)],[0 PROJ(2)],[0 PROJ(3)])
    %%%%%%%%%%%%%%%%%%%%%
    
    %% Correct with pose estimation
    
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
    
    motionDataref=zeros([ 1, 3, 3]);
    motionDataref(1,1,:)=RJAW1;
    motionDataref(1,2,:)=RJAW2;
    motionDataref(1,3,:)=RJAW3;
    
    %pose estimation
    [transPar,RT,R,T,resid,us]=...
        pose_estimation(motionData(:,refmolarcoil,:),motionDataref,3,0);
    
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
        
        motionDatacorrected(i,:,:)=(C*B+D)';
        
    end
    x3dc = squeeze(motionDatacorrected(:,1:12,1));
    y3dc = squeeze(motionDatacorrected(:,1:12,2));
    z3dc = squeeze(motionDatacorrected(:,1:12,3));
    napx = squeeze(motionDatacorrected(:,13:24,1));
    napy = squeeze(motionDatacorrected(:,13:24,2));
    napz = squeeze(motionDatacorrected(:,13:24,3));
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;

   [phic,thetac,r]=cart2sph(nax,nay,naz);
        
end