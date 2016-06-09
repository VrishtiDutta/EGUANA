function PaperHistogramv3(x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,...
    path,trialbite, numbercoiljaw, numbercoilhead,sub,tri)

msg={'Residual coil analysis','For this analysis you need information', ...
    'of molar coils in sensor 10 and 9 (R + L)',...
    'and a coil glued prependicular to the front incisor (coil 8).',...
    'Continue with the analysis?'};
    resp=questdlg(msg,'Residual coil analysis','YES','NO','YES');

if(length(resp)==3)
    
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



%% For Euclidian and single coil differences
coil=[9,10,1,2,3,7];

for i=1:length(coil)
RGx=(RAFx(:,coil(i))-mean(RAFx(:,coil(i))))-(GOLDx(:,coil(i))-mean(GOLDx(:,coil(i))));
RGy=(RAFy(:,coil(i))-mean(RAFy(:,coil(i))))-(GOLDy(:,coil(i))-mean(GOLDy(:,coil(i))));
RGz=(RAFz(:,coil(i))-mean(RAFz(:,coil(i))))-(GOLDz(:,coil(i))-mean(GOLDz(:,coil(i))));
RGe=sqrt(RGx.^2+RGy.^2+RGz.^2);

WGx=(WMRx(:,coil(i))-mean(WMRx(:,coil(i))))-(GOLDx(:,coil(i))-mean(GOLDx(:,coil(i))));
WGy=(WMRy(:,coil(i))-mean(WMRy(:,coil(i))))-(GOLDy(:,coil(i))-mean(GOLDy(:,coil(i))));
WGz=(WMRz(:,coil(i))-mean(WMRz(:,coil(i))))-(GOLDz(:,coil(i))-mean(GOLDz(:,coil(i))));
WGe=sqrt(WGx.^2+WGy.^2+WGz.^2);

SGx=(SSRx(:,coil(i))-mean(SSRx(:,coil(i))))-(GOLDx(:,coil(i))-mean(GOLDx(:,coil(i))));
SGy=(SSRy(:,coil(i))-mean(SSRy(:,coil(i))))-(GOLDy(:,coil(i))-mean(GOLDy(:,coil(i))));
SGz=(SSRz(:,coil(i))-mean(SSRz(:,coil(i))))-(GOLDz(:,coil(i))-mean(GOLDz(:,coil(i))));
SGe=sqrt(SGx.^2+SGy.^2+SGz.^2);

RWx=(RAFx(:,coil(i))-mean(RAFx(:,coil(i))))-(WMRx(:,coil(i))-mean(WMRx(:,coil(i))));
RWy=(RAFy(:,coil(i))-mean(RAFy(:,coil(i))))-(WMRy(:,coil(i))-mean(WMRy(:,coil(i))));
RWz=(RAFz(:,coil(i))-mean(RAFz(:,coil(i))))-(WMRz(:,coil(i))-mean(WMRz(:,coil(i))));
RWe=sqrt(RWx.^2+RWy.^2+RWz.^2);

RSx=(RAFx(:,coil(i))-mean(RAFx(:,coil(i))))-(SSRx(:,coil(i))-mean(SSRx(:,coil(i))));
RSy=(RAFy(:,coil(i))-mean(RAFy(:,coil(i))))-(SSRy(:,coil(i))-mean(SSRy(:,coil(i))));
RSz=(RAFz(:,coil(i))-mean(RAFz(:,coil(i))))-(SSRz(:,coil(i))-mean(SSRz(:,coil(i))));
RSe=sqrt(RSx.^2+RSy.^2+RSz.^2);

WSx=(WMRx(:,coil(i))-mean(WMRx(:,coil(i))))-(SSRx(:,coil(i))-mean(SSRx(:,coil(i))));
WSy=(WMRy(:,coil(i))-mean(WMRy(:,coil(i))))-(SSRy(:,coil(i))-mean(SSRy(:,coil(i))));
WSz=(WMRz(:,coil(i))-mean(WMRz(:,coil(i))))-(SSRz(:,coil(i))-mean(SSRz(:,coil(i))));
WSe=sqrt(WSx.^2+WSy.^2+WSz.^2);

%convert to bars to save
barh=-15:0.1:15;

RGx=hist(RGx,barh);
RGy=hist(RGy,barh);
RGz=hist(RGz,barh);
RGe=hist(RGe,barh);

nnn=num2str(coil(i));

figure
subplot(2,2,1),bar(barh,RGx),title(['JOANA - GOLD x',nnn])
subplot(2,2,2),bar(barh,RGy),title(['JOANA - GOLD y',nnn])
subplot(2,2,3),bar(barh,RGz),title(['JOANA - GOLD z',nnn])
subplot(2,2,4),bar(barh,RGe),title(['JOANA - GOLD e',nnn])

