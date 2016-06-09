function [f1,f12]=frebandselection1pair(freq1,ampfreq1,freq2,ampfreq2,...
    freqco1,cohe1,name1,name2,x1,x12)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Frequency band selection GUI                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Rafael H, ODL, 30/08/10 

scnsize=get(0, 'ScreenSize');

hfig=figure;
 
set(hfig,'color',[0.8 0.8 0.8],'name','frequency band selection',...
    'position',...
    [0.2*scnsize(3),0.05*scnsize(4),0.55*scnsize(3),0.85*scnsize(4)]);
   
uipanel('Title','First Pair','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .06 .95 .88],'HighlightColor','b',...
        'ForegroundColor','b');
   
CPbut=uicontrol('Units','Normalized','Position',[0.4,0.005,0.2,0.05],...
   'String','Calculate Phase','Callback','uiresume(gcbf)','tag','CPbut');%

setappdata(hfig,'CPbut',CPbut);%

uicontrol('Units','Normalized','Position',[0.89 0.94 .1 .05] ,...
     'string','Reset','callback',{@Resetfreq_callback});
 
edit1v=uicontrol('Units','Normalized','Position',[0.6 0.07 .35 .04] ,...
     'string',[num2str(x1) ' ' num2str(x12)],'Style','edit',...
     'tag','edit1','callback',{@edit1_callback});
 
setappdata(hfig,'edit1',edit1v)


uicontrol('Units','Normalized','Position',[0.2 0.07 .4 .04] ,...
     'Style','text','string','Frequency Band:','fontsize',10,...
     'BackgroundColor',[0.93 0.93 0.93]);
         
%axes1=subplot(3,2,1);
axes1=axes('Units','Normalized','Position',[0.1, 0.67, 0.76, 0.22],...
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
axes2=axes('Units','Normalized','Position',[0.1, 0.37, 0.76, 0.22] ,...
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

%axes5=subplot(3,2,5);
axes5=axes('Units','Normalized','Position',[0.1, 0.17, 0.76, 0.11] ,...
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

setappdata(hfig,'h_vline1',h1)
setappdata(hfig,'h_vline2',h2)
setappdata(hfig,'h_vline5',h5)

setappdata(hfig,'h_vline12',h12)
setappdata(hfig,'h_vline22',h22)
setappdata(hfig,'h_vline52',h52)

%final take out update_plot

%low freq in pair 1
move_vline(h1);
move_vline2(h2);
move_vline5(h5);

%high freq in pair 1
move_vline12(h12);
move_vline22(h22);
move_vline52(h52);


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

    
    function Resetfreq_callback(source, eventdata)
                
        set([h1,h2,h5],'xdata',[x1 x1]);
        set([h12,h22,h52],'xdata',[x12 x12]);
        
        set(edit1v,'string',[num2str(x1) ' ' num2str(x12)])
    end

uiwait(hfig); 

x1=get(h2,'xdata');
x12=get(h22,'xdata');

fpair1=sort([x1 x12]);

f1=fpair1(1);
f12=fpair1(3);

close(hfig);

end