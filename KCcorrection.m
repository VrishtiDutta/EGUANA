function [x3dc,y3dc,z3dc,phic,thetac]=KCcorrection(path,trial,numbercoil,x3d,y3d,z3d,phi,theta) 

%Rafael Henriques (rafaelnh21@gmail.com)
%Last update 6/08/11

%project virtual points need to correct angles
[nax,nay,naz]=sph2cart(phi,theta,1);
napx=x3d+nax;
napy=y3d+nay;
napz=z3d+naz;

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


%data perparation
siz=size(x3d);
motionData=zeros([ siz(1),siz(2)*2 ,3 ]);
motionData(:,:,1)=[x3d,napx];
motionData(:,:,2)=[y3d,napy];
motionData(:,:,3)=[z3d,napz];
motionData(:,:,4)=[phi,phi];
motionData(:,:,5)=[theta,theta];

motionDataref=zeros([ 1, siz(2) , 5]);



if fopen(path,'r') == -1
    questdlg('File does not exist.  Please ensure Bite Trial is correct.',...
        'ERROR','OK','OK');
    x3dc=x3d;
    y3dc=y3d;
    z3dc=z3d;
    phic=phi;
    thetac=theta;
else
    f = fopen(path, 'r');
    line1 = fgetl(f);
    line2 = fgetl(f); %has header size
    frewind(f);
    check = fread(f,[1,2],'*char');
    if strcmp(check,'AG') == 1
        fseek(f,str2num(line2),'bof');
        array = fread(f,[112 inf],'single');
    else
        fseek(f,0,'bof');
        array = fread(f,[84 inf], 'single');
    end
    data = array';
    fclose(f);
    xref=mean([data(:,1),data(:,8),data(:,15),data(:,22),data(:,29),...
        data(:,36),data(:,43),data(:,50),data(:,57),data(:,64),...
        data(:,71),data(:,78)]);
    
    yref=mean([data(:,2),data(:,9),data(:,16),data(:,23),data(:,30),...
        data(:,37),data(:,44),data(:,51),data(:,58),data(:,65),...
        data(:,72),data(:,79)]);
    
    zref=mean([data(:,3),data(:,10),data(:,17),data(:,24),data(:,31),...
        data(:,38),data(:,45),data(:,52),data(:,59),data(:,66),...
        data(:,73),data(:,80)]);
        
    phiref=mean([data(:,4),data(:,11),data(:,18),data(:,25),data(:,32),...
        data(:,39),data(:,46),data(:,53),data(:,60),data(:,67),...
        data(:,74),data(:,81)]);
    
    thetaref=mean([data(:,5),data(:,12),data(:,19),data(:,26),data(:,33),...
        data(:,40),data(:,47),data(:,54),data(:,61),data(:,68),...
        data(:,75),data(:,82)]);
    
    motionDataref(:,:,1)=xref;
    motionDataref(:,:,2)=yref;
    motionDataref(:,:,3)=zref;
    motionDataref(:,:,4)=phiref;
    motionDataref(:,:,5)=thetaref;
    
    clear data xref yref zref phiref thetaref



method=questdlg('what pose estimation do you want to use?',...
         'Cristian Kross Method', 'PCM','OAM','HM','PCM');
     
[transPar,RT,R,T,resid,us]=...
pose_estimation(motionData(:,numbercoil,:),...
motionDataref(1,numbercoil,:),3,0);

switch method
    case 'PCM'
        A=RT.position;
    case 'OAM'
        A=RT.orientation;
    case 'HM'
        A=RT.hybrid;
    otherwise
        error('fail')
end

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