WGx=hist(WGx,barh);
WGy=hist(WGy,barh);
WGz=hist(WGz,barh);
WGe=hist(WGe,barh);

figure
subplot(2,2,1),bar(barh,WGx),title(['West - GOLD x',nnn])
subplot(2,2,2),bar(barh,WGy),title(['West - GOLD y',nnn])
subplot(2,2,3),bar(barh,WGz),title(['West - GOLD z',nnn])
subplot(2,2,4),bar(barh,WGe),title(['West - GOLD e',nnn])

SGx=hist(SGx,barh);
SGy=hist(SGy,barh);
SGz=hist(SGz,barh);
SGe=hist(SGe,barh);

figure
subplot(2,2,1),bar(barh,SGx),title(['SS - GOLD x',nnn])
subplot(2,2,2),bar(barh,SGy),title(['SS - GOLD y',nnn])
subplot(2,2,3),bar(barh,SGz),title(['SS - GOLD z',nnn])
subplot(2,2,4),bar(barh,SGe),title(['SS - GOLD e',nnn])

RWx=hist(RWx,barh);
RWy=hist(RWy,barh);
RWz=hist(RWz,barh);
RWe=hist(RWe,barh);

figure
subplot(2,2,1),bar(barh,RWx),title(['JOANA - West x',nnn])
subplot(2,2,2),bar(barh,RWy),title(['JOANA - West y',nnn])
subplot(2,2,3),bar(barh,RWz),title(['JOANA - West z',nnn])
subplot(2,2,4),bar(barh,RWe),title(['JOANA - West e',nnn])

RSx=hist(RSx,barh);
RSy=hist(RSy,barh);
RSz=hist(RSz,barh);
RSe=hist(RSe,barh);

figure
subplot(2,2,1),bar(barh,RSx),title(['JOANA - SS x',nnn])
subplot(2,2,2),bar(barh,RSy),title(['JOANA- SS y',nnn])
subplot(2,2,3),bar(barh,RSz),title(['JOANA - SS z',nnn])
subplot(2,2,4),bar(barh,RSe),title(['JOANA - SS e',nnn])


WSx=hist(WSx,barh);
WSy=hist(WSy,barh);
WSz=hist(WSz,barh);
WSe=hist(WSe,barh);

figure
subplot(2,2,1),bar(barh,WSx),title(['West - SS x',nnn])
subplot(2,2,2),bar(barh,WSy),title(['West- SS y',nnn])
subplot(2,2,3),bar(barh,WSz),title(['West - SS z',nnn])
subplot(2,2,4),bar(barh,WSe),title(['West - SS e',nnn])


% %save in excel file the rest of analysis is done is Paper_tables_part2.m
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'RGx', num2str(coil(i))],RGx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RGy', num2str(coil(i))],RGy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RGz', num2str(coil(i))],RGz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RGe', num2str(coil(i))],RGe','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'WGx', num2str(coil(i))],WGx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WGy', num2str(coil(i))],WGy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WGz', num2str(coil(i))],WGz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WGe', num2str(coil(i))],WGe','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'SGx', num2str(coil(i))],SGx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'SGy', num2str(coil(i))],SGy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'SGz', num2str(coil(i))],SGz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'SGe', num2str(coil(i))],SGe','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'RWx', num2str(coil(i))],RWx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RWy', num2str(coil(i))],RWy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RWz', num2str(coil(i))],RWz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RWe', num2str(coil(i))],RWe','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'RSx', num2str(coil(i))],RSx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RSy', num2str(coil(i))],RSy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RSz', num2str(coil(i))],RSz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'RSe', num2str(coil(i))],RSe','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis_part2\',sub,'WSx', num2str(coil(i))],WSx','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WSy', num2str(coil(i))],WSy','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WSz', num2str(coil(i))],WSz','folha',excelcol);
% xlswrite(['D:\JawAnalysis_part2\',sub,'WSe', num2str(coil(i))],WSe','folha',excelcol);

end






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

%xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualGe', num2str(coil(i))],Ge','folha',excelcol);
%xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualRe', num2str(coil(i))],Re','folha',excelcol);
%xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualWe', num2str(coil(i))],We','folha',excelcol);
%xlswrite(['D:\JawAnalysis_part3\',sub,'ResidualSe', num2str(coil(i))],Se','folha',excelcol);

nnn=num2str(coil(i));

figure
subplot(2,2,1)
bar(barh,Re)
title(['JOANA molar residual error',nnn])

subplot(2,2,2)
bar(barh,We)
title(['Westbury molar residual error',nnn])

subplot(2,2,3)
bar(barh,Se)
title(['SS molar residual error',nnn])

subplot(2,2,4)
bar(barh,Ge)
title(['Gold molar residual error',nnn])

end

end
