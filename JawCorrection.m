function [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection(...
    numbercoil, x3d,y3d,z3d,phi,theta,sel,...
    path,Rest_trial,numbercoilhead)

%sel is to select the simplified vertion 0 or the more complex vertion with
% bite and resting correct



%project virtual points need to correct angles
[nax,nay,naz]=sph2cart(phi,theta,1);
napx=x3d+nax;
napy=y3d+nay;
napz=z3d+naz;

if (nargin<8)
    sel = 0 ;
    questdlg('simpled vertion of correction','warning','OK','OK');
else
    %%
    pathrest=path;
     
    %creat path for reference position (rest plane trial)
    if Rest_trial(length(Rest_trial)) ~= 'c' && Rest_trial(length(Rest_trial)) ~= 'r'
        for i = 1:(4-length(Rest_trial))
            pathrest = strcat(pathrest, '0');
        end
        pathrest = strcat(pathrest, Rest_trial,'.pos');
    else
        for i = 1:(5-length(Rest_trial))
            pathrest = strcat(pathrest, '0');
        end
        pathrest = strcat(pathrest, Rest_trial,'.pos');
    end
      
    if fopen(pathrest,'r') == -1
        msg={'File does not exist.  Please ensure Rest position Trial is correct.'...
            ,'jaw correction will be done in a simple vertion,',...
            'without bite and resting position files'};
        questdlg(msg,'ERROR','OK','OK');
        
        sel=0;
    end
end


     %% Jaw correction acording to simple or bite & Rest position files
     %% correction
if (sel==0)
    %% simple correction
    
    
    le=size(phi,1);
    JCP=zeros(24,3,le);
    %correction with head coils
    for i=1:le
        P=[x3d(i,1),y3d(i,1),z3d(i,1);
            x3d(i,2),y3d(i,2),z3d(i,2);
            x3d(i,3),y3d(i,3),z3d(i,3);
            x3d(i,4),y3d(i,4),z3d(i,4);
            x3d(i,5),y3d(i,5),z3d(i,5);
            x3d(i,6),y3d(i,6),z3d(i,6);
            x3d(i,7),y3d(i,7),z3d(i,7);
            x3d(i,8),y3d(i,8),z3d(i,8);
            x3d(i,9),y3d(i,9),z3d(i,9) ;
            x3d(i,10),y3d(i,10),z3d(i,10);
            x3d(i,11),y3d(i,11),z3d(i,11);
            x3d(i,12),y3d(i,12),z3d(i,12);
            napx(i,1),napy(i,1),z3d(i,1);
            napx(i,2),napy(i,2),napz(i,2);
            napx(i,3),napy(i,3),napz(i,3);
            napx(i,4),napy(i,4),napz(i,4);
            napx(i,5),napy(i,5),napz(i,5);
            napx(i,6),napy(i,6),napz(i,6);
            napx(i,7),napy(i,7),napz(i,7);
            napx(i,8),napy(i,8),napz(i,8);
            napx(i,9),napy(i,9),napz(i,9) ;
            napx(i,10),napy(i,10),napz(i,10);
            napx(i,11),napy(i,11),napz(i,11);
            napx(i,12),napy(i,12),napz(i,12);
            ];
        JP=[x3d(i,numbercoil(1)),y3d(i,numbercoil(1)),z3d(i,numbercoil(1))];
        EPL=[x3d(i,numbercoil(3)),y3d(i,numbercoil(3)),z3d(i,numbercoil(3))];
        EPR=[x3d(i,numbercoil(2)),y3d(i,numbercoil(2)),z3d(i,numbercoil(2))];
        [JCP(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phi(i,numbercoil(1)),theta(i,numbercoil(1)));
        
    end
    
    x3dc=squeeze(JCP(1:12,1,:))';
    y3dc=squeeze(JCP(1:12,2,:))';
    z3dc=squeeze(JCP(1:12,3,:))';
    napx = squeeze(JCP(13:24,1,:))';
    napy = squeeze(JCP(13:24,2,:))';
    napz = squeeze(JCP(13:24,3,:))';
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;
    
    [phic,thetac,r]=cart2sph(nax,nay,naz);
    
elseif(sel==1)
    p={ 'angle to correct phi direction of front jaw coil (rad)',...
        'angle to correct theta direction of front jaw coil (rad)'};
t='Input data';
def = {'0','0'};

r=inputdlg(p,t,1,def);

phical=eval(r{1});
thetacal=eval(r{2});

     le=size(phi,1);
    JCP=zeros(24,3,le);
    %correction with head coils
    for i=1:le
        P=[x3d(i,1),y3d(i,1),z3d(i,1);
            x3d(i,2),y3d(i,2),z3d(i,2);
            x3d(i,3),y3d(i,3),z3d(i,3);
            x3d(i,4),y3d(i,4),z3d(i,4);
            x3d(i,5),y3d(i,5),z3d(i,5);
            x3d(i,6),y3d(i,6),z3d(i,6);
            x3d(i,7),y3d(i,7),z3d(i,7);
            x3d(i,8),y3d(i,8),z3d(i,8);
            x3d(i,9),y3d(i,9),z3d(i,9) ;
            x3d(i,10),y3d(i,10),z3d(i,10);
            x3d(i,11),y3d(i,11),z3d(i,11);
            x3d(i,12),y3d(i,12),z3d(i,12);
            napx(i,1),napy(i,1),z3d(i,1);
            napx(i,2),napy(i,2),napz(i,2);
            napx(i,3),napy(i,3),napz(i,3);
            napx(i,4),napy(i,4),napz(i,4);
            napx(i,5),napy(i,5),napz(i,5);
            napx(i,6),napy(i,6),napz(i,6);
            napx(i,7),napy(i,7),napz(i,7);
            napx(i,8),napy(i,8),napz(i,8);
            napx(i,9),napy(i,9),napz(i,9) ;
            napx(i,10),napy(i,10),napz(i,10);
            napx(i,11),napy(i,11),napz(i,11);
            napx(i,12),napy(i,12),napz(i,12);
            ];
        JP=[x3d(i,numbercoil(1)),y3d(i,numbercoil(1)),z3d(i,numbercoil(1))];
        EPL=[x3d(i,numbercoil(3)),y3d(i,numbercoil(3)),z3d(i,numbercoil(3))];
        EPR=[x3d(i,numbercoil(2)),y3d(i,numbercoil(2)),z3d(i,numbercoil(2))];
        [JCP(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phi(i,numbercoil(1))-phical,theta(i,numbercoil(1))-thetacal);
        
    end
    
    x3dc=squeeze(JCP(1:12,1,:))';
    y3dc=squeeze(JCP(1:12,2,:))';
    z3dc=squeeze(JCP(1:12,3,:))';
    napx = squeeze(JCP(13:24,1,:))';
    napy = squeeze(JCP(13:24,2,:))';
    napz = squeeze(JCP(13:24,3,:))';
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;
    
    [phic,thetac,r]=cart2sph(nax,nay,naz);
    
else %  (sel=2)
   
    %%  bite & Rest position files correction vertion
    % corrects head motion of Reting Position Trial
    % to calibrate the horizontal jaw phi and theta angle
    
    le=size(phi,1);
    
    %load reference data (Bite plane)
    xref1=mean(x3d);
    yref1=mean(y3d);
    zref1=mean(z3d);
        
    motionDatarefbite(:,:,1)=xref1;
    motionDatarefbite(:,:,2)=yref1;
    motionDatarefbite(:,:,3)=zref1;
    
    %load resting position data to correct the angle
    f2 = fopen(pathrest, 'r');
    data = fread(f2,[84 inf], 'single');
    data = data';
    xrest=mean([data(:,1),data(:,8),data(:,15),data(:,22),data(:,29),...
        data(:,36),data(:,43),data(:,50),data(:,57),data(:,64),...
        data(:,71),data(:,78)]);
    
    yrest=mean([data(:,2),data(:,9),data(:,16),data(:,23),data(:,30),...
        data(:,37),data(:,44),data(:,51),data(:,58),data(:,65),...
        data(:,72),data(:,79)]);
    
    zrest=mean([data(:,3),data(:,10),data(:,17),data(:,24),data(:,31),...
        data(:,38),data(:,45),data(:,52),data(:,59),data(:,66),...
        data(:,73),data(:,80)]);
    
    phirest=mean([data(:,4),data(:,11),data(:,18),data(:,25),data(:,32),...
        data(:,39),data(:,46),data(:,53),data(:,60),data(:,67),...
        data(:,74),data(:,81)])*pi/180;
    
    thetarest=mean([data(:,5),data(:,12),data(:,19),data(:,26),data(:,33),...
        data(:,40),data(:,47),data(:,54),data(:,61),data(:,68),...
        data(:,75),data(:,82)])*pi/180;
    
    
    % pose estimation to correcte the cal angle
    motionDataRest(:,:,1)=xrest;
    motionDataRest(:,:,2)=yrest;
    motionDataRest(:,:,3)=zrest;
    
    [transPar,RT,R,T,resid,us]=...
        pose_estimation(motionDataRest(1,numbercoilhead,:),...
        motionDatarefbite(1,numbercoilhead,:),3,0);
    
    A=RT.position;
    
    clear data  transPar RT R T resid us
    
    % virtual point to correct angle of jaw
    [njax,njay,njaz]=sph2cart(phirest(numbercoil(1)),thetarest(numbercoil(1)),1);
    njapx=xrest(numbercoil(1))+njax;
    njapy=yrest(numbercoil(1))+njay;
    njapz=zrest(numbercoil(1))+njaz;
    
    
    %correct the angle
    B=[xrest(numbercoil(1)), yrest(numbercoil(1)), zrest(numbercoil(1));
        njapx, njapy, njapz];
    
    C=squeeze(A(1:3,1:3,1));
    D=[squeeze(A(1:3,4,1)),...
        squeeze(A(1:3,4,1))];
    motionDatajanglecorrected=B*(C')+D';
    
    xjaw=motionDatajanglecorrected(1,1);
    xjawv=motionDatajanglecorrected(2,1);
    yjaw=motionDatajanglecorrected(1,2);
    yjawv=motionDatajanglecorrected(2,2);
    zjaw=motionDatajanglecorrected(1,3);
    zjawv=motionDatajanglecorrected(2,3); 
     
    [phical,thetacal,r]=cart2sph(xjawv-xjaw,yjawv-yjaw,zjawv-zjaw);
    if((xjawv-xjaw)<0)
        [xt,yt,zt]=sph2cart(phical,thetacal,-1);
        [phical,thetacal,r]=cart2sph(xt,yt,zt);
    end
        
    if (phical<0)
        phical=phical+2*pi;
    end
    if (thetacal<0)
        thetacal=thetacal+2*pi;
    end
    
    
    %% correct correct data to head correction data
    
        
    %project virtual points need to correct angles
    [nax,nay,naz]=sph2cart(phi,theta,1);
    napx=x3d+nax;
    napy=y3d+nay;
    napz=z3d+naz;
    
    phij=phi(:,numbercoil(1));
    thetaj=theta(:,numbercoil(1));
    
    % jaw correction rafael' method
    JCP=zeros(24,3,le);
    for i=1:le
        P=[x3d(i,1),y3d(i,1),z3d(i,1);
            x3d(i,2),y3d(i,2),z3d(i,2);
            x3d(i,3),y3d(i,3),z3d(i,3);
            x3d(i,4),y3d(i,4),z3d(i,4);
            x3d(i,5),y3d(i,5),z3d(i,5);
            x3d(i,6),y3d(i,6),z3d(i,6);
            x3d(i,7),y3d(i,7),z3d(i,7);
            x3d(i,8),y3d(i,8),z3d(i,8);
            x3d(i,9),y3d(i,9),z3d(i,9) ;
            x3d(i,10),y3d(i,10),z3d(i,10);
            x3d(i,11),y3d(i,11),z3d(i,11);
            x3d(i,12),y3d(i,12),z3d(i,12);
            napx(i,1),napy(i,1),z3d(i,1);
            napx(i,2),napy(i,2),napz(i,2);
            napx(i,3),napy(i,3),napz(i,3);
            napx(i,4),napy(i,4),napz(i,4);
            napx(i,5),napy(i,5),napz(i,5);
            napx(i,6),napy(i,6),napz(i,6);
            napx(i,7),napy(i,7),napz(i,7);
            napx(i,8),napy(i,8),napz(i,8);
            napx(i,9),napy(i,9),napz(i,9) ;
            napx(i,10),napy(i,10),napz(i,10);
            napx(i,11),napy(i,11),napz(i,11);
            napx(i,12),napy(i,12),napz(i,12);
            ];
    
        

        
    if((napx(i,numbercoil(1)))<0)
        [xt2,yt2,zt2]=sph2cart(phi(i,numbercoil(1)),theta(i,numbercoil(1)),-1);
        [phij(i),thetaj(i),r]=cart2sph(xt2,yt2,zt2);
    end
        
    if ( phij(i) <0)
        phij(i)=phij(i)+2*pi;
    else
        phij(i)=phij(i);
    end
    
    if (thetaj(i) <0)
        thetaj(i)=thetaj(i)+2*pi;
    else
        thetaj(i)=thetaj(i);
    end
    
            
        
        
        JP=[x3d(i,numbercoil(1)),y3d(i,numbercoil(1)),z3d(i,numbercoil(1))];
        EPL=[x3d(i,numbercoil(3)),y3d(i,numbercoil(3)),z3d(i,numbercoil(3))];
        EPR=[x3d(i,numbercoil(2)),y3d(i,numbercoil(2)),z3d(i,numbercoil(2))];
        [JCP(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phij(i)-phical,thetaj(i)-thetacal);
        
        %p(i)=phij(i)-phical; t(i)=thetaj(i)-thetacal;
        
    end
%     [x,y,z]=sph2cart(phij,thetaj,1);
%     [x1,y1,z1]=sph2cart(p,t,1);
%     [x2,y2,z2]=sph2cart(phi(:,8),theta(:,8),1);
%     figure (3)
%     plot3(x,y,z)
%     hold on
%     plot3(x1,y1,z1)
%     plot3(x2,y2,z2,'r')
%     xlabel('x')
%     ylabel('y')
%     axis([-1, 1, -1, 1, -1, 1])
%     hold off
%     
%     figure (4)
%     plot3(x(1),y(1),z(1))
%     hold on
%     plot3(x1(1),y1(1),z1(1))
%     plot3(x2(1),y2(1),z2(1),'r')
%     xlabel('x')
%     ylabel('y')
%     hold off
    
    x3dc= squeeze(JCP(1:12,1,:))';
    y3dc= squeeze(JCP(1:12,2,:))';
    z3dc= squeeze(JCP(1:12,3,:))';
    napx = squeeze(JCP(13:24,1,:))';
    napy = squeeze(JCP(13:24,2,:))';
    napz = squeeze(JCP(13:24,3,:))';
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;
    
    [phic,thetac,r]=cart2sph(nax,nay,naz);
    
end

end

