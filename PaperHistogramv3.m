function PaperHistogramv3(x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,...
    path,trialbite, numbercoiljaw, numbercoilhead,sub,tri)

%inicialization
if(tri<=26)
    excelcol=[char(64+tri) '1'];
else
    excelcol=['A' char(38+tri) '1'];
end
%coils for correction
%numbercoiljaw;% example 8 10 9
%[8 10 9];
%numbercoilhead;% example 4 12 11
%[4 12 11]:
%Gold Method: jaw coils and the head coils to find reference jaw position
%Rafael Method: front incisor coil and mastoid coils
%Simple Subtraction and Westbury: front incisor coil


%% %%%%%%%%%%%%%%%%%%%%
%% Method Calculations
%% %%%%%%%%%%%%%%%%%%%%%
% 1 - Gold Method

[GOLDx,GOLDy,GOLDz,GOLDp,GOLDt]=Gold(path,trialbite,...
    numbercoilhead,x3d_lp,y3d_lp,z3d_lp,...
    phi_lp,theta_lp, numbercoiljaw);

mp=mean(GOLDp(:,8));
mpc=mp-pi;
mtc=mean(GOLDt(:,8));

% 2 - Rafael Henriques Method
  %jaw
  numbercoiljawRH=[numbercoiljaw(1),numbercoilhead(2),numbercoilhead(3)];
  %[8 12 11]  % example 8 12 11
[RAFx,RAFy,RAFz,RAFp,RAFt]=JawCorrection1(numbercoiljawRH,...
    x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,1,mpc,mtc);

  %head
[RHCx,RHCy,RHCz,RHCp,RHCt]=HeadCorrection(path,trialbite,...
    numbercoilhead,x3d_lp,y3d_lp,z3d_lp,...
    phi_lp,theta_lp); 

% 3 - Wesbury
siz=size(x3d_lp);
WMRx=zeros(siz);
WMRz=zeros(siz);
%Direction y is equal to simple subtraction, see below
for i=1:siz(2)
[WMRx(:,i),WMRz(:,i)]=...
    decouple_rh(RHCx(:,i),RHCz(:,i),...
    RHCx(:,numbercoiljaw(1)),RHCz(:,numbercoiljaw(1)),200);
end

% 4 - Simple subtraction
siz=size(x3d_lp);
SSRx=zeros(siz);
SSRy=zeros(siz);
SSRz=zeros(siz);

for i=1:siz(2)
   SSRx(:,i)=RHCx(:,i)-RHCx(:,numbercoiljaw(1));
   SSRy(:,i)=RHCy(:,i)-RHCy(:,numbercoiljaw(1));  
   SSRz(:,i)=RHCz(:,i)-RHCz(:,numbercoiljaw(1)); 
end
WMRy=SSRy;








%figures for the poster
%figure
%plot(40/200:1/200:440/200,GOLDz(40:440,3)-mean(GOLDz(40:440,3)))
%hold on
%plot(40/200:1/200:440/200,RAFz(40:440,3)-mean(RAFz(40:440,3)))

%figure
%plot(40/200:1/200:440/200,GOLDz(40:440,3)-mean(GOLDz(40:440,3)))
%hold on
%plot(40/200:1/200:440/200,WMRz(40:440,3)-mean(WMRz(40:440,3)))

%figure
%plot(40/200:1/200:440/200,GOLDz(40:440,3)-mean(GOLDz(40:440,3)))
%hold on
%plot(40/200:1/200:440/200,SSRz(40:440,3)-mean(SSRz(40:440,3)))


%% %%%%%%%%%%%%%%%%%%%%%%
%% residual coils
%% %%%%%%%%%%%%%%%%%%%%%%

%% Euclidian errors
coil=[9,10];

for i=1:length(coil)
 
Gx=GOLDx(:,coil(i))-mean(GOLDx(:,coil(i)));
Gy=GOLDy(:,coil(i))-mean(GOLDy(:,coil(i)));
Gz=GOLDz(:,coil(i))-mean(GOLDz(:,coil(i)));
Ge=sqrt(Gx.^2+Gy.^2+Gz.^2);
    
Rx=RAFx(:,coil(i))-mean(RAFx(:,coil(i)));
Ry=RAFy(:,coil(i))-mean(RAFy(:,coil(i)));
Rz=RAFz(:,coil(i))-mean(RAFz(:,coil(i)));
Re=sqrt(Rx.^2+Ry.^2+Rz.^2);

Wx=WMRx(:,coil(i))-mean(WMRx(:,coil(i)));
Wy=WMRy(:,coil(i))-mean(WMRy(:,coil(i)));
Wz=WMRz(:,coil(i))-mean(WMRz(:,coil(i)));
We=sqrt(Wx.^2+Wy.^2+Wz.^2);

Sx=SSRx(:,coil(i))-mean(SSRx(:,coil(i)));
Sy=SSRy(:,coil(i))-mean(SSRy(:,coil(i)));
Sz=SSRz(:,coil(i))-mean(SSRz(:,coil(i)));
Se=sqrt(Sx.^2+Sy.^2+Sz.^2);


%convert to bars to save
barh=-15:0.1:15;

Re=hist(Re,barh);
We=hist(We,barh);
Se=hist(Se,barh);
Ge=hist(Ge,barh);


%save in excel file the rest of analysis is done is Paper_tables_part3.m

xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualGe', num2str(coil(i))],Ge','folha',excelcol);
xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualRe', num2str(coil(i))],Re','folha',excelcol);
xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualWe', num2str(coil(i))],We','folha',excelcol);
xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualSe', num2str(coil(i))],Se','folha',excelcol);

end


