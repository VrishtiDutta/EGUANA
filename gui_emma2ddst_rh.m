function varargout = gui_emma2ddst_rh(varargin)
% GUI_EMMA2DDST_RH M-file for gui_emma2ddst_rh.fig
%      GUI_EMMA2DDST_RH, by itself, creates a new GUI_EMMA2DDST_RH or raises the existing
%      singleton*.
%
%      H = GUI_EMMA2DDST_RH returns the handle to a new GUI_EMMA2DDST_RH or the handle to
%      the existing singleton*.
%
%      GUI_EMMA2DDST_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EMMA2DDST_RH.M with the given input arguments.
%
%      GUI_EMMA2DDST_RH('Property','Value',...) creates a new GUI_EMMA2DDST_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_2dv2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_emma2ddst_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_emma2ddst_rh

% Last Modified by GUIDE v2.5 06-Aug-2010 12:10:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_emma2ddst_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_emma2ddst_rh_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


%% --- Executes just before gui_emma2ddst_rh is made visible.
function gui_emma2ddst_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_emma2ddst_rh (see VARARGIN)

data2d = varargin{1};
handles.x2d = data2d.x2d;
handles.y2d = data2d.y2d;
handles.x2d_raw = data2d.x2d_raw;
handles.y2d_raw = data2d.y2d_raw;
handles.x2dc=data2d.x2dc;
handles.y2dc=data2d.y2dc;
handles.currentdatax=data2d.x2d;
handles.currentdatay=data2d.y2d;
handles.bc = data2d.bc2d;
handles.td = data2d.td2d;
handles.tt = data2d.tt2d;
handles.tb = data2d.tb2d;
handles.ac = data2d.ac2d;
handles.tri = data2d.tri2d;
handles.sess = data2d.sess2d;
handles.sub = data2d.sub2d;
handles.respath = data2d.respath2d;
handles.t=(1:1:(size(data2d.x2d,1)))/200; %note sampling freq is 200Hz  
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale=[char(39) 'auto' char(39)];
handles.rucbx='ubb';
handles.rucby='ubb';
handles.figsub=1;
handles.fig=2;

openall(handles)

% initializing signals to analyze
handles.sig1 = [];
handles.sig2 = [];
handles.sig3 = [];
handles.sig4 = [];

% initializing signals to see in maximaze option (push button '[]')
handles.sigmax1 = [];
handles.sigmax2 = [];
handles.sigmax3 = [];
handles.sigmax4 = [];

% initializing signals to see in subplots option (push button '=')
handles.sigsub1 = [];
handles.sigsub2 = [];
handles.sigsub3 = [];
handles.sigsub4 = [];

gui_emma_instructions_rh;

% Modify Display Settings

set(handles.int_selec_display, 'String',['0 ' num2str(handles.lim(2))]) 

% Choose default command line output for gui_emma2ddst_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_emma2ddst_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% --- Outputs from this function are returned to the command line.
function varargout = gui_emma2ddst_rh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
function openall(handles)
% open or refresh all GUI plots
% date: 08/07/10 by: Rafael Henriques ODL

fs = 8; % fontsize for plotting

%note sampling freq of accoustict is 16000 Hz 
plot(handles.ac_axes1,(1:length(handles.ac))/16000,handles.ac);
set(handles.ac_axes1,'YTick',[],'XLim',handles.lim,'fontsize',fs);
xlabel(handles.ac_axes1,'time (s)');

%positions
currentplotx(handles)
currentploty(handles)

%Gestures
plot(handles.bc_axes,handles.t,handles.bc);
set(handles.bc_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.bc_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.bc_axes,'YLim',handles.limscale)
end

plot(handles.tb_axes,handles.t,handles.tb);
set(handles.tb_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.tb_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tb_axes,'YLim',handles.limscale)
end

plot(handles.tt_axes,handles.t,handles.tt);
set(handles.tt_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.tt_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tt_axes,'YLim',handles.limscale)
end

plot(handles.td_axes,handles.t,handles.td);
set(handles.td_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.td_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.td_axes,'YLim',handles.limscale)
end

%% X push buttons in rigth corner
% --- Executes on button press in btdx.
function btdx_Callback(hObject, eventdata, handles)
% hObject    handle to btdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',1,'td ');

% --- Executes on button press in btdy.
function btdy_Callback(hObject, eventdata, handles)
% hObject    handle to btdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',1,'td ');

% --- Executes on button press in btbx.
function btbx_Callback(hObject, eventdata, handles)
% hObject    handle to btbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',2,'tb ');

% --- Executes on button press in bttx.
function bttx_Callback(hObject, eventdata, handles)
% hObject    handle to bttx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',3,'tt ');

% --- Executes on button press in bnx.
function bnx_Callback(hObject, eventdata, handles)
% hObject    handle to bnx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',5,'n ');

% --- Executes on button press in bulx.
function bulx_Callback(hObject, eventdata, handles)
% hObject    handle to bulx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',6,'ul ');

