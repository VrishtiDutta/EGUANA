function jawmotionplotrh(x,y,z,rate,ac,rateac)


hf=figure;
 
scnsize=get(0, 'ScreenSize');

set(hf,'color',[0.8 0.8 0.8],'name','Coils Motion',...
    'position',...
    [0.2*scnsize(3),0.05*scnsize(4),0.55*scnsize(3),0.85*scnsize(4)]);
   
panel = uipanel('Title','Coils Motion','FontSize',14,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .025 .96 .96],'HighlightColor','b',...
        'ForegroundColor','b');

xM=ceil(max(max(x)));
yM=ceil(max(max(y)));
zM=ceil(max(max(z)));
xm=floor(min(min(x)));
ym=floor(min(min(y)));
zm=floor(min(min(z)));
M=max([xM,yM,zM]);
m=min([xm,ym,zm]);

%% acoustic plot

hsa=subplot('position',[0.1 0.77 0.8 0.15],'parent',panel);
hold(hsa,'on')

%acoustic
plot((1:length(ac))/rateac,ac),
acYMn=get(hsa,'ylim');

%bar
hbar=plot([1/rate 1/rate],acYMn);

%axes difinitions
set(hbar,'tag','bar','color','black')
xlabel('time s'),title('acoustic')

%% 3D plot

hs1=subplot('position',[0.1 0.1 0.8 0.6]);

%tongue coils, 1 2 and 3
htongue=plot3(hs1,[x(1,1) x(1,2) x(1,3)],[y(1,1) y(1,2) y(1,3)],...
    [z(1,1) z(1,2) z(1,3)]);
set(htongue,'tag','tongue','color','r','LineWidth',2)
hold(hs1,'on')

%reference coils
href=plot3(hs1,[x(1,4) x(1,5) x(1,11) x(1,12)],...
               [y(1,4) y(1,5) y(1,11) y(1,12)],...
               [z(1,4) z(1,5) z(1,11) z(1,12)]);
set(href,'tag','ref','color','black','LineStyle','none','Marker','.',...
    'Markersize',12)

%mouth coils
hmouth=plot3(hs1,[x(1,6) x(1,7)],[y(1,6) y(1,7)],[z(1,6) z(1,7)]);
set(hmouth,'tag','mouth','color',[1 0.4 0],'Marker','.',...
    'Markersize',12,'LineStyle','none')

%jaw coil
hjaw=plot3(hs1,[x(1,9) x(1,8) x(1,10)],[y(1,9) y(1,8) y(1,10)],...
    [z(1,9) z(1,8) z(1,10)]);
set(hjaw,'tag','jaw','Marker','.','Markersize',12,'LineStyle','none')

%axes definitions
set(hs1,'xlim',[m, M],'ylim',[m,M],'zlim',[m,M])
grid on
view(42,16)
xlabel('x (mm)'),ylabel('y (mm)'),zlabel('z (mm)')


%% Motion
for i=2:length(x)
set(htongue,'xdata',[x(i,1) x(i,2) x(i,3)],'ydata',[y(i,1) y(i,2) y(i,3)],...
    'zdata',[z(i,1) z(i,2) z(i,3)])
set(hbar,'xdata',[i i]/rate)
set(href,'xdata',[x(i,4) x(i,5) x(i,11) x(i,12)],...
    'ydata',[y(i,4) y(i,5) y(i,11) y(i,12)],...
    'zdata',[z(i,4) z(i,5) z(i,11) z(i,12)])
set(hmouth,'xdata',[x(i,6) x(i,7)],'ydata',[y(i,6) y(i,7)],...
    'zdata',[z(i,6) z(i,7)])
set(hjaw,'xdata',[x(i,9) x(i,8) x(i,10)],...
         'ydata',[y(i,9) y(i,8) y(i,10)],...
         'zdata',[z(i,9) z(i,8) z(i,10)])
drawnow,%pause(0.01)
end





