function motionplotr(x1,y1,z1,x2,y2,z2,x3,y3,z3,rate,ac,rateac)

xM=ceil(max([x1;x2;x3]));
yM=ceil(max([y1;y2;y3]));
zM=ceil(max([z1;z2;z3]));
xm=floor(min([x1;x2;x3]));
ym=floor(min([y1;y2;y3]));
zm=floor(min([z1;z2;z3]));

hf=figure;
subplot(2,1,2)
ho=plot3([x1(1) x2(1) x3(1)],[y1(1) y2(1) y3(1)],[z1(1) z2(1) z3(1)]);
xlim([xm, xM]),ylim([ym,yM]),zlim([zm,zM])
grid on
xlabel('x'),ylabel('y'),zlabel('z')
set(ho,'tag','tongue','color','r')
setappdata(hf,'tongue',ho);

hs=subplot(2,1,1);
hold(hs,'on')
plot((1:length(ac))/rateac,ac),
acYMn=get(hs,'ylim');
ho2=plot([1/rate 1/rate],acYMn);
set(ho2,'tag','bar','color','black')
setappdata(hf,'bar',ho2);

for i=2:length(x1)
set(ho,'xdata',[x1(i) x2(i) x3(i)],'ydata',[y1(i) y2(i) y3(i)],'zdata',...
    [z1(i) z2(i) z3(i)])
set(ho2,'xdata',[i i]/rate)

drawnow,%pause(0.01)
end





