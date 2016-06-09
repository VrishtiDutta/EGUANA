function[selheadc,seljawc,bite_trial,rest_trial,headcoils,jawcoils,...
    sel,hfig]=CorrectionGUI_HJ(data)
%

%x3d_raw,y3d_raw,z3d_raw,x3d_lp,y3d_lp,z3d_lp,...
 %      x3dpos,y3dpos,z3dpos,phi_lp,theta_lp,phipos,thetapos,posOK,path1)

%Rafael H, ODL, 23/08/10 
% Updated Rafael H. 04/08/11

%scnsize=get(0, 'ScreenSize');

%inicialization
hfig=figure;
sel=1;
anyhead=0;
anyjaw=0;
headcoils=[5 12 11];
jawcoils=[8 12 11];
bite_trial=2;
rest_trial=1;
posOK=data.posOK;

set(hfig,'color',[0.8 0.8 0.8],'name','GUI HEAD & JAW Correction',...
'Units','normalized','position',...
[0.3,0.08,0.5,0.45]);
   
uipanel('Title','Head Correction Methods','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .39 .45 .55],'HighlightColor','b',...
        'ForegroundColor','b');

uipanel('Title','Jaw Correction Methods','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.525 .39 .45 .55],'HighlightColor','b',...
        'ForegroundColor','b');
    
uipanel('Title','Reference Parameters','FontSize',12,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .09 .95 .29],'HighlightColor','b',...
        'ForegroundColor','b');
    
% Botton after Method's Selected
GO=uicontrol('Units','Normalized','Position',[0.35,0.005,0.3,0.08],...
   'String','Continue with corrections','Callback','uiresume(gcbf)',...
   'Enable','off');

% Botton that links to the a more detailed Jaw and Head GUI
uicontrol('Units','Normalized','Position',[0.8,0.95,0.2,0.05],...
   'String','Head/Jaw Corrected GUI','Callback',{@calldetailedGUI});

% Botton that links to a GUI with information of head and Jaw and Head C methods
uicontrol('Units','Normalized','Position',[0.6,0.95,0.2,0.05],...
   'String','Methods Info','Callback',{@callInfo});


%TEXT BOX
uicontrol('Units','Normalized','Position',[0.04,0.25,0.25,0.07],'FontSize',10,...
   'String','Bite Plane Trial','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.04,0.15,0.25,0.07],'FontSize',10,...
   'String','Head Ref Coils','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.5,0.25,0.25,0.07],'FontSize',10,...
   'String','Rest Pos Trial','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.5,0.15,0.25,0.07],'FontSize',10,...
   'String','Ref Jaw Coils','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.27,0.105,0.2,0.05],'FontSize',8,...
   'String','head/nose, r ear, l ear','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.76,0.105,0.2,0.05],'FontSize',8,...
   'String','head/nose, r ref, l ref','Style','text','BackgroundColor',[0.93 0.93 0.93]);

% EDIT BOX
bt=uicontrol('Units','Normalized','Position',[0.31,0.25,0.13,0.07],...
   'String','2','Style','edit','BackgroundColor',[1 1 1],...
   'Callback',{@btrial});

nh=uicontrol('Units','Normalized','Position',[0.31,0.15,0.13,0.07],...
   'String','5 12 11','Style','edit','BackgroundColor',[1 1 1],...
   'Callback',{@nheadc});

rt=uicontrol('Units','Normalized','Position',[0.8,0.25,0.13,0.07],...
   'String','1','Style','edit','BackgroundColor',[1 1 1],...
   'Callback',{@rtrial});

nj=uicontrol('Units','Normalized','Position',[0.8,0.15,0.13,0.07],...
   'String','8 12 11','Style','edit','BackgroundColor',[1 1 1],...
   'Callback',{@njawc});

%HEAD CORRECTION UICONTROL
headtext=uicontrol('Units','Normalized','Position',[0.1,0.8,0.3,0.08],...
   'String','','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.1,0.7,0.3,0.08],...
   'String','1) C. Kroos','Callback',{@selCKHC});

uicontrol('Units','Normalized','Position',[0.1,0.6,0.3,0.08],...
   'String','2) Pos Folder','Callback',{@selPFHC});

uicontrol('Units','Normalized','Position',[0.1,0.5,0.3,0.08],...
   'String','3) R. Henriques (Sagittal Plane)','Callback',{@selRHHC});

uicontrol('Units','Normalized','Position',[0.1,0.4,0.3,0.08],...
   'String','4) No Correction','Callback',{@selNCHC});


