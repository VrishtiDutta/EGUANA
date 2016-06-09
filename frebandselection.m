function [f1,f12,f2,f22]=frebandselection(freq1,ampfreq1,freq2,ampfreq2,...
    freq3,ampfreq3,freq4,ampfreq4,freqco1,cohe1,freqco2,cohe2,...
    name1,name2,name3,name4,x1,x12,x2,x22)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Frequency band selection GUI                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Rafael H, ODL, 29/07/10 

scnsize=get(0, 'ScreenSize');

hfig=figure;
 
set(hfig,'color',[0.8 0.8 0.8],'name','frequency band selection',...
    'position',...
    [0.2*scnsize(3),0.05*scnsize(4),0.55*scnsize(3),0.85*scnsize(4)]);
   
firstPair = uipanel('Parent', hfig,'Title','First Pair','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .06 .45 .88],'HighlightColor','b',...
        'ForegroundColor','b');

secondPair = uipanel('Parent', hfig,'Title','Second Pair','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.525 .06 .45 .88],'HighlightColor','b',...
        'ForegroundColor','b');
    
CPbut=uicontrol('Units','Normalized','Position',[0.4,0.005,0.2,0.05],...
   'String','Calculate Phase','Callback','uiresume(gcbf)','tag','CPbut');%

setappdata(hfig,'CPbut',CPbut);%

uicontrol('Units','Normalized','Position',[0.89 0.94 .1 .05] ,...
     'string','Reset','callback',{@Resetfreq_callback});
 
edit1v=uicontrol('Units','Normalized','Position',[0.265 0.07 .2 .04] ,...
     'string',[num2str(x1) ' ' num2str(x12)],'Style','edit',...
     'tag','edit1','callback',{@edit1_callback});
 
setappdata(hfig,'edit1',edit1v)

         
edit2v=uicontrol('Units','Normalized','Position',[0.765 0.07 .2 .04] ,...
     'string',[num2str(x2) ' ' num2str(x22)],'Style','edit',...
     'tag','edit2','callback',{@edit2_callback});  
 
setappdata(hfig,'edit2',edit2v)

uicontrol('Units','Normalized','Position',[0.05 0.07 .2 .04] ,...
     'Style','text','string','Frequency Band:','fontsize',10,...
     'BackgroundColor',[0.93 0.93 0.93]);
         
uicontrol('Units','Normalized','Position',[0.55 0.07 .2 .04] ,...
     'Style','text','string','Frequency Band:','fontsize',10,...
     'BackgroundColor',[0.93 0.93 0.93]);    
 
%axes1=subplot(3,2,1);
axes1=axes('Parent', firstPair,'Units','Normalized','Position',[0.07, 0.67, 0.70, 0.22],...
    'XMinorGrid','on','YminorGrid','on');
hold(axes1, 'on')
plot(axes1,freq1,ampfreq1,'b','LineWidth',2);
y1=get(axes1,'ylim');
h1=plot(axes1,[x1 x1],y1,'-');
xlim(axes1,[0 6])
h12=plot(axes1,[x12 x12],y1,'-'); 
hold(axes1,'off')
set(h1,'tag','h_vline1','handlevisibility','off')
set(h1,'LineWidth',2,'color',[0 0 0],'UserData',x1)
set(h12,'tag','h_vline12','handlevisibility','off')
set(h12,'LineWidth',2,'color',[0 0 0],'UserData',x12)
title(axes1,name1)

%axes2=subplot(3,2,3);
axes2=axes('Parent', firstPair,'Units','Normalized','Position',[0.07, 0.37, 0.70, 0.22] ,...
    'XMinorGrid','on','YminorGrid','on');

hold(axes2,'on')
plot(axes2,freq2,ampfreq2,'b','LineWidth',2);
y2=get(axes2,'ylim');
h2=plot(axes2,[x1 x1],y2,'-');
xlim(axes2,[0 6])
h22=plot(axes2,[x12 x12],y2,'-');
hold(axes2,'off')
set(h2,'tag','h_vline2','handlevisibility','off')
set(h2,'LineWidth',2,'color',[0 0 0],'UserData',x1)
set(h22,'tag','h_vline22','handlevisibility','off')
set(h22,'LineWidth',2,'color',[0 0 0],'UserData',x12)
title(axes2,name2)

%axes3=subplot(3,2,2);
axes3=axes('Parent', secondPair,'Units','Normalized','Position',[0.07, 0.67, 0.70, 0.22] ,...
    'XMinorGrid','on','YminorGrid','on');
hold(axes3,'on')
plot(axes3,freq3,ampfreq3,'b','LineWidth',2);
y3=get(axes3,'ylim');
h3=plot(axes3,[x2 x2],y3,'-');
xlim(axes3,[0 6])
h32=plot(axes3,[x22 x22],y3,'-');
hold(axes3,'off')
set(h3,'tag','h_vline3','handlevisibility','off')
set(h3,'LineWidth',2,'color',[0 0 0],'UserData',x2)
set(h32,'tag','h_vline32','handlevisibility','off')
set(h32,'LineWidth',2,'color',[0 0 0],'UserData',x22)
title(axes3,name3)

%axes4=subplot(3,2,4);
axes4=axes('Parent', secondPair,'Units','Normalized','Position',[0.07, 0.37, 0.70, 0.22] ,...
    'XMinorGrid','on','YminorGrid','on');
hold(axes4,'on')
plot(axes4,freq4,ampfreq4,'b','LineWidth',2);
y4=get(axes4,'ylim');
h4=plot(axes4,[x2 x2],y4,'-');
xlim(axes4,[0 6])
h42=plot(axes4,[x22 x22],y4,'-');
hold(axes4,'off')
set(h4,'tag','h_vline4','handlevisibility','off')
set(h4,'LineWidth',2,'color',[0 0 0],'UserData',x2)
set(h42,'tag','h_vline42','handlevisibility','off')
set(h42,'LineWidth',2,'color',[0 0 0],'UserData',x22)
title(axes4,name4)

