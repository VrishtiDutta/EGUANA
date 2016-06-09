function PaperHistogram(x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,...
    path,trialbite, numbercoiljaw, numbercoilhead,sub,tri)

%inicialization
if(str2double(tri)<=26)
    excelcol=[char(64+str2double(tri)) '1'];
else
    excelcol=['A' char(38+str2double(tri)) '1'];
end
%coils for correction
numbercoiljaw,% example 8 10 9
[8 10 9]
numbercoilhead,% example 4 12 11
[4 12 11]
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
mpc=mp-pi
mtc=mean(GOLDt(:,8))

% 2 - Rafael Henriques Method
  %jaw
  numbercoiljawRH=[numbercoiljaw(1),numbercoilhead(2),numbercoilhead(3)],
  [8 12 11]  % example 8 12 11
[RAFx,RAFy,RAFz,RAFp,RAFt]=JawCorrection1(numbercoiljawRH,...
    x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,1);

  %head
[RHCx,RHCy,RHCz,RHCp,RHCt]=HeadCorrection(path,trialbite,...
    numbercoilhead,x3d_lp,y3d_lp,z3d_lp,...
    phi_lp,theta_lp); 

% 3 - Wesbury
siz=size(x3d_lp);
WMRx=zeros(siz);
WMRz=zeros(siz);
WMRy=RHCy;
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


a=figure;
set(a,'color',[1 1 1])
p1=plot(40/200:1/200:220/200,GOLDz(40:220,3)-mean(GOLDz(40:220,3)),'color',[0 0 0]);
set(p1,'lineWidth',2)
hold on
p2=plot(40/200:1/200:220/200,RAFz(40:220,3)-mean(RAFz(40:220,3)));
set(p2,'lineWidth',2)
axis([0.2 1.1 -6 8])

a=figure;
set(a,'color',[1 1 1])
p1=plot(40/200:1/200:220/200,GOLDz(40:220,3)-mean(GOLDz(40:220,3)),'black');
set(p1,'lineWidth',2)
hold on
p2=plot(40/200:1/200:220/200,WMRz(40:220,3)-mean(WMRz(40:220,3)));
set(p2,'lineWidth',2)
axis([0.2 1.1 -6 8])

a=figure;
set(a,'color',[1 1 1])
p1=plot(40/200:1/200:220/200,GOLDz(40:220,3)-mean(GOLDz(40:220,3)),'black');
set(p1,'lineWidth',2)
hold on
p2=plot(40/200:1/200:220/200,SSRz(40:220,3)-mean(SSRz(40:220,3)));
set(p2,'lineWidth',2)
axis([0.2 1.1 -6 8])