% --- Executes on button press in bllx.
function bllx_Callback(hObject, eventdata, handles)
% hObject    handle to bllx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',7,'ll ');

% --- Executes on button press in bjx.
function bjx_Callback(hObject, eventdata, handles)
% hObject    handle to bjx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',8,'jaw ');

% --- Executes on button press in blcx.
function blcx_Callback(hObject, eventdata, handles)
% hObject    handle to blcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',9,'ref1 ');

% --- Executes on button press in brcx.
function brcx_Callback(hObject, eventdata, handles)
% hObject    handle to brcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',10,'ref2 ');

% --- Executes on button press in btby.
function btby_Callback(hObject, eventdata, handles)
% hObject    handle to btby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',2,'tb ');

% --- Executes on button press in btty.
function btty_Callback(hObject, eventdata, handles)
% hObject    handle to btty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',3,'tt ');

% --- Executes on button press in bny.
function bny_Callback(hObject, eventdata, handles)
% hObject    handle to bny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',5,'n ');

% --- Executes on button press in buly.
function buly_Callback(hObject, eventdata, handles)
% hObject    handle to buly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',6,'ul ');

% --- Executes on button press in blly.
function blly_Callback(hObject, eventdata, handles)
% hObject    handle to blly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',7,'ll ');

% --- Executes on button press in bjy.
function bjy_Callback(hObject, eventdata, handles)
% hObject    handle to bjy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',8,'jaw ');

% --- Executes on button press in blcy.
function blcy_Callback(hObject, eventdata, handles)
% hObject    handle to blcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',9,'ref1');

% --- Executes on button press in brcy.
function brcy_Callback(hObject, eventdata, handles)
% hObject    handle to brcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',10,'ref2');

% --- Executes on button press in pushbutton_bc.
function pushbutton_bc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'BC',0);

% --- Executes on button press in pushbutton_tb.
function pushbutton_tb_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TB',0);

% --- Executes on button press in pushbutton_tt.
function pushbutton_tt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TT',0);

% --- Executes on button press in pushbutton_td.
function pushbutton_td_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TD',0);



function sig2(hObject, eventdata, handles, dim, ch, chtag);
% this function changes the selected signals in the bottom right of
% gui_emma2ddst_rh so you can choose which 2 signals to analyze

%last update: 07/07/10 by Rafael Henriques ODL


if (strcmp(dim,'x '))
    sig = handles.currentdatax;
elseif (strcmp(dim,'y '))
    sig = handles.currentdatay;
elseif (strcmp(dim,'BC'))
    sig = handles.bc;
elseif (strcmp(dim,'TD'))
    sig = handles.td;
elseif (strcmp(dim,'TT'))
    sig = handles.tt;
elseif (strcmp(dim,'TB'))
    sig = handles.tb;
end

if ch == 0
    sig_string = dim;
    ch = 1;
else
    if strcmp(dim,'x '), sig_string = [chtag, dim, handles.rucbx(1)]; 
    elseif strcmp(dim,'y '),  sig_string = [chtag,dim,handles.rucby(1)];
    end
end

if isempty(handles.sig1)
    
%     fs=200;
%     handles.t0=ceil(handles.lim(1)*fs);
%     handles.tf=floor(handles.lim(2)*fs);
%     lentmax=length(handles.x2d);
%     
%     if handles.t0 <=0, handles.t0=1; end
%     if handles.tf >=lentmax, handles.tf=lentmax; end
%     
    handles.sig1 = sig(:,ch);
    
    set(handles.sig_ana_1,'string',sig_string);
    set(handles.int_selec_display,'enable','off')
    set(handles.warningtext,'String',...
'Cannot change interval selection! All 4 signals for analysis must have the same length')
    
elseif isempty(handles.sig2)
    handles.sig2 = sig(:,ch);
    set(handles.sig_ana_2,'string',sig_string);
elseif isempty(handles.sig3)
    handles.sig3 = sig(:,ch);
    set(handles.sig_ana_3,'string',sig_string);
elseif isempty(handles.sig4)
    handles.sig4 = sig(:,ch);
    set(handles.sig_ana_4,'string',sig_string);