%JAW CORRECTION PUSH BUTTONS FUNCTIONS

jawtext=uicontrol('Units','Normalized','Position',[0.6,0.8,0.3,0.08],...
   'String','','Style','text','BackgroundColor',[0.93 0.93 0.93]);

uicontrol('Units','Normalized','Position',[0.6,0.7,0.3,0.08],...
   'String','1) JOANA (RH PvL)','Callback',{@selRHJC});

uicontrol('Units','Normalized','Position',[0.6,0.6,0.3,0.08],...
   'String','2) GOLD (Adapted C. Kroos)','Callback',{@selCKJC});

uicontrol('Units','Normalized','Position',[0.6,0.5,0.3,0.08],...
   'String','3) ER (R. Westbury)','Callback',{@selWMJC});

uicontrol('Units','Normalized','Position',[0.6,0.4,0.3,0.08],...
   'String','4) SS (Simpled Subtraction)','Callback',{@selSSJC});




% GO TO HEAD AND JAW ADVANCED GUI
    function calldetailedGUI(source, eventdata)
        gui_emma3d_jawhead_rafael(data)
        selheadc=[];
        seljawc=[];
        sel=0;
        uiresume(hfig)
        close(hfig)
        
    end

% GO TO HEAD AND JAW INFO
    function callInfo(source, eventdata)
        GUI_INFO_CORRECTIONS       
    end
    

%HEAD CORRECTION CALLBACK FUNCTIONS
    function selRHHC(source, eventdata)
        anyhead=1;
        selheadc=1;
        set(headtext,'string','3) R. Henriques (Sagittal Plane)')
        if(anyjaw)
            set(GO,'Enable','on')
        end
    end
    function selPFHC(source, eventdata)
        if (posOK)
            anyhead=1;
            selheadc=2;
            set(headtext,'string','2) Pos Folder')
            if(anyjaw)
                set(GO,'Enable','on')
            end
        else
            msg={'Pos Folder does not exist!';...
                'Chose other Head correction Method'};
            errordlg(msg,'Error');
        end
    end
    function selCKHC(source, eventdata)
        anyhead=1;
        selheadc=3;
        set(headtext,'string','1) C. Kroos')
        if(anyjaw)
            set(GO,'Enable','on')
        end
    end
    function selNCHC(source, eventdata)
        anyhead=1;
        selheadc=4;
        set(headtext,'string','4) No Correction')
        if(anyjaw)
            set(GO,'Enable','on')
        end
    end

%JAW CORRECTION CALLBACK FUNCTIONS
    function selRHJC(source, eventdata)
        anyjaw=1;
        seljawc=1;
        set(jawtext,'string','1) JOANA (RH PvL)')
        if(anyhead)
            set(GO,'Enable','on')
        end
    end
    function selWMJC(source, eventdata)
        anyjaw=1;
        seljawc=2;
        set(jawtext,'string','3) ER (R. Westbury)')
        if(anyhead)
            set(GO,'Enable','on')
        end
    end
    function selSSJC(source, eventdata)
        anyjaw=1;
        seljawc=3;
        set(jawtext,'string','4) SS (Simple Subtraction)')
        if(anyhead)
            set(GO,'Enable','on')
        end
    end
    function selCKJC(source, eventdata)
        anyjaw=1;
        seljawc=4;
        set(jawtext,'string','2) GOLD (Adapted C. Kroos)')
        if(anyhead)
            set(GO,'Enable','on')
        end
    end

% EDIT BOX CALLBACK
    function btrial(source, eventdata)
        a=str2double(get(bt,'string'));
        if (isreal(a) && (length(a)==1) )
            bite_trial=a;
        else
            set(bt,'string',num2str(bite_trial))
        end
    end
    function rtrial(source, eventdata)
        a=str2double(get(rt,'string'));
        if (isreal(a) && (length(a)==1) )
            rest_trial=a;
        else
            set(rt,'string',num2str(rest_trial))
        end
    end

    function nheadc(source, eventdata)
        a=eval(['[' get(nh,'string') ']']);
        if (isreal(a))% && (length(a)==3))
            headcoils=a;
        else
            set(nh,'string',num2str(headcoils))
        end
    end

    function njawc(source, eventdata)
        a=eval(['[' get(nj,'string') ']']);
        if (isreal(a))% && (length(a)==3) )
            jawcoils=a;
        else
            set(nj,'string',num2str(jawcoils))
        end
    end


uiwait(hfig); 

end