% 
% 
% %% %%%%%%%%%%%%%%%%%%%%%%
% %% residual coils
% %% %%%%%%%%%%%%%%%%%%%%%%
% 
% %% 1) residual analysis data of head correction
% % coil 9 and 10
% 
% 
% figure
% pl1=plot3(RHCx(:,9),RHCy(:,9),RHCz(:,9));
% hold on
% pl2=plot3(RHCx(:,10),RHCy(:,10),RHCz(:,10));
% set([pl1,pl2],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-20:0.1:20; %mm
% a=figure;
% set(a,'name','Without correction')
% % coil 9
% subplot(2,3,1),hist((RHCx(:,9)-mean(RHCx(:,9))),barh), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(2,3,2),hist((RHCy(:,9)-mean(RHCy(:,9))),barh), xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(2,3,3),hist((RHCz(:,9)-mean(RHCz(:,9))),barh), xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 10
% subplot(2,3,4),hist((RHCx(:,10)-mean(RHCx(:,10))),barh); title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(2,3,5),hist((RHCy(:,10)-mean(RHCy(:,10))),barh); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(2,3,6),hist((RHCz(:,10)-mean(RHCz(:,10))),barh); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% 
% %pause
% 
% %% 2) Residual analysis of simple subtraction
% %coils 9 and 10
% 
% figure
% pl1=plot3(SSRx(:,9),SSRy(:,9),SSRz(:,9));
% hold on
% pl2=plot3(SSRx(:,10),SSRy(:,10),SSRz(:,10));
% set([pl1,pl2],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-15:0.1:15;
% a=figure;
% set(a,'name','Simple Subtraction')
% 
% % coil 9
% subplot(2,3,1),barh9x=hist((SSRx(:,9)-mean(SSRx(:,9))),barh);bar(barh,barh9x), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% subplot(2,3,2),barh9y=hist((SSRy(:,9)-mean(SSRy(:,9))),barh);bar(barh,barh9y), xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% subplot(2,3,3),barh9z=hist((SSRz(:,9)-mean(SSRz(:,9))),barh);bar(barh,barh9z), xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% 
% % coil 10
% subplot(2,3,4),barh10x=hist((SSRx(:,10)-mean(SSRx(:,10))),barh); bar(barh,barh10x),title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% subplot(2,3,5),barh10y=hist((SSRy(:,10)-mean(SSRy(:,10))),barh); bar(barh,barh10y),xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% subplot(2,3,6),barh10z=hist((SSRz(:,10)-mean(SSRz(:,10))),barh); bar(barh,barh10z),xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% 
% %pause
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'SSR9x'],barh9x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR9y'],barh9y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR9z'],barh9z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'SSR10x'],barh10x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR10y'],barh10y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR10z'],barh10z','folha',excelcol);
% 
% 
% 
% %% 3) Residual analysis of Westbury
% %coils 9 and 10
% 
% figure
% pl1=plot3(WMRx(:,9),WMRy(:,9),WMRz(:,9));
% hold on
% pl2=plot3(WMRx(:,10),WMRy(:,10),WMRz(:,10));
% set([pl1,pl2],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-15:0.1:15;
% a=figure;
% set(a,'name','Westbury')
% 
% % coil 9
% subplot(2,3,1),barh9x=hist((WMRx(:,9)-mean(WMRx(:,9))),barh);bar(barh,barh9x), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR9x'],barh9x','folha',excelcol);
% subplot(2,3,2),barh9y=hist((WMRy(:,9)-mean(WMRy(:,9))),barh);bar(barh,barh9y), xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR9y'],barh9y','folha',excelcol);
% subplot(2,3,3),barh9z=hist((WMRz(:,9)-mean(WMRz(:,9))),barh);bar(barh,barh9z), xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR9z'],barh9z','folha',excelcol);
% 
% % coil 10
% subplot(2,3,4),barh10x=hist((WMRx(:,10)-mean(WMRx(:,10))),barh); bar(barh,barh10x),title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],bar10x','folha',excelcol);
% subplot(2,3,5),barh10y=hist((WMRy(:,10)-mean(WMRy(:,10))),barh); bar(barh,barh10y),xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],barh10x','folha',excelcol);
% subplot(2,3,6),barh10z=hist((WMRz(:,10)-mean(WMRz(:,10))),barh); bar(barh,barh10z),xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],barh10x','folha',excelcol);
% 
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'WMR9x'],barh9x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR9y'],barh9y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR9z'],barh9z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],barh10x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR10y'],barh10y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR10z'],barh10z','folha',excelcol);
% 
% 
% % % whithout head correction
% % siz=size(x3d_lp);
% % WMRxnoC=zeros(siz);
% % WMRznoC=zeros(siz);
% % WMRynoC=y3d_lp;
% % for i=1:siz(2)
% % [WMRxnoC(:,i),WMRznoC(:,i)]=...
% %     decouple_rh(x3d_lp(:,i),z3d_lp(:,i),...
% %     x3d_lp(:,numbercoiljaw(1)),z3d_lp(:,numbercoiljaw(1)),200);
% % end
% % 
% % a=figure;
% % set(a,'name','Westbury no head correction')
% % pl1=plot3(WMRxnoC(:,9),WMRynoC(:,9),WMRznoC(:,9));
% % hold on
% % pl2=plot3(WMRxnoC(:,10),WMRynoC(:,10),WMRznoC(:,10));
% % set([pl1,pl2],'color',[0 0 0])
% % xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% % 
% % %pause
% % 
% % barh=-15:0.1:15;
% % a=figure;
% % set(a,'name','Westbury no head correction')
% % 
% % % coil 9
% % subplot(2,3,1),barh9x=hist((WMRxnoC(:,9)-mean(WMRxnoC(:,9))),barh);bar(barh,barh9x), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR9x'],barh9x','folha',excelcol);
% % subplot(2,3,2),barh9y=hist((WMRynoC(:,9)-mean(WMRynoC(:,9))),barh);bar(barh,barh9y), xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR9y'],barh9y','folha',excelcol);
% % subplot(2,3,3),barh9z=hist((WMRznoC(:,9)-mean(WMRznoC(:,9))),barh);bar(barh,barh9z), xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR9z'],barh9z','folha',excelcol);
% % 
% % % coil 10
% % subplot(2,3,4),barh10x=hist((WMRxnoC(:,10)-mean(WMRxnoC(:,10))),barh); bar(barh,barh10x),title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],bar10x','folha',excelcol);
% % subplot(2,3,5),barh10y=hist((WMRynoC(:,10)-mean(WMRynoC(:,10))),barh); bar(barh,barh10y),xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],barh10x','folha',excelcol);
% % subplot(2,3,6),barh10z=hist((WMRznoC(:,10)-mean(WMRznoC(:,10))),barh); bar(barh,barh10z),xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% % %xlswrite(['D:\JawAnalysis\',sub,'WMR10x'],barh10x','folha',excelcol);
% 
% 
% 
% %% 3) Residual analysis of Rafael Method
% %coils 9 and 10
% 
% figure
% pl1=plot3(RAFx(:,9),RAFy(:,9),RAFz(:,9));
% hold on
% pl2=plot3(RAFx(:,10),RAFy(:,10),RAFz(:,10));
% set([pl1,pl2],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-15:0.1:15;
% a=figure;
% set(a,'name','JOANA')
% 
% % coil 9
% subplot(2,3,1),barh9x=hist((RAFx(:,9)-mean(RAFx(:,9))),barh);bar(barh,barh9x), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq'), set(gca,'xlim',[-15 15])
% subplot(2,3,2),barh9y=hist((RAFy(:,9)-mean(RAFy(:,9))),barh);bar(barh,barh9y), xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% subplot(2,3,3),barh9z=hist((RAFz(:,9)-mean(RAFz(:,9))),barh);bar(barh,barh9z), xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% 
% % coil 10
% subplot(2,3,4),barh10x=hist((RAFx(:,10)-mean(RAFx(:,10))),barh); bar(barh,barh10x),title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% subplot(2,3,5),barh10y=hist((RAFy(:,10)-mean(RAFy(:,10))),barh); bar(barh,barh10y),xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% subplot(2,3,6),barh10z=hist((RAFz(:,10)-mean(RAFz(:,10))),barh); bar(barh,barh10z),xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'RAF9x'],barh9x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF9y'],barh9y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF9z'],barh9z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'RAF10x'],barh10x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF10y'],barh10y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF10z'],barh10z','folha',excelcol);
% 
% 
% 
% 
% %% 3) Residual analysis of Rafael Method
% %coils 9 and 10
% 
% figure
% pl1=plot3(RAFx(:,9),RAFy(:,9),RAFz(:,9));
% hold on
% pl2=plot3(RAFx(:,10),RAFy(:,10),RAFz(:,10));
% set([pl1,pl2],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-15:0.1:15;
% a=figure;
% set(a,'name','GOLD')
% 
% % coil 9
% subplot(2,3,1),barh9x=hist((GOLDx(:,9)-mean(GOLDx(:,9))),barh);bar(barh,barh9x), title('Residual Coil 9'), xlabel('x (mm)'), ylabel('abs freq'), set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD9x'],barh9x','folha',excelcol);
% subplot(2,3,2),barh9y=hist((GOLDy(:,9)-mean(GOLDy(:,9))),barh);bar(barh,barh9y), xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD9y'],barh9y','folha',excelcol);
% subplot(2,3,3),barh9z=hist((GOLDz(:,9)-mean(GOLDz(:,9))),barh);bar(barh,barh9z), xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD9z'],barh9z','folha',excelcol);
% 
% % coil 10
% subplot(2,3,4),barh10x=hist((GOLDx(:,10)-mean(GOLDx(:,10))),barh); bar(barh,barh10x),title('Residual Coil 10'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD10x'],bar10x','folha',excelcol);
% subplot(2,3,5),barh10y=hist((GOLDy(:,10)-mean(GOLDy(:,10))),barh); bar(barh,barh10y),xlabel('y (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD10x'],barh10x','folha',excelcol);
% subplot(2,3,6),barh10z=hist((GOLDz(:,10)-mean(GOLDz(:,10))),barh); bar(barh,barh10z),xlabel('z (mm)'),set(gca,'xlim',[-15 15])
% %xlswrite(['D:\JawAnalysis\',sub,'GOLD10x'],barh10x','folha',excelcol);
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'GOLD9x'],barh9x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'GOLD9y'],barh9y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'GOLD9z'],barh9z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'GOLD10x'],barh10x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'GOLD10y'],barh10y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'GOLD10z'],barh10z','folha',excelcol);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Tongue and Lip analysis  %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% 1) residual analysis data of head correction
% % coil 1,2,3 and 7
% 
% 
% a=figure;
% set(a,'name','Without correction')
% pl1=plot3(RHCx(:,1),RHCy(:,1),RHCz(:,1));
% hold on
% pl2=plot3(RHCx(:,2),RHCy(:,2),RHCz(:,2));
% pl3=plot3(RHCx(:,3),RHCy(:,2),RHCz(:,3));
% pl4=plot3(RHCx(:,7),RHCy(:,7),RHCz(:,7));
% set([pl1,pl2,pl3,pl4],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% a=figure;
% set(a,'name','GOLD')
% pl1=plot3(GOLDx(:,1),GOLDy(:,1),GOLDz(:,1));
% hold on
% pl2=plot3(GOLDx(:,2),GOLDy(:,2),GOLDz(:,2));
% pl3=plot3(GOLDx(:,3),GOLDy(:,2),GOLDz(:,3));
% pl4=plot3(GOLDx(:,7),GOLDy(:,7),GOLDz(:,7));
% set([pl1,pl2,pl3,pl4],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-20:0.1:20; %mm
% a=figure;
% set(a,'name','Without correction Histograms')
% % coil 1
% subplot(4,3,1),hist((RHCx(:,1)-mean(RHCx(:,1))),barh), title('Residual Coil 1'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,2),hist((RHCy(:,1)-mean(RHCy(:,1))),barh), xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,3),hist((RHCz(:,1)-mean(RHCz(:,1))),barh), xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 2
% subplot(4,3,4),hist((RHCx(:,2)-mean(RHCx(:,2))),barh); title('Residual Coil 2'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,5),hist((RHCy(:,2)-mean(RHCy(:,2))),barh); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,6),hist((RHCz(:,2)-mean(RHCz(:,2))),barh); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 3
% subplot(4,3,7),hist((RHCx(:,3)-mean(RHCx(:,3))),barh), title('Residual Coil 3'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,8),hist((RHCy(:,3)-mean(RHCy(:,3))),barh), xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,9),hist((RHCz(:,3)-mean(RHCz(:,3))),barh), xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 4
% subplot(4,3,10),hist((RHCx(:,7)-mean(RHCx(:,7))),barh); title('Residual Coil 7'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,11),hist((RHCy(:,7)-mean(RHCy(:,7))),barh); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,12),hist((RHCz(:,7)-mean(RHCz(:,7))),barh); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% 
% %pause
% 
% 
% %% Simple subtraction
% 
% a=figure;
% set(a,'name','Simple Subtraction')
% pl1=plot3(SSRx(:,1),SSRy(:,1),SSRz(:,1));
% hold on
% pl2=plot3(SSRx(:,2),SSRy(:,2),SSRz(:,2));
% pl3=plot3(SSRx(:,3),SSRy(:,2),SSRz(:,3));
% pl4=plot3(SSRx(:,7),SSRy(:,7),SSRz(:,7));
% set([pl1,pl2,pl3,pl4],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-20:0.1:20; %mm
% a=figure;
% set(a,'name','Simple Subtraction Histograms')
% % coil 1
% subplot(4,3,1),barh1x=hist((SSRx(:,1)-GOLDx(:,1)-mean(SSRx(:,1)-GOLDx(:,1))),barh);bar(barh,barh1x); title('Residual Coil 1'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,2),barh1y=hist((SSRy(:,1)-GOLDy(:,1)-mean(SSRy(:,1)-GOLDy(:,1))),barh);bar(barh,barh1y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,3),barh1z=hist((SSRz(:,1)-GOLDz(:,1)-mean(SSRz(:,1)-GOLDz(:,1))),barh);bar(barh,barh1z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 2
% subplot(4,3,4),barh2x=hist((SSRx(:,2)-GOLDx(:,2)-mean(SSRx(:,2)-GOLDx(:,2))),barh);bar(barh,barh2x); title('Residual Coil 2'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,5),barh2y=hist((SSRy(:,2)-GOLDy(:,2)-mean(SSRy(:,2)-GOLDy(:,2))),barh);bar(barh,barh2y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,6),barh2z=hist((SSRz(:,2)-GOLDz(:,2)-mean(SSRz(:,2)-GOLDz(:,2))),barh);bar(barh,barh2z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 3
% subplot(4,3,7),barh3x=hist((SSRx(:,3)-GOLDx(:,3)-mean(SSRx(:,3)-GOLDx(:,3))),barh);bar(barh,barh3x); title('Residual Coil 3'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,8),barh3y=hist((SSRy(:,3)-GOLDy(:,3)-mean(SSRy(:,3)-GOLDy(:,3))),barh);bar(barh,barh3y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,9),barh3z=hist((SSRz(:,3)-GOLDz(:,3)-mean(SSRz(:,3)-GOLDz(:,3))),barh);bar(barh,barh3z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 7
% subplot(4,3,10),barh7x=hist((SSRx(:,7)-GOLDx(:,7)-mean(SSRx(:,7)-GOLDx(:,7))),barh);bar(barh,barh7x); title('Residual Coil 7'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,11),barh7y=hist((SSRy(:,7)-GOLDy(:,7)-mean(SSRy(:,7)-GOLDy(:,7))),barh);bar(barh,barh7y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,12),barh7z=hist((SSRz(:,7)-GOLDz(:,7)-mean(SSRz(:,7)-GOLDz(:,7))),barh);bar(barh,barh7z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% 
% %pause
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'SSR1x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR1y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR1z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'SSR2x'],barh2x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR2y'],barh2y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR2z'],barh2z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'SSR3x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR3y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR3z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'SSR7x'],barh7x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR7y'],barh7y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'SSR7z'],barh7z','folha',excelcol);
% 
% %% Westbury
% 
% a=figure;
% set(a,'name','Westbury')
% pl1=plot3(WMRx(:,1),WMRy(:,1),WMRz(:,1));
% hold on
% pl2=plot3(WMRx(:,2),WMRy(:,2),WMRz(:,2));
% pl3=plot3(WMRx(:,3),WMRy(:,2),WMRz(:,3));
% pl4=plot3(WMRx(:,7),WMRy(:,7),WMRz(:,7));
% set([pl1,pl2,pl3,pl4],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% barh=-20:0.1:20; %mm
% a=figure;
% set(a,'name','Westbury Histograms')
% % coil 1
% subplot(4,3,1),barh1x=hist((WMRx(:,1)-GOLDx(:,1)-mean(WMRx(:,1)-GOLDx(:,1))),barh);bar(barh,barh1x); title('Residual Coil 1'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,2),barh1y=hist((WMRy(:,1)-GOLDy(:,1)-mean(WMRy(:,1)-GOLDy(:,1))),barh);bar(barh,barh1y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,3),barh1z=hist((WMRz(:,1)-GOLDz(:,1)-mean(WMRz(:,1)-GOLDz(:,1))),barh);bar(barh,barh1z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 2
% subplot(4,3,4),barh2x=hist((WMRx(:,2)-GOLDx(:,2)-mean(WMRx(:,2)-GOLDx(:,2))),barh);bar(barh,barh2x); title('Residual Coil 2'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,5),barh2y=hist((WMRy(:,2)-GOLDy(:,2)-mean(WMRy(:,2)-GOLDy(:,2))),barh);bar(barh,barh2y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,6),barh2z=hist((WMRz(:,2)-GOLDz(:,2)-mean(WMRz(:,2)-GOLDz(:,2))),barh);bar(barh,barh2z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 3
% subplot(4,3,7),barh3x=hist((WMRx(:,3)-GOLDx(:,3)-mean(WMRx(:,3)-GOLDx(:,3))),barh);bar(barh,barh3x); title('Residual Coil 3'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,8),barh3y=hist((WMRy(:,3)-GOLDy(:,3)-mean(WMRy(:,3)-GOLDy(:,3))),barh);bar(barh,barh3y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,9),barh3z=hist((WMRz(:,3)-GOLDz(:,3)-mean(WMRz(:,3)-GOLDz(:,3))),barh);bar(barh,barh3z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 7
% subplot(4,3,10),barh7x=hist((WMRx(:,7)-GOLDx(:,7)-mean(WMRx(:,7)-GOLDx(:,7))),barh);bar(barh,barh7x); title('Residual Coil 7'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,11),barh7y=hist((WMRy(:,7)-GOLDy(:,7)-mean(WMRy(:,7)-GOLDy(:,7))),barh);bar(barh,barh7y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,12),barh7z=hist((WMRz(:,7)-GOLDz(:,7)-mean(WMRz(:,7)-GOLDz(:,7))),barh);bar(barh,barh7z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% 
% %pause
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'WMR1x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR1y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR1z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'WMR2x'],barh2x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR2y'],barh2y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR2z'],barh2z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'WMR3x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR3y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR3z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'WMR7x'],barh7x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR7y'],barh7y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'WMR7z'],barh7z','folha',excelcol);
% 
% 
% 
% %% JOANA
% 
% a=figure;
% set(a,'name','JOANA')
% pl1=plot3(RAFx(:,1),RAFy(:,1),RAFz(:,1));
% hold on
% pl2=plot3(RAFx(:,2),RAFy(:,2),RAFz(:,2));
% pl3=plot3(RAFx(:,3),RAFy(:,2),RAFz(:,3));
% pl4=plot3(RAFx(:,7),RAFy(:,7),RAFz(:,7));
% set([pl1,pl2,pl3,pl4],'color',[0 0 0])
% xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')
% 
% %pause
% 
% 
% barh=-20:0.1:20; %mm
% a=figure;
% set(a,'name','JOANA Histograms')
% % coil 1
% subplot(4,3,1),barh1x=hist((RAFx(:,1)-GOLDx(:,1)-mean(RAFx(:,1)-GOLDx(:,1))),barh);bar(barh,barh1x); title('Residual Coil 1'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,2),barh1y=hist((RAFy(:,1)-GOLDy(:,1)-mean(RAFy(:,1)-GOLDy(:,1))),barh);bar(barh,barh1y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,3),barh1z=hist((RAFz(:,1)-GOLDz(:,1)-mean(RAFz(:,1)-GOLDz(:,1))),barh);bar(barh,barh1z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 2
% subplot(4,3,4),barh2x=hist((RAFx(:,2)-GOLDx(:,2)-mean(RAFx(:,2)-GOLDx(:,2))),barh);bar(barh,barh2x); title('Residual Coil 2'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,5),barh2y=hist((RAFy(:,2)-GOLDy(:,2)-mean(RAFy(:,2)-GOLDy(:,2))),barh);bar(barh,barh2y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,6),barh2z=hist((RAFz(:,2)-GOLDz(:,2)-mean(RAFz(:,2)-GOLDz(:,2))),barh);bar(barh,barh2z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 3
% subplot(4,3,7),barh3x=hist((RAFx(:,3)-GOLDx(:,3)-mean(RAFx(:,3)-GOLDx(:,3))),barh);bar(barh,barh3x); title('Residual Coil 3'), xlabel('x (mm)'), ylabel('abs freq') ,set(gca,'xlim',[-20 20])
% subplot(4,3,8),barh3y=hist((RAFy(:,3)-GOLDy(:,3)-mean(RAFy(:,3)-GOLDy(:,3))),barh);bar(barh,barh3y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,9),barh3z=hist((RAFz(:,3)-GOLDz(:,3)-mean(RAFz(:,3)-GOLDz(:,3))),barh);bar(barh,barh3z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% % coil 7
% subplot(4,3,10),barh7x=hist((RAFx(:,7)-GOLDx(:,7)-mean(RAFx(:,7)-GOLDx(:,7))),barh);bar(barh,barh7x); title('Residual Coil 7'), xlabel('x (mm)'), ylabel('abs freq'),set(gca,'xlim',[-20 20])
% subplot(4,3,11),barh7y=hist((RAFy(:,7)-GOLDy(:,7)-mean(RAFy(:,7)-GOLDy(:,7))),barh);bar(barh,barh7y); xlabel('y (mm)'),set(gca,'xlim',[-20 20])
% subplot(4,3,12),barh7z=hist((RAFz(:,7)-GOLDz(:,7)-mean(RAFz(:,7)-GOLDz(:,7))),barh);bar(barh,barh7z); xlabel('z (mm)'),set(gca,'xlim',[-20 20])
% 
% %pause
% 
% %save
% xlswrite(['D:\JawAnalysis\',sub,'RAF1x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF1y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF1z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'RAF2x'],barh2x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF2y'],barh2y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF2z'],barh2z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'RAF3x'],barh1x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF3y'],barh1y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF3z'],barh1z','folha',excelcol);
% 
% xlswrite(['D:\JawAnalysis\',sub,'RAF7x'],barh7x','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF7y'],barh7y','folha',excelcol);
% xlswrite(['D:\JawAnalysis\',sub,'RAF7z'],barh7z','folha',excelcol);
% 
% %% Old code version
% 
% % %% coil 9
% % figure
% % % Gold
% % subplot(4,4,1),plot(GOLDx(:,9))
% % ylabel('Gold M')
% % title('x')
% % subplot(4,4,2),plot(GOLDy(:,9))
% % title('y')
% % subplot(4,4,3),plot(GOLDz(:,9))
% % title('y')
% % subplot(4,4,4),hist([GOLDx(:,9)-mean(GOLDx(:,9));...
% %     GOLDy(:,9)-mean(GOLDy(:,9));...
% %     GOLDz(:,9)-mean(GOLDz(:,9))],barh);
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,9))
% % ylabel('Rafael M')
% % subplot(4,4,6),plot(RAFy(:,9))
% % subplot(4,4,7),plot(RAFz(:,9))
% % subplot(4,4,8),hist([RAFx(:,9)-mean(RAFx(:,9));...
% %     RAFy(:,9)-mean(RAFy(:,9));...
% %     RAFz(:,9)-mean(RAFz(:,9))],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,9))
% % ylabel('Westbury M')
% % subplot(4,4,10),plot(WMRy(:,9))
% % subplot(4,4,11),plot(WMRz(:,9))
% % subplot(4,4,12),hist([WMRx(:,9)-mean(WMRx(:,9));...
% %     WMRy(:,9)-mean(WMRy(:,9));...
% %     WMRz(:,9)-mean(WMRz(:,9))],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,9))
% % ylabel('Simple Subtraction M')
% % subplot(4,4,14),plot(SSRy(:,9))
% % subplot(4,4,15),plot(SSRz(:,9))
% % subplot(4,4,16),hist([SSRx(:,9)-mean(SSRx(:,9));...
% %     SSRy(:,9)-mean(SSRy(:,9));...
% %     SSRz(:,9)-mean(SSRz(:,9))],barh);
% % %%pause
% % 
% % %% coil 10
% % figure
% % % Gold
% % subplot(4,4,1),plot(GOLDx(:,10))
% % subplot(4,4,2),plot(GOLDy(:,10))
% % subplot(4,4,3),plot(GOLDz(:,10))
% % subplot(4,4,4),hist([GOLDx(:,10)-mean(GOLDx(:,10));...
% %     GOLDy(:,10)-mean(GOLDy(:,10));...
% %     GOLDz(:,10)-mean(GOLDz(:,10))],barh);
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,10))
% % subplot(4,4,6),plot(RAFy(:,10))
% % subplot(4,4,7),plot(RAFz(:,10))
% % subplot(4,4,8),hist([RAFx(:,10)-mean(RAFx(:,10));...
% %     RAFy(:,10)-mean(RAFy(:,10));...
% %     RAFz(:,10)-mean(RAFz(:,10))],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,10))
% % subplot(4,4,10),plot(WMRy(:,10))
% % subplot(4,4,11),plot(WMRz(:,10))
% % subplot(4,4,12),hist([WMRx(:,10)-mean(WMRx(:,10));...
% %     WMRy(:,10)-mean(WMRy(:,10));...
% %     WMRz(:,10)-mean(WMRz(:,10))],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,10))
% % subplot(4,4,14),plot(SSRy(:,10))
% % subplot(4,4,15),plot(SSRz(:,10))
% % subplot(4,4,16),hist([SSRx(:,10)-mean(SSRx(:,10));...
% %     SSRy(:,10)-mean(SSRy(:,10));...
% %     SSRz(:,10)-mean(SSRz(:,10))],barh);
% % %% tongue and lower lip coils
% % 
% % %residual calculations
% % 
% % RRAFx=RAFx-GOLDx;
% % RRAFy=RAFy-GOLDy;
% % RRAFz=RAFz-GOLDz;
% % RWMRx=WMRx-GOLDx;
% % RWMRy=WMRy-GOLDy;
% % RWMRz=WMRz-GOLDz;
% % RSSRx=SSRx-GOLDx;
% % RSSRy=SSRy-GOLDy;
% % RSSRz=SSRz-GOLDz;
% % 
% % %% coil 1
% % figure
% % % gold
% % subplot(4,4,1),plot(GOLDx(:,1))
% % ylabel('Gold M')
% % title('x')
% % subplot(4,4,2),plot(GOLDy(:,1))
% % title('y')
% % subplot(4,4,3),plot(GOLDz(:,1))
% % title('z')
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,1))
% % ylabel('Rafael M')
% % subplot(4,4,6),plot(RAFy(:,1))
% % subplot(4,4,7),plot(RAFz(:,1))
% % subplot(4,4,8),hist([RRAFx(:,1);RRAFy(:,1);RRAFz(:,1)],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,1))
% % ylabel('Westbury M')
% % subplot(4,4,10),plot(WMRy(:,1))
% % subplot(4,4,11),plot(WMRz(:,1))
% % subplot(4,4,12),hist([RWMRx(:,1);RWMRy(:,1);WMRz(:,1)],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,1))
% % ylabel('Simple Subtraction M')
% % subplot(4,4,14),plot(SSRy(:,1))
% % subplot(4,4,15),plot(SSRz(:,1))
% % subplot(4,4,16),hist([RSSRx(:,1);RSSRy(:,1);RSSRz(:,1)],barh);
% % 
% % %% coil 2
% % figure
% % % gold
% % subplot(4,4,1),plot(GOLDx(:,2))
% % subplot(4,4,2),plot(GOLDy(:,2))
% % subplot(4,4,3),plot(GOLDz(:,2))
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,2))
% % subplot(4,4,6),plot(RAFy(:,2))
% % subplot(4,4,7),plot(RAFz(:,2))
% % subplot(4,4,8),hist([RRAFx(:,2);RRAFy(:,2);RRAFz(:,2)],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,2))
% % subplot(4,4,10),plot(WMRy(:,2))
% % subplot(4,4,11),plot(WMRz(:,2))
% % subplot(4,4,12),hist([RWMRx(:,2);RWMRy(:,2);WMRz(:,2)],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,2))
% % subplot(4,4,14),plot(SSRy(:,2))
% % subplot(4,4,15),plot(SSRz(:,2))
% % subplot(4,4,16),hist([RSSRx(:,2);RSSRy(:,2);RSSRz(:,2)],barh);
% % 
% % %% coil 3
% % % gold
% % figure
% % subplot(4,4,1),plot(GOLDx(:,3))
% % ylabel('Gold M')
% % title('x')
% % subplot(4,4,2),plot(GOLDy(:,3))
% % title('y')
% % subplot(4,4,3),plot(GOLDz(:,3))
% % title('z')
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,3))
% % ylabel('Rafael M')
% % subplot(4,4,6),plot(RAFy(:,3))
% % subplot(4,4,7),plot(RAFz(:,3))
% % subplot(4,4,8),hist([RRAFx(:,3);RRAFy(:,3);RRAFz(:,3)],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,3))
% % ylabel('Westbury M')
% % subplot(4,4,10),plot(WMRy(:,3))
% % subplot(4,4,11),plot(WMRz(:,3))
% % subplot(4,4,12),hist([RWMRx(:,3);RWMRy(:,3);WMRz(:,3)],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,3))
% % ylabel('Simple Subtraction M')
% % subplot(4,4,14),plot(SSRy(:,3))
% % subplot(4,4,15),plot(SSRz(:,3))
% % subplot(4,4,16),hist([RSSRx(:,3);RSSRy(:,3);RSSRz(:,3)],barh);
% % 
% % %% coil 7 lower lip
% % 
% % figure
% % % gold
% % subplot(4,4,1),plot(GOLDx(:,7))
% % subplot(4,4,2),plot(GOLDy(:,7))
% % subplot(4,4,3),plot(GOLDz(:,7))
% % 
% % % Rafael
% % subplot(4,4,5),plot(RAFx(:,7))
% % subplot(4,4,6),plot(RAFy(:,7))
% % subplot(4,4,7),plot(RAFz(:,7))
% % subplot(4,4,8),hist([RRAFx(:,7);RRAFy(:,7);RRAFz(:,7)],barh);
% % 
% % %Westbury
% % subplot(4,4,9),plot(WMRx(:,7))
% % subplot(4,4,10),plot(WMRy(:,7))
% % subplot(4,4,11),plot(WMRz(:,7))
% % subplot(4,4,12),hist([RWMRx(:,7);RWMRy(:,7);WMRz(:,7)],barh);
% % 
% % %Simple Subtraction
% % subplot(4,4,13),plot(SSRx(:,7))
% % subplot(4,4,14),plot(SSRy(:,7))
% % subplot(4,4,15),plot(SSRz(:,7))
% % subplot(4,4,16),hist([RSSRx(:,7);RSSRy(:,7);RSSRz(:,7)],barh);
% % 
% % 
% % %% save data
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR9x'],barh9x','folha',excelcol);
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR9y'],barh9y','folha',excelcol);
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR9z'],barh9z','folha',excelcol);
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR10x'],barh10x','folha',excelcol);
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR10y'],barh10y','folha',excelcol);
% % %xlswrite(['D:\JawAnalysis\',sub,'SSR10z'],barh10z','folha',excelcol);
% 
% end
