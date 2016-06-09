function figurerelativeband(t1,s1,v1,h1,nz1,zz1,t2,s2,v2,h2,nz2,zz2,...
    nlast,nfirst,rph,rph_nz_unr_deg,aver_phi,RMS,sd_phi,val04,...
    pulstime,starttime,name1,name2)
%%  FIGURE 1 %%


hfig=figure('name',['Relative Phase of pair : ' name1 ' / ' name2]) ;

scnsize=get(0, 'ScreenSize');
set(hfig,'position',...
    [scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
clf;
whitebg(hfig,'black');

a1=subplot('position',[0.08 0.88 0.5 0.09]);
hold on;
plot(t1,s1,'y');
axis([0 max(t1) min(s1) max(s1)]);
ylabel('Nor Pos1');
for j=1:nz1,
    plot(zz1(j),0,'mo');
end

a2=subplot('position',[0.08 0.76 0.5 0.09]);
hold on;
plot(t2,s2,'y');
axis([0 max(t2) min(s2) max(s2)]);
ylabel('Nor Pos2');
for j=1:nz2,
    plot(zz2(j),0,'mo');
end

a3=subplot('position',[0.08 0.64 0.5 0.09]);
hold on;
plot(t1,v1,'y');
axis([0 max(t1) min(v1) max(v1)]);
ylabel('Nor Vel1');


a4=subplot('position',[0.08 0.52 0.5 0.09]);
hold on;
plot(t2,v2,'y');
axis([0 max(t2) min(v2) max(v2)]);
ylabel('Nor Vel2');


a5=subplot('position',[0.08 0.4 0.5 0.09]);
hold on;
plot(t1,h1,'y');
axis([0 max(t1) 0 360]);
ylabel('Phase1(deg)');


a6=subplot('position',[0.08 0.28 0.5 0.09]);
hold on;
plot(t1,h2,'y');
axis([0 max(t1) 0 360]);
ylabel('Phase2(deg)');
nh1=length(h1);% Determine array lengths
nh2=length(h2);
ns1=length(s1);
ns2=length(s2);



subplot('position',[0.84 0.62 0.15 0.25]);
plot(s2,v2,'y');
xlabel('Position2');
ylabel('Velocity2');
axis([-1.1 1.1 -1.1 1.1]);

subplot('position',[0.63 0.62 0.15 0.25]);
plot(s1,v1,'y');
xlabel('Position1');
ylabel('Velocity1');
axis([-1.1 1.1 -1.1 1.1]);

subplot('position',[0.84 0.25 0.15 0.25]);
h1((nlast-1):nh1)=[];
h1(1:(nfirst-1))=[];
h2((nlast-1):nh2)=[];
h2(1:(nfirst-1))=[];
plot(h1,h2,'y.');
axis([0 360 0 360]);
xlabel('Phase1');
ylabel('Phase2');

subplot('position',[0.63 0.25 0.15 0.25]);
s1((nlast-1):ns1)=[];
s1(1:(nfirst-1))=[];
s2((nlast-1):ns2)=[];
s2(1:(nfirst-1))=[];
plot(s1,s2,'y');
axis([-1.1 1.1 -1.1 1.1]);
xlabel('Position1');
ylabel('Position2');

subplot('position',[0.7 0.04 0.16 0.2]);
text(0,0.55,'average of relative phase:');
val01=num2str(aver_phi);
text(0.95,0.55,val01);
text(0,0.4,'R of relative phase:');
val02=num2str(RMS);
text(0.95,0.4,val02);
text(0,0.25,'SD of relative phase:');
val03=num2str(sd_phi);
text(0.95,0.25,val03);
text(0,0.1,'Number of samples:');
text(0.95,0.1,val04);
axis off;

a7=subplot('position',[0.08 0.16 0.5 0.09]);
hold on;
plot(t1,rph,'y');
ylabel('Rel Phase(deg)');
axis([0 max(t1) 0 360]);


% new subplot in figure 1 introduced in rh version
a8=subplot('position',[0.08 0.04 0.5 0.09]);
hold on;
plot(t1(nfirst:nlast),rph_nz_unr_deg,'y');
ymin=min(rph_nz_unr_deg);
axis([0 max(t1) ymin (ymin+360)]);
xlabel('Time (s)');
s=['Corrected     ';'Rel Phase(deg)'];
ylabel(s);

set(0,'ShowHiddenHandles', 'on');
delete (findobj('Tag','AUDIO'));
set(0,'ShowHiddenHandles', 'off');
mmcxy_rh;

uicontrol('Units','Normalized','Position',[0.88 0.95 .1 .04] ,...
    'string','mark pulse point','fontsize',10,'callback',...
    {@markpulspoint_callback});

    function markpulspoint_callback(source, eventdata)
        
        relpulsloc=pulstime-starttime;
        
        ybar=get(a1,'ylim');
        plot(a1,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a2,'ylim');
        plot(a2,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a3,'ylim');
        plot(a3,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a4,'ylim');
        plot(a4,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a5,'ylim');
        plot(a5,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a6,'ylim');
        plot(a6,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a7,'ylim');
        plot(a7,[relpulsloc relpulsloc],ybar, 'b');
        ybar=get(a8,'ylim');
        plot(a8,[relpulsloc relpulsloc],ybar, 'b');
        
        if relpulsloc <=0
            xlim=get(a1,'xlim');
            set([a1,a2,a3,a4,a5,a6,a7,a8],'xlim',[relpulsloc-0.1 xlim(2)])
            warndlg('Relpulslocs <= 0');
        end   
    end

end
