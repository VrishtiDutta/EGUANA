function HurstEstimation(sig,xname)

%% definitions

hfig=figure('name',['Hurst analiyze' xname]);

set(hfig,'color',[0.8 0.8 0.8],'name','Hurst Methods',...
'Units','normalized','position',...
[0.2,0.25,0.6,0.5]);

uipanel('Title','Methods','FontSize',12,...
    'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
    'Position',[0.05 0.05 0.9 0.9],'HighlightColor','b',...
    'ForegroundColor','b');

%% Hurst estimation Rafael adaption, more information see husrt_matt.m
[logx,logy]=funhurst(sig);

%% plot the points and bar of linear selection region
figp=axes('position',[0.1 0.3 0.5 0.6]);
points=plot(figp,logx,logy);
xlabel('log window size'), ylabel('log RMS Fluctuation');
hold(figp,'on');
yl=get(figp,'ylim');
widowscale=get(figp,'xlim');
newwidow=...
[widowscale(1)-diff(widowscale)*0.05, widowscale(2)+diff(widowscale)*0.05];
set(figp,'xlim',newwidow,'ylim',yl);
bar1=plot(figp,[logx(1) logx(1)],yl);
bar2=plot(figp,[logx(end) logx(end)],yl);
set([bar1,bar2],'LineWidth',2,'color',[0 0 0])
set(points,'Marker','.','LineStyle','none');

% regression
xroi=logx;
yroi=logy;
p=polyfit(xroi,yroi,1);
yreg=polyval(p,xroi);
reg=plot(xroi,yreg);

% Edit uicontrol
edit1=uicontrol('Units','Normalized','Position',[0.30 0.10 .2 .1] ,...
     'string',[num2str(logx(1)) ' ' num2str(logx(end))],'Style','edit',...
     'tag','edit1','callback',{@edit1_callback});

setappdata(hfig,'points',points)
setappdata(hfig,'edit1',edit1)
setappdata(hfig,'bar1',bar1)
setappdata(hfig,'bar2',bar2)
setappdata(hfig,'reg',reg)

%motion of bar subfuctions
move_bar1(bar1)
move_bar2(bar2)

% Calculate push button
uicontrol('Units','Normalized','Position',[0.525 0.10 .075 .1] ,...
     'string','Calulate','callback',{@cal_callback});

% Texts uincontrols

uicontrol('Units','Normalized','Position',[0.1,0.1,0.15,0.1],...
    'String','linear region','Style','text','BackgroundColor',...
    [0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.625,0.8,0.15,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.8,0.8,0.1,0.1],...
    'String',xname,'Style','text','BackgroundColor',...
    [0.93 0.93 0.93]);

