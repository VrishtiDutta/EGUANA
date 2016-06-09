function [x3dc,y3dc,z3dc]=KCcorrectionforjaw(path,Bite_trial,Rest_trial,numbercoil, numbercoilhead,x3d,y3d,z3d) 


pathrest=path;
pathBite=path;


if Bite_trial(length(Bite_trial)) ~= 'c' && Bite_trial(length(Bite_trial)) ~= 'r'
    for i = 1:(4-length(Bite_trial))
        pathBite = strcat(pathBite, '0');
    end
    pathBite = strcat(pathBite, Bite_trial,'.pos');
else
    for i = 1:(5-length(Bite_trial))
        pathBite = strcat(pathBite, '0');
    end
    pathBite = strcat(pathBite, Bite_trial,'.pos');
end

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


%data perparation
siz=size(x3d);
motionData=zeros([ siz(1),siz(2),3 ]);
motionData(:,:,1)=x3d;
motionData(:,:,2)=y3d;
motionData(:,:,3)=z3d;

motionDatarefbite=zeros([ 1, siz(2), 3]);
motionDatarest=zeros([ 1, siz(2), 3]);
motionDatarefc=zeros([ 1, siz(2), 3]);


if ((fopen(pathBite,'r') == -1) || (fopen(pathrest,'r') == -1) )
  questdlg('File does not exist.  Please ensure Trials is correct.',...
        'ERROR','OK','OK');
    x3dc=x3d;
    y3dc=y3d;
    z3dc=z3d;
else
    
    %load reference data (Bite plane)
    f1 = fopen(pathBite, 'r');
    data = fread(f1,[84 inf], 'single');
    data = data';
    
    xref1=mean([data(:,1),data(:,8),data(:,15),data(:,22),data(:,29),...
        data(:,36),data(:,43),data(:,50),data(:,57),data(:,64),...
        data(:,71),data(:,78)]);
    
    yref1=mean([data(:,2),data(:,9),data(:,16),data(:,23),data(:,30),...
        data(:,37),data(:,44),data(:,51),data(:,58),data(:,65),...
        data(:,72),data(:,79)]);
    
    zref1=mean([data(:,3),data(:,10),data(:,17),data(:,24),data(:,31),...
        data(:,38),data(:,45),data(:,52),data(:,59),data(:,66),...
        data(:,73),data(:,80)]);
    
    
    motionDatarefbite(:,:,1)=xref1;
    motionDatarefbite(:,:,2)=yref1;
    motionDatarefbite(:,:,3)=zref1;
    
    f = fopen(pathrest, 'r');
    data = fread(f,[84 inf], 'single');
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
           
    motionDatarest(:,:,1)=xrest;
    motionDatarest(:,:,2)=yrest;
    motionDatarest(:,:,3)=zrest;
    
[transPar,RT,R,T,resid,us]=...
pose_estimation(motionDatarest(:,numbercoilhead,:),...
motionDatarefbite(1,numbercoilhead,:),3,0);
     
A1=RT.position;
  
clear data xref yref zref xref1 yref1 zref1 transPar RT R T resid us

 
B=squeeze(motionDatarest(1,:,1:3))';
C=squeeze(A1(1:3,1:3,1));
D=[squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1)),...
squeeze(A1(1:3,4,1))];

motionDatarefc(i,:,:)=(C'*B+D)';

xrefc = squeeze(motionDatarefc(:,:,1));
yrefc = squeeze(motionDatarefc(:,:,2));
zrefc = squeeze(motionDatarefc(:,:,3));


motionDatarefc(:,:,1)=xrefc;
motionDatarefc(:,:,2)=yrefc;
motionDatarefc(:,:,3)=zrefc;

     
[transPar,RT,R,T,resid,us]=...
pose_estimation(motionData(:,numbercoil,:),...
motionDatarefc(1,numbercoil,:),3,0);

A=RT.position;

clear data xref yref zref xref1 yref1 zref1 transPar RT R T resid us

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
squeeze(A(1:3,4,i))];

motionDatacorrected(i,:,:)=(C*B+D)';
end
x3dc = squeeze(motionDatacorrected(:,:,1));
y3dc = squeeze(motionDatacorrected(:,:,2));
z3dc = squeeze(motionDatacorrected(:,:,3));

end