else % rotate the signals (i.e. sig 1 becomes sig 2 and sig 2 becomes new selection)
    handles.sig1 = handles.sig2;
    handles.sig2 = handles.sig3;
    handles.sig3 = handles.sig4;    
    handles.sig4 = sig(:,ch);
    set(handles.sig_ana_1','string',get(handles.sig_ana_2,'String'));
    set(handles.sig_ana_2','string',get(handles.sig_ana_3,'String'));
    set(handles.sig_ana_3','string',get(handles.sig_ana_4,'String'));
    set(handles.sig_ana_4,'string',sig_string);
end
guidata(hObject, handles);


%% signal to analyze panel display
function sig_ana_1_Callback(hObject, eventdata, handles)
% hObject    handle to sig_ana_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_ana_1 as text
%        str2double(get(hObject,'String')) returns contents of sig_ana_1 as a double


% --- Executes during object creation, after setting all properties.
function sig_ana_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_ana_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sig_ana_2_Callback(hObject, eventdata, handles)
% hObject    handle to sig_ana_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_ana_2 as text
%        str2double(get(hObject,'String')) returns contents of sig_ana_2 as a double


% --- Executes during object creation, after setting all properties.
function sig_ana_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_ana_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sig_ana_3_Callback(hObject, eventdata, handles)
% hObject    handle to sig_ana_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_ana_3 as text
%        str2double(get(hObject,'String')) returns contents of sig_ana_3 as a double


% --- Executes during object creation, after setting all properties.
function sig_ana_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_ana_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sig_ana_4_Callback(hObject, eventdata, handles)
% hObject    handle to sig_ana_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_ana_4 as text
%        str2double(get(hObject,'String')) returns contents of sig_ana_4 as a double


% --- Executes during object creation, after setting all properties.
function sig_ana_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_ana_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Analysis push button

% --- Executes on button press in csti.
function csti_Callback(hObject, eventdata, handles)
% hObject    handle to csti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (isempty(handles.sig1)||isempty(handles.sig2) ||isempty(handles.sig3)...
    ||isempty(handles.sig4)), cancel_csti = 1; 
else cancel_csti = 0;
end

if cancel_csti == 0
    sig1_string = get(handles.sig_ana_1,'string');
    sig2_string = get(handles.sig_ana_2,'string');
    sig3_string = get(handles.sig_ana_3,'string');
    sig4_string = get(handles.sig_ana_4,'string');
    
    [path,finam,tnum,subnam] = csti_3d_rhv2(handles.sig1, handles.sig2,...
        handles.sig3, handles.sig4,...
        sig1_string, sig2_string, sig3_string, sig4_string, handles.ac, handles.tri,...
        handles.respath,handles.sub,handles.sess,handles.lim,200);
else
    errordlg('Please select 4 signals to analyze','Error');
end

% --- Executes on button press in crqa1.
function crqa1_Callback(hObject, eventdata, handles)
% hObject    handle to crqa1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if (isempty(handles.sig1) || isempty(handles.sig2)), cancel_crqa = 1; 
else cancel_crqa = 0; 
end

if cancel_crqa == 0
    sig1_string = get(handles.sig_ana_1,'string');
    sig2_string = get(handles.sig_ana_2,'string');

    
    gui_crqa_rh(handles.sig1, handles.sig2, sig1_string, sig2_string,...
      handles.respath, handles.sess, handles.tri, handles.sub,handles.lim);

else
    errordlg('Please select signals 1 and 2 to analyze','Error');
end

% --- Executes on button press in crqa2.
function crqa2_Callback(hObject, eventdata, handles)
% hObject    handle to crqa2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (isempty(handles.sig3) || isempty(handles.sig4)), cancel_crqa = 1; 
else cancel_crqa = 0; 
end

if cancel_crqa == 0
    sig3_string = get(handles.sig_ana_3,'string');
    sig4_string = get(handles.sig_ana_4,'string');
    
    
    gui_crqa_rh(handles.sig3, handles.sig4, sig3_string, sig4_string,...
      handles.respath, handles.sess, handles.tri, handles.sub,handles.lim);
   
else
    errordlg('Please select signals 3 and 4 to analyze','Error');
end


% --- Executes on button press in disph.
function disph_Callback(hObject, eventdata, handles)
% hObject    handle to disph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_disp_select_2d(handles);



%% push button play

% --- Executes on button press in play_ac.
function play_ac_Callback(hObject, eventdata, handles)
% hObject    handle to play_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%sound(handles.ac,16000);

acfs=16000; %acoustic sampling frequency
t0ac=ceil(handles.lim(1)*acfs);
tfac=floor(handles.lim(2)*acfs);
lenmaxac=length(handles.ac);

if t0ac <=0, t0ac=1; end
if tfac >=lenmaxac, tfac=lenmaxac; end

soundsc(handles.ac(t0ac:tfac),acfs);


%% Push Buttons raw, uncorrect, correct, both

% --- Executes on button press in pushbutton_rawx.
function pushbutton_rawx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x2d_raw;
handles.rucbx='rrr';

currentplotx(handles)
pushbuttonxonX_rh(handles)

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton_uncorrectx.
function pushbutton_uncorrectx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrectx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.currentdatax=handles.x2d;
handles.rucbx='ubb';

currentplotx(handles)
pushbuttonxonX_rh(handles)
    
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton_correctx.
function pushbutton_correctx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correctx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x2dc;
handles.rucbx='cbg';

currentplotx(handles)
pushbuttonxonX_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_bothx.
function pushbutton_bothx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bothx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
handles.currentdatax=[];

currentplotx(handles) 
pushbuttonxonX_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

    

% --- Executes on button press in pushbutton_rawy.
function pushbutton_rawy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y2d_raw;
handles.rucby='rrr';


currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_uncorrecty.
function pushbutton_uncorrecty_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrecty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y2d;
handles.rucby='ubb';

currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_correcty.
function pushbutton_correcty_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correcty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y2dc;
handles.rucby='cbg';

currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_bothy.
function pushbutton_bothy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bothy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=[];

currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

    
    
function currentplotx(handles)
% change the display of the 2d channel X positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 08/07/10

fs=8;% fontsize for plotting

if (~isempty(handles.currentdatax))
    plot(handles.tdx,handles.t,handles.currentdatax(:,1),handles.rucbx(3));
    set(handles.tdx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdx,'YLim',handles.limscale)
    end
    
       
    plot(handles.tbx,handles.t,handles.currentdatax(:,2),handles.rucbx(3));
    set(handles.tbx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbx,'YLim',handles.limscale)
    end
       
    plot(handles.ttx,handles.t,handles.currentdatax(:,3),handles.rucbx(3));
    set(handles.ttx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttx,'YLim',handles.limscale)
    end
    
    plot(handles.nox,handles.t,handles.currentdatax(:,5),handles.rucbx(2));
    set(handles.nox,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.ttx,'YLim',handles.limscale)
    end
    
    plot(handles.ulx,handles.t,handles.currentdatax(:,6),handles.rucbx(2));
    set(handles.ulx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ulx,'YLim',handles.limscale)
    end
    
    plot(handles.llx,handles.t,handles.currentdatax(:,7),handles.rucbx(3));
    set(handles.llx,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.llx,'YLim',handles.limscale)
    end
    
    plot(handles.jax,handles.t,handles.currentdatax(:,8),handles.rucbx(2));
    set(handles.jax,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jax,'YLim',handles.limscale)
    end
    
    plot(handles.lcx,handles.t,handles.currentdatax(:,9),handles.rucbx(2));
    set(handles.lcx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcx,'YLim',handles.limscale)
    end
    
   plot(handles.rcx,handles.t,handles.currentdatax(:,10),handles.rucbx(2));
   set(handles.rcx,'fontsize',fs,'XLim',handles.lim);
   xlabel(handles.rcx,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.rcx,'YLim',handles.limscale)
   end
   
else
    plot(handles.tdx,handles.t,handles.x2d(:,1),'b',...
                     handles.t,handles.x2dc(:,1),'g');
    set(handles.tdx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdx,'YLim',handles.limscale)
    end
    
    plot(handles.tbx,handles.t,handles.x2d(:,2),'b',...
                     handles.t,handles.x2dc(:,2),'g');
    set(handles.tbx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbx,'YLim',handles.limscale)
    end
   
    plot(handles.ttx,handles.t,handles.x2d(:,3),'b',...
                     handles.t,handles.x2dc(:,3),'g');
    set(handles.ttx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttx,'YLim',handles.limscale)
    end
    
    plot(handles.nox,handles.t,handles.x2d(:,5),'b');
    set(handles.nox,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.nox,'YLim',handles.limscale)
    end
    
    plot(handles.ulx,handles.t,handles.x2d(:,6),'b');
    set(handles.ulx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ulx,'YLim',handles.limscale)
    end
   
    plot(handles.llx,handles.t,handles.x2d(:,7),'b',...
                     handles.t,handles.x2dc(:,7),'g');
    set(handles.llx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.llx,'YLim',handles.limscale)
    end
    
    plot(handles.jax,handles.t,handles.x2d(:,8),'b');
    set(handles.jax,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jax,'YLim',handles.limscale)
    end
    
    plot(handles.lcx,handles.t,handles.x2d(:,9),'b');
    set(handles.lcx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcx,'YLim',handles.limscale)
    end
    
    plot(handles.rcx,handles.t,handles.x2d(:,10),'b');
    set(handles.rcx,'fontsize',fs,'XLim',handles.lim);
    xlabel(handles.rcx,'time (s)');
    if(isnumeric(handles.limscale))
        set(handles.rcx,'YLim',handles.limscale)
    end
end

function currentploty(handles)
% change the display of the 2d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 08/07/10

fs=8;% fontsize for plotting

if (~isempty(handles.currentdatay))
    
    plot(handles.tdy,handles.t,handles.currentdatay(:,1),handles.rucby(3));
    set(handles.tdy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdy,'YLim',handles.limscale)
    end
    
    plot(handles.tby,handles.t,handles.currentdatay(:,2),handles.rucby(3));
    set(handles.tby,'XTick',[],'fontsize',fs,'XLim',handles.lim...
        ,'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tby,'YLim',handles.limscale)
    end
    
    plot(handles.tty,handles.t,handles.currentdatay(:,3),handles.rucby(3));
    set(handles.tty,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tty,'YLim',handles.limscale)
    end
    
    plot(handles.noy,handles.t,handles.currentdatay(:,5),handles.rucby(2));
    set(handles.noy,'XTick',[],'fontsize',fs,'XLim',handles.lim...
        ,'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.noy,'YLim',handles.limscale)
    end
    
    plot(handles.uly,handles.t,handles.currentdatay(:,6),handles.rucby(2));
    set(handles.uly,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.uly,'YLim',handles.limscale)
    end
    
    plot(handles.lly,handles.t,handles.currentdatay(:,7),handles.rucby(3));
    set(handles.lly,'XTick',[],'fontsize',fs,'XLim',handles.lim...
        ,'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lly,'YLim',handles.limscale)
    end
    
    plot(handles.jay,handles.t,handles.currentdatay(:,8),handles.rucby(2));
    set(handles.jay,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jay,'YLim',handles.limscale)
    end
    
    plot(handles.lcy,handles.t,handles.currentdatay(:,9),handles.rucby(2));
    set(handles.lcy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcy,'YLim',handles.limscale)
    end
   plot(handles.rcy,handles.t,handles.currentdatay(:,10),handles.rucby(2));
    set(handles.rcy,'fontsize',fs,'XLim',handles.lim);
    xlabel(handles.rcy,'time (s)');
    if(isnumeric(handles.limscale))
        set(handles.rcy,'YLim',handles.limscale)
    end
else
    
    plot(handles.tdy,handles.t,handles.y2d(:,1),'b',...
                     handles.t,handles.y2dc(:,1),'g');
    set(handles.tdy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdy,'YLim',handles.limscale)
    end
    
    plot(handles.tby,handles.t,handles.y2d(:,2),'b',...
                     handles.t,handles.y2dc(:,2),'g');
    set(handles.tby,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tby,'YLim',handles.limscale)
    end
    
    plot(handles.tty,handles.t,handles.y2d(:,3),'b',...
                     handles.t,handles.y2dc(:,3),'g');
    set(handles.tty,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tty,'YLim',handles.limscale)
    end
    
    plot(handles.noy,handles.t,handles.y2d(:,5),'b');
    set(handles.noy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.noy,'YLim',handles.limscale)
    end
    
    plot(handles.uly,handles.t,handles.y2d(:,6),'b');
    set(handles.uly,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.uly,'YLim',handles.limscale)
    end
    
    plot(handles.lly,handles.t,handles.y2d(:,7),'b',...
                     handles.t,handles.y2dc(:,7),'g');
    set(handles.lly,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lly,'YLim',handles.limscale)
    end
    
    plot(handles.jay,handles.t,handles.y2d(:,8),'b');
    set(handles.jay,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jay,'YLim',handles.limscale)
    end
    
    plot(handles.lcy,handles.t,handles.y2d(:,9),'b');
    set(handles.lcy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcy,'YLim',handles.limscale)
    end
    
    plot(handles.rcy,handles.t,handles.y2d(:,10),'b');
    set(handles.rcy,'fontsize',fs,'XLim',handles.lim);
    xlabel(handles.rcy,'time (s)');
    if(isnumeric(handles.limscale))
        set(handles.rcy,'YLim',handles.limscale)
    end
    
end

function pushbuttonxonX_rh(handles)

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 08/07/10

if(~isempty(handles.currentdatax))
    on_off='on';
else
    on_off='off';
end

set(handles.btdx,'enable',on_off);
set(handles.btbx,'enable',on_off);
set(handles.bttx,'enable',on_off);
set(handles.bnx,'enable',on_off);
set(handles.bulx,'enable',on_off);
set(handles.bllx,'enable',on_off);
set(handles.bjx,'enable',on_off);
set(handles.blcx,'enable',on_off);
set(handles.brcx,'enable',on_off);

set(handles.maximizetdx,'enable',on_off);
set(handles.maximizetbx,'enable',on_off);
set(handles.maximizettx,'enable',on_off);
set(handles.maximizenox,'enable',on_off);
set(handles.maximizeulx,'enable',on_off);
set(handles.maximizellx,'enable',on_off);
set(handles.maximizejax,'enable',on_off);
set(handles.maximizelcx,'enable',on_off);
set(handles.maximizercx,'enable',on_off);

set(handles.arttdx,'enable',on_off);
set(handles.arttbx,'enable',on_off);
set(handles.artttx,'enable',on_off);
set(handles.artnox,'enable',on_off);
set(handles.artulx,'enable',on_off);
set(handles.artllx,'enable',on_off);
set(handles.artjax,'enable',on_off);
set(handles.artlcx,'enable',on_off);
set(handles.artrcx,'enable',on_off);

function pushbuttonxonY_rh(handles)

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 08/07/10

if (~isempty(handles.currentdatay))
    on_off='on';
else
    on_off='off';
end

set(handles.btdy,'enable',on_off);
set(handles.btby,'enable',on_off);
set(handles.btty,'enable',on_off);
set(handles.bny,'enable',on_off);
set(handles.buly,'enable',on_off);
set(handles.blly,'enable',on_off);
set(handles.bjy,'enable',on_off);
set(handles.blcy,'enable',on_off);
set(handles.brcy,'enable',on_off);

set(handles.maximizetdy,'enable',on_off);
set(handles.maximizetby,'enable',on_off);
set(handles.maximizetty,'enable',on_off);
set(handles.maximizenoy,'enable',on_off);
set(handles.maximizeuly,'enable',on_off);
set(handles.maximizelly,'enable',on_off);
set(handles.maximizejay,'enable',on_off);
set(handles.maximizelcy,'enable',on_off);
set(handles.maximizercy,'enable',on_off);

set(handles.arttdy,'enable',on_off);
set(handles.arttby,'enable',on_off);
set(handles.arttty,'enable',on_off);
set(handles.artnoy,'enable',on_off);
set(handles.artuly,'enable',on_off);
set(handles.artlly,'enable',on_off);
set(handles.artjay,'enable',on_off);
set(handles.artlcy,'enable',on_off);
set(handles.artrcy,'enable',on_off);

%% Modify Display Settings

function int_selec_display_Callback(hObject, eventdata, handles)
% hObject    handle to int_selec_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of int_selec_display as text
%        str2double(get(hObject,'String')) returns contents of int_selec_display as a double

t = eval(['[' get(handles.int_selec_display,'String') ']']);

% Disable the refresh Plot button and change its string if was not inserted 
% 2 real numbers, or if they are not ascending
if(size(t,1)~= 1 || size(t,2)~=2)
    set(handles.warningtext, ...
        'String','Cannot plot! Insert 2 real numbers!','ForegroundColor','r')
    set(handles.scale_display,'Enable','off')
elseif(isnan(t(1)) || ~isreal(t(1)) || isnan(t(2)) || ~isreal(t(2)) )
    set(handles.warningtext, ...
        'String','Cannot plot! Insert real numbers!','ForegroundColor','r')
    set(handles.scale_display,'Enable','off')
elseif(t(1)>t(2))
    set(handles.warningtext, ...
        'String','Cannot plot! Insert in chronological order!','ForegroundColor','r')
    set(handles.scale_display,'Enable','off')
else 
    % Enable the Plot button with its original name
    handles.lim = t;
    set(handles.warningtext,'String','Warning message','ForegroundColor','black')
    set(handles.scale_display,'Enable','on')
    
    openall(handles)
 
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function int_selec_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to int_selec_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function scale_display_Callback(hObject, eventdata, handles)
% hObject    handle to scale_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_display as text
%        str2double(get(hObject,'String')) returns contents of scale_display as a double

amp = eval(['[' get(handles.scale_display,'String') ']']);

% Disable the refresh Plot button and change its string if was not inserted 
% 2 real numbers, or if they are not ascending. The only string that is 
% accepted is 'auto' for a automatic ajust.
if (strcmp(amp,'auto'))
    handles.limscale = amp;
    set(handles.warningtext,'String','Warning message','ForegroundColor','black')
    set(handles.int_selec_display,'Enable','on')
elseif(size(amp,1)~= 1 || size(amp,2)~=2)
    set(handles.warningtext, 'String',...
       ['Cannot plot! Insert 2 real numbers or type ' char(39) 'auto' char(39)],'ForegroundColor','r')
    set(handles.int_selec_display,'Enable','off')
elseif(isnan(amp(1)) || ~isreal(amp(1)) ||isnan(amp(2)) || ~isreal(amp(2)))
    set(handles.warningtext,'String',...
      ['Cannot plot! Insert real numbers or type ' char(39) 'auto' char(39)],'ForegroundColor','r')
    set(handles.int_selec_display,'Enable','off')
elseif(amp(1)>amp(2))
    set(handles.warningtext, 'String',...
      ['Cannot plot! Insert in chronological order or type ' char(39) 'auto' char(39)],'ForegroundColor','r')
    set(handles.int_selec_display,'Enable','off')
else 
    % Enable the Plot button with its original name
    handles.limscale = amp;
    set(handles.warningtext,'String','Warning message','ForegroundColor','black')
    set(handles.int_selec_display,'Enable','on')
 
end

openall(handles)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function scale_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% RESET push button

% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% reset current data
handles.currentdatax=handles.x2d;
handles.currentdatay=handles.y2d;
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale='auto';
handles.rucbx='ubb';
handles.rucby='ubb';

% clear signals to analyze
handles.sig1 = [];
handles.sig2 = [];
handles.sig3 = [];
handles.sig4 = [];

set(handles.sig_ana_1,'string','');
set(handles.sig_ana_2,'string','');
set(handles.sig_ana_3,'string','');
set(handles.sig_ana_4,'string','');

openall(handles)
pushbuttonxonX_rh(handles)
pushbuttonxonY_rh(handles)
set(handles.int_selec_display, 'String',['0 ' num2str(handles.lim(2))],...
    'enable','on')
set(handles.scale_display, 'String',[char(39) 'auto' char(39)])
set(handles.warningtext, 'String','Warning message','ForegroundColor','black')
% Update handles structure
guidata(hObject, handles);


%% maximize button
% --- Executes on button press in maximizetdx.
function maximizetdx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,1);
maximazedfigure2(hObject, eventdata, handles, cdata, signame);

% --- Executes on button press in maximizetbx.
function maximizetbx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettx.
function maximizettx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenox.
function maximizenox_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeulx.
function maximizeulx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeulx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,6);
maximazedfigure2(hObject, eventdata, handles, cdata,signame);

% --- Executes on button press in maximizellx.
function maximizellx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejax.
function maximizejax_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcx.
function maximizelcx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref1 x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercx.
function maximizercx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref2 x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);




% --- Executes on button press in maximizetdy.
function maximizetdy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td y ' handles.rucby(1)];
cdata=handles.currentdatay(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in maximizetby.
function maximizetby_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb y ' handles.rucby(1)];
cdata=handles.currentdatay(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetty.
function maximizetty_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt y ' handles.rucby(1)];
cdata=handles.currentdatay(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenoy.
function maximizenoy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenoy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose y ' handles.rucby(1)];
cdata=handles.currentdatay(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeuly.
function maximizeuly_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeuly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul y ' handles.rucby(1)];
cdata=handles.currentdatay(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelly.
function maximizelly_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll y ' handles.rucby(1)];
cdata=handles.currentdatay(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejay.
function maximizejay_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw y ' handles.rucby(1)];
cdata=handles.currentdatay(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcy.
function maximizelcy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref1 y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercy.
function maximizercy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref2 y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizebc.
function maximizebc_Callback(hObject, eventdata, handles)
% hObject    handle to maximizebc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='BC';
cdata=handles.bc;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetb.
function maximizetb_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='TB';
cdata=handles.tb;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizett.
function maximizett_Callback(hObject, eventdata, handles)
% hObject    handle to maximizett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='TT';
cdata=handles.tt;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetd.
function maximizetd_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

signame='TD';
cdata=handles.td;
maximazedfigure2(hObject, eventdata, handles, cdata, signame);



function maximazedfigure2(hObject, eventdata, handles,cdata,signame)
% ODL Rafael Henriques 14/07/10 
% last update 17/07/10

b=0;
resp=questdlg('Plot in which figure ?','Select figure',...
     ['fig' num2str(handles.fig)],'new','restart',...
     ['fig' num2str(handles.fig)]);

if strcmp(resp,'new')
    handles.fig=handles.fig+2;
    handles.sigmax1=[];
    handles.sigmax2=[];
    handles.sigmax3=[];
    handles.sigmax4=[];
    
elseif strcmp(resp,'restart')
    for i=2:2:handles.fig
        if ishandle(i),close(i), end
    end
    handles.fig=2;
    handles.sigmax1=[];
    handles.sigmax2=[];
    handles.sigmax3=[];
    handles.sigmax4=[];
end
   
if isempty(handles.sigmax1)
    handles.sigmax1=cdata;
    handles.signame1=signame;
    a=1;
elseif isempty(handles.sigmax2)
    handles.sigmax2=cdata;
    handles.signame2=signame;
    a=2;
elseif isempty(handles.sigmax3)
    handles.sigmax3=cdata;
    handles.signame3=signame;
    a=3;
elseif isempty(handles.sigmax4)
    handles.sigmax4=cdata;
    handles.signame4=signame;
    a=4;
else
    b=1;
    a=4;
end
    
if ishandle(handles.fig),close(handles.fig), end

hfig=figure(handles.fig);
set(hfig,'color',[1 1 1]);

ax=axes;
hold on
m=[1 0.9 0; 0 0 1; 0 0.5 0; 1 0 0; 0 0 0]; 

    set(ax,'colororder',m)
if(a==1)
    %set(ax,'colororder',m)
    plot(ax,(1:length(handles.ac))/16000,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1);
    legend('acoustic',handles.signame1,1)
elseif(a==2)
    plot(ax,(1:length(handles.ac))/16000,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1,handles.t,handles.sigmax2);
    legend('acoustic',handles.signame1,handles.signame2,1)
elseif(a==3)
    plot(ax,(1:length(handles.ac))/16000,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1,handles.t,handles.sigmax2,...
    handles.t,handles.sigmax3);
    legend('acoustic',handles.signame1,handles.signame2,handles.signame3,1)
elseif(a==4)
    plot(ax,(1:length(handles.ac))/16000,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1,handles.t,handles.sigmax2,...
    handles.t,handles.sigmax3,handles.t,handles.sigmax4);
    legend('acoustic',handles.signame1,handles.signame2,...
        handles.signame3,handles.signame4,1)
end
set(gca,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(gca,'YLim',handles.limscale)
end
xlabel('time (s)')
ylabel('mm')
set(ax,'color',[0.95 0.95 0.95]);
%set(hplot,'LineWidth',1.5) %hplot is output of plot

if b==1
msgbox(['figure ' num2str(handles.fig) ' is full! Select "new" or "restart" instead!']...
            ,'EMA warnning','warn')
end

hold off

guidata(hObject, handles);



%% subplot button 
% --- Executes on button press in arttdx.
function arttdx_Callback(hObject, eventdata, handles)
% hObject    handle to arttdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttbx.
function arttbx_Callback(hObject, eventdata, handles)
% hObject    handle to arttbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artttx.
function artttx_Callback(hObject, eventdata, handles)
% hObject    handle to artttx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnox.
function artnox_Callback(hObject, eventdata, handles)
% hObject    handle to artnox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artulx.
function artulx_Callback(hObject, eventdata, handles)
% hObject    handle to artulx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artllx.
function artllx_Callback(hObject, eventdata, handles)
% hObject    handle to artllx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjax.
function artjax_Callback(hObject, eventdata, handles)
% hObject    handle to artjax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcx.
function artlcx_Callback(hObject, eventdata, handles)
% hObject    handle to artlcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref1 x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcx.
function artrcx_Callback(hObject, eventdata, handles)
% hObject    handle to artrcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref2 x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttdy.
function arttdy_Callback(hObject, eventdata, handles)
% hObject    handle to arttdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td y ' handles.rucby(1)];
cdata=handles.currentdatay(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttby.
function arttby_Callback(hObject, eventdata, handles)
% hObject    handle to arttby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb y ' handles.rucby(1)];
cdata=handles.currentdatay(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttty.
function arttty_Callback(hObject, eventdata, handles)
% hObject    handle to arttty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt y ' handles.rucby(1)];
cdata=handles.currentdatay(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnoy.
function artnoy_Callback(hObject, eventdata, handles)
% hObject    handle to artnoy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose y ' handles.rucby(1)];
cdata=handles.currentdatay(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artuly.
function artuly_Callback(hObject, eventdata, handles)
% hObject    handle to artuly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul y ' handles.rucby(1)];
cdata=handles.currentdatay(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlly.
function artlly_Callback(hObject, eventdata, handles)
% hObject    handle to artlly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll y ' handles.rucby(1)];
cdata=handles.currentdatay(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjay.
function artjay_Callback(hObject, eventdata, handles)
% hObject    handle to artjay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw y ' handles.rucby(1)];
cdata=handles.currentdatay(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcy.
function artlcy_Callback(hObject, eventdata, handles)
% hObject    handle to artlcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref1 y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcy.
function artrcy_Callback(hObject, eventdata, handles)
% hObject    handle to artrcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ref2 y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artbc.
function artbc_Callback(hObject, eventdata, handles)
% hObject    handle to artbc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='BC';
cdata=handles.bc;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttb.
function arttb_Callback(hObject, eventdata, handles)
% hObject    handle to arttb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='TB';
cdata=handles.tb;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttt.
function arttt_Callback(hObject, eventdata, handles)
% hObject    handle to arttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='TT';
cdata=handles.tt;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttd.
function arttd_Callback(hObject, eventdata, handles)
% hObject    handle to arttd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame='TD';
cdata=handles.td;
subplotfigure(hObject, eventdata, handles,cdata,signame);

function subplotfigure(hObject, eventdata, handles,cdata,signame)
% ODL 15/07/10

b=0;
resp=questdlg('Plot in which figure ?','Select figure',...
     ['fig' num2str(handles.figsub)],'new','restart',...
     ['fig' num2str(handles.figsub)]);

if strcmp(resp,'new')
    handles.figsub=handles.figsub+2;
    handles.sigsub1=[];
    handles.sigsub2=[];
    handles.sigsub3=[];
    handles.sigsub4=[];
elseif strcmp(resp,'restart')
    for i=1:2:handles.figsub
        if ishandle(i),close(i), end
    end
    handles.figsub=1;
    handles.sigsub1=[];
    handles.sigsub2=[];
    handles.sigsub3=[];
    handles.sigsub4=[];
end
   
if isempty(handles.sigsub1)
    handles.sigsub1=cdata;
    handles.signame1=signame;
    a=1;
elseif isempty(handles.sigsub2)
    handles.sigsub2=cdata;
    handles.signame2=signame;
    a=2;
elseif isempty(handles.sigsub3)
    handles.sigsub3=cdata;
    handles.signame3=signame;
    a=3;
elseif isempty(handles.sigsub4)
    handles.sigsub4=cdata;
    handles.signame4=signame;
    a=4;
else
    b=1;
    a=4;
end

figure(handles.figsub)
subplot(a+1,1,1), plot((1:length(handles.ac))/16000,handles.ac)
set(gca,'YTick',[],'XLim',handles.lim);
title('acoustic')

if(a==1)
    subplot(2,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==2)
    subplot(3,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(3,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==3)
    subplot(4,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==4)
    subplot(5,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,5),plot(handles.t,handles.sigsub4)
    title(handles.signame4), ylabel('mm')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
end

if b==1
msgbox(['Figure ' num2str(handles.figsub) ...
    ' is full! Select "new" or "restart" instead!'] ,'EMA warning','warn')
end
guidata(hObject, handles);

%% Code of the last version that I think that is doing nothing
%I will remove this in final version 

% --- Executes on button press in rel_phase.
function rel_phase_Callback(hObject, eventdata, handles)
% hObject    handle to rel_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_hurst(handles.sig1,handles.sig2,'TT','TB','BC','TD');
% --- Executes on button press in warningtext.
function pushbuttonRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to warningtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

openall(handles)