%axes5=subplot(3,2,5);
axes5=axes('Parent', firstPair,'Units','Normalized','Position',[0.07, 0.17, 0.70, 0.11] ,...
    'XMinorGrid','on','YminorGrid','on');
hold(axes5,'on')
plot(axes5,freqco1,cohe1,'b','LineWidth',2);
y5=get(axes5,'ylim');
h5=plot(axes5,[x1 x1],y5,'-');
xlim(axes5,[0 6])
h52=plot(axes5,[x12 x12],y5,'-');
hold(axes5,'off')
set(h5,'tag','h_vline5','handlevisibility','off')
set(h5,'LineWidth',2,'color',[0 0 0],'UserData',x1)
set(h52,'tag','h_vline52','handlevisibility','off')
set(h52,'LineWidth',2,'color',[0 0 0],'UserData',x12)
title(axes5,'Coherence'),xlabel(axes5,'Hz')

%axes6=subplot(3,2,6);
axes6=axes('Parent', secondPair,'Units','Normalized','Position',[0.07, 0.17, 0.70, 0.11] ,...
    'XMinorGrid','on','YminorGrid','on');
hold(axes6,'on')
plot(axes6,freqco2,cohe2,'b','LineWidth',2);
y6=get(axes6,'ylim');
h6=plot(axes6,[x2 x2],y6,'-');
xlim(axes6,[0 6])
h62=plot(axes6,[x22 x22],y6,'-');
hold(axes6,'off')
set(h6,'tag','h_vline6','handlevisibility','off')
set(h6,'LineWidth',2,'color',[0 0 0],'UserData',x2)
set(h62,'tag','h_vline62','handlevisibility','off')
set(h62,'LineWidth',2,'color',[0 0 0],'UserData',x22)
title(axes6,'Coherence'),xlabel(axes6,'Hz')

setappdata(hfig,'h_vline1',h1)
setappdata(hfig,'h_vline2',h2)
setappdata(hfig,'h_vline3',h3)
setappdata(hfig,'h_vline4',h4)
setappdata(hfig,'h_vline5',h5)
setappdata(hfig,'h_vline6',h6)

setappdata(hfig,'h_vline12',h12)
setappdata(hfig,'h_vline22',h22)
setappdata(hfig,'h_vline32',h32)
setappdata(hfig,'h_vline42',h42)
setappdata(hfig,'h_vline52',h52)
setappdata(hfig,'h_vline62',h62)

%final take out update_plot

%low freq in pair 1
move_vline(h1);
move_vline2(h2);
move_vline5(h5);

%high freq in pair 1
move_vline12(h12);
move_vline22(h22);
move_vline52(h52);

%low freq in pair 2
move_vline3(h3);
move_vline4(h4);
move_vline6(h6);

%high freq in pair 2
move_vline32(h32);
move_vline42(h42);
move_vline62(h62);

    function edit1_callback(source, eventdata)
        ins = eval(['[' get(edit1v,'String') ']']);
        
     if(((isnan(ins(1))||~isreal(ins(1))||isnan(ins(2))||~isreal(ins(2))))...
             || ((size(ins,1)~= 1 || size(ins,2)~=2)) || (ins(1)>ins(2))||...
             ins(1)<0||ins(2)<0||ins(1)>6||ins(2)>6)
          
        set([h1,h2,h5],'xdata',[x1 x1]);
        set([h12,h22,h52],'xdata',[x12 x12]);
        
        set(edit1v,'string',[num2str(x1) ' ' num2str(x12)])
    
     else
           
        set([h1,h2,h5],'xdata',[ins(1) ins(1)])
        set([h12,h22,h52],'xdata',[ins(2) ins(2)])    
            
     end
    end

    function edit2_callback(source, eventdata)
        inc = eval(['[' get(edit2v,'String') ']']);
        
     if(((isnan(inc(1))||~isreal(inc(1))||isnan(inc(2))||~isreal(inc(2))))...
             || ((size(inc,1)~= 1 || size(inc,2)~=2)) || (inc(1)>inc(2))||...
             inc(1)<0||inc(2)<0||inc(1)>6||inc(2)>6)
          
        set([h3,h4,h6],'xdata',[x2 x2]);
        set([h32,h42,h62],'xdata',[x22 x22]);
        
        set(edit2v,'string',[num2str(x2) ' ' num2str(x22)])
    
     else
                    
        set([h3,h4,h6],'xdata',[inc(1) inc(1)])
        set([h32,h42,h62],'xdata',[inc(2) inc(2)])    
            
     end
    end

    function Resetfreq_callback(source, eventdata)
                
        set([h1,h2,h5],'xdata',[x1 x1]);
        set([h12,h22,h52],'xdata',[x12 x12]);
        set([h3,h4,h6],'xdata',[x2 x2]);
        set([h32,h42,h62],'xdata',[x22 x22]);
        
        set(edit1v,'string',[num2str(x1) ' ' num2str(x12)])
        set(edit2v,'string',[num2str(x2) ' ' num2str(x22)])
    end

uiwait(hfig); 

x1=get(h2,'xdata');
x12=get(h22,'xdata');
x2=get(h3,'xdata');
x22=get(h32,'xdata');

fpair1=sort([x1 x12]);
fpair2=sort([x2 x22]);

f1=fpair1(1);
f12=fpair1(3);
f2=fpair2(1);
f22=fpair2(3);

close(hfig);

end