thurstt=uicontrol('Units','Normalized','Position',[0.625,0.675,0.15,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');

taaftt=uicontrol('Units','Normalized','Position',[0.625,0.55,0.15,0.1],...
    'String','AAFT','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


twnt=uicontrol('Units','Normalized','Position',[0.625,0.425,0.15,0.1],...
    'String','White Noise','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


trwt=uicontrol('Units','Normalized','Position',[0.625,0.3,0.15,0.1],...
    'String','Randowm Walk','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


thurst=uicontrol('Units','Normalized','Position',[0.8,0.675,0.1,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


taaft=uicontrol('Units','Normalized','Position',[0.8,0.55,0.1,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


twn=uicontrol('Units','Normalized','Position',[0.8,0.425,0.1,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');

trw=uicontrol('Units','Normalized','Position',[0.8,0.3,0.1,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');

% info text box

uicontrol('Units','Normalized','Position',[0.1,0.1,0.15,0.1],...
    'String','linear region','Style','text','BackgroundColor',...
    [0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.625,0.675,0.15,0.1],...
    'String','Hurst Exponent','Style','text','BackgroundColor',...
    [0.93 0.93 0.93],'visible','off');


    function edit1_callback(source, eventdata)
        ins = eval(['[' get(edit1,'String') ']']);
        
     if(((isnan(ins(1))||~isreal(ins(1))||isnan(ins(2))||~isreal(ins(2))))...
             || ((size(ins,1)~= 1 || size(ins,2)~=2)) || (ins(1)>ins(2))||...
             ins(1)<0||ins(2)<0||ins(1)>6||ins(2)>6)
          
        set(bar1,'xdata',[logx(1) logx(1)]);
        set(bar2,'xdata',[logx(end) logx(end)]);
        
        set(edit1v,'string',[num2str(logx(1)) ' ' num2str(logx(end))])
    
     else
           
        set(bar1,'xdata',[ins(1) ins(1)])
        set(bar2,'xdata',[ins(2) ins(2)])  
            
     end
    end

    function cal_callback(source, eventdata)
        
        % visibileting of titles
        set([thurstt taaftt twnt trwt ],'visible','on');
        
        %hurst exponent calculation
        fr = get(bar1,'XData');
        fr2 = get(bar2,'XData');
        frt=sort([fr(1) fr2(1)]);
        set(edit1,'string',[num2str(frt(1)) ' ' num2str(frt(2))]);
        ind=find( logx>frt(1) & logx<frt(2));
        xroi=logx(ind);
        yroi=logy(ind);
        p=polyfit(xroi,yroi,1);
        yreg=polyval(p,xroi);
        set(reg,'Xdata',xroi,'Ydata',yreg)
        hurst=p(1);
        set(thurst,'string',num2str(hurst),'visible','on');
        
        %AAFT
        %Generate 10 series of amplitude normalized and phase randomized
        %surrogate trials and make a distribution to comper
                
        xaa = AAFT(sig,10);
        hurstAAFT=zeros(1,10);
        for i=1:10
            [logxa,logya]=funhurst(xaa(:,i));
             xroi=logxa(ind);
             yroi=logya(ind);
             p=polyfit(xroi,yroi,1);
             hurstAAFT(i)=p(1);       
        end
        
        %Apply Fisher z-transform
        hurstAAFTZ=0.5*(log((1+hurstAAFT)./(1-hurstAAFT)));     
        hurstAAFTZmean=mean(hurstAAFTZ);
        hurstAAFTZsd=std(hurstAAFTZ);
        hurstAAFTZmeanexp=exp(2* hurstAAFTZmean);
        hurstAAFTZinv=(hurstAAFTZmeanexp-1)/(hurstAAFTZmeanexp+1);
        haalowconf= hurstAAFTZinv-(1.96*hurstAAFTZsd);% p < 0.05 1.96 ; p < .01 2.576
        haahighconf= hurstAAFTZinv+(1.96*hurstAAFTZsd);
        
        if( hurst < haahighconf && hurst > haalowconf )
            gor='g';
        else
            gor='r';
        end

        set(taaft,'string',[num2str(haalowconf),' ',num2str(haahighconf)],...
            'ForegroundColor',gor,'visible','on');
        
%         % white noise
%         wn=2*rand(size(sig,1),10)-1;
%         hurstwn=zeros(1,10);
%         for i=1:10
%             [logxwn,logywn]=funhurst(wn(:,i));
%             xroi=logxwn(ind);
%             yroi=logywn(ind);
%             p=polyfit(xroi,yroi,1);
%             hurstwn(i)=p(1);
%         end
%         
%         %Apply Fisher z-transform
%         %hurstwnZ=0.5*(log((1+hurstwn)./(1-hurstwn)));     
%         %hurstwnZmean=mean(hurstwnZ);
%         %hurstwnZsd=std(hurstwnZ);
%         %hurstwnZmeanexp=exp(2* hurstwnZmean);
%         %hurstwnZinv=(hurstwnZmeanexp-1)/(hurstwnZmeanexp+1);
%         %hwnlowconf= hurstwnZinv-(1.96*hurstwnZsd);% p < 0.05 1.96 ; p < .01 2.576
%         %hwnhighconf= hurstwnZinv+(1.96*hurstwnZsd);
%        
%         
%         if( hurst < hwnhighconf && hurst > hwnlowconf )
%             gor='g';
%         else
%             gor='r';
%         end
% 
%         set(twn,'string',[num2str(hwnlowconf),' ',num2str(hwnhighconf)],...
%             'ForegroundColor',gor,'visible','on');
%         
%         % randow walk
%         hurstrw=zeros(1,10);
%         rw=cumsum(wn);
%         for i=1:10
%             %rw=fbmcircul(length(sig),0.7)';
%             %[logxrw,logyrw]=funhurst(diff(rw));
%             [logxrw,logyrw]=funhurst(rw(:,i));
%             xroi=logxrw(ind);
%             yroi=logyrw(ind);
%             p=polyfit(xroi,yroi,1);
%             hurstrw(i)=p(1);
%         end
%         
%         %Apply Fisher z-transform
%         %hurstrwZ=0.5*(log((1+hurstrw)./(1-hurstrw)));     
%         %hurstrwZmean=mean(hurstrwZ);
%         %hurstrwZsd=std(hurstrwZ);
%         %hurstrwZmeanexp=exp(2* hurstrwZmean);
%         %hurstrwZinv=(hurstrwZmeanexp-1)/(hurstrwZmeanexp+1);
%         %hrwlowconf= hurstrwZinv-(1.96*hurstrwZsd);% p < 0.05 1.96 ; p < .01 2.576
%         %hrwhighconf= hurstrwZinv+(1.96*hurstrwZsd);
%         
%         if( hurst < hrwhighconf && hurst > hrwlowconf )
%             gor='g';
%         else
%             gor='r';
%         end
% 
%         set(trw,'string',[num2str(hrwlowconf),' ',num2str(hrwhighconf)],...
%             'ForegroundColor',gor,'visible','on');
        
        % white noise
        wn=2*rand(1000000,1)-1;
        %hurstwn=zeros(1,10);
        [logxwn,logywn]=funhurst(wn);
         xroi=logxwn;
         yroi=logywn;
         p=polyfit(xroi,yroi,1);
         hurstwn=p(1);   
       
         set(twn,'string',num2str(hurstwn),...
                'visible','on');
        
        % randow walk
        rw=cumsum(wn);
        
        [logxrw,logyrw]=funhurst(diff(rw));
        xroi=logxrw;
        yroi=logyrw;
        p=polyfit(xroi,yroi,1);
        hurstrw=p(1);
        
        %Apply Fisher z-transform
        %hurstrwZ=0.5*(log((1+hurstrw)./(1-hurstrw)));     
        %hurstrwZmean=mean(hurstrwZ);
        %hurstrwZsd=std(hurstrwZ);
        %hurstrwZmeanexp=exp(2* hurstrwZmean);
        %hurstrwZinv=(hurstrwZmeanexp-1)/(hurstrwZmeanexp+1);
        %hrwlowconf= hurstrwZinv-(1.96*hurstrwZsd);% p < 0.05 1.96 ; p < .01 2.576
        %hrwhighconf= hurstrwZinv+(1.96*hurstrwZsd);
        

        set(trw,'string',num2str(hurstrw),...
            'visible','on');
    end
        


end



