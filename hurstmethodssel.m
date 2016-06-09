function [sel]=hurstmethodssel

%Rafael Henriques 

%inicialization
hfig=figure;
sel=1;


set(hfig,'color',[0.8 0.8 0.8],'name','Hurst Methods',...
'Units','normalized','position',...
[0.35,0.35,0.3,0.3]);
   
uipanel('Title','Methods','FontSize',12,...
    'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
    'Position',[.1 .1 .8 .8],'HighlightColor','b',...
    'ForegroundColor','b');

uicontrol('Units','Normalized','Position',[0.3,0.75,0.4,0.1],...
    'String','Hurst Estimation','Callback',{@sel1});

uicontrol('Units','Normalized','Position',[0.3,0.55,0.4,0.1],...
    'String','Hurst Estimation 2','Callback',{@sel2});

uicontrol('Units','Normalized','Position',[0.3,0.35,0.4,0.1],...
    'String','Dave DFA','Callback',{@sel3});

uicontrol('Units','Normalized','Position',[0.3,0.15,0.4,0.1],...
    'String','FAST DFA','Callback',{@sel4});

uicontrol('Units','Normalized','Position',[0.90,0.0,0.1,0.05],...
    'String','Ref','Callback',{@ref});

    function sel1(source, eventdata)
        sel=1;
        uiresume(hfig);
        close(hfig);
    end

    function sel2(source, eventdata)
        sel=2;
        uiresume(hfig);
        close(hfig);
    end
    function sel3(source, eventdata)
        sel=3;
        uiresume(hfig);
        close(hfig);
    end
    function sel4(source, eventdata)
        sel=4;
        uiresume(hfig);
        close(hfig);
    end
    function ref(source, eventdata)
        gui_hurst_ref;
    end

uiwait(hfig)

end
