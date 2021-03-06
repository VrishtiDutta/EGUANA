function varargout = gui_emma3d_jawhead_rh(varargin)
% GUI_EMMA3D_JAWHEAD_RH M-file for gui_emma3d_jawhead_rh.fig
%      GUI_EMMA3D_JAWHEAD_RH, by itself, creates a new GUI_EMMA3D_JAWHEAD_RH or raises the existing
%      singleton*.
%
%      H = GUI_EMMA3D_JAWHEAD_RH returns the handle to a new GUI_EMMA3D_JAWHEAD_RH or the handle to
%      the existing singleton*.
%
%      GUI_EMMA3D_JAWHEAD_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EMMA3D_JAWHEAD_RH.M with the given input arguments.
%
%      GUI_EMMA3D_JAWHEAD_RH('Property','Value',...) creates a new GUI_EMMA3D_JAWHEAD_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_3d_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_emma3d_jawhead_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_emma3d_jawhead_rh

% Last Modified by GUIDE v2.5 28-Dec-2010 14:18:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_emma3d_jawhead_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_emma3d_jawhead_rh_OutputFcn, ...
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


% --- Executes just before gui_emma3d_jawhead_rh is made visible.
function gui_emma3d_jawhead_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_emma3d_jawhead_rh (see VARARGIN)


%set(gcf, 'Units' , 'normalized');
%set(gcf, 'Position', [0, 0, 1, 1]);

%x3d_raw,y3d_raw,z3d_raw,x3d_lp,y3d_lp,z3d_lp,...
 %      x3dpos,y3dpos,z3dpos,phi_lp,theta_lp,phipos,thetapos,posOK,path1)

data3d = varargin{1};
handles.x3d_raw = data3d.x3d_raw; %raw data for rawpos folder without any correction
handles.y3d_raw = data3d.y3d_raw;
handles.z3d_raw = data3d.z3d_raw;
handles.x3d_lp = data3d.x3d_lp; %data for rawpos folder low pass filtered
handles.y3d_lp = data3d.y3d_lp;
handles.z3d_lp = data3d.z3d_lp;
handles.x3dc = data3d.x3d_lp; % no correction in begining
handles.y3dc = data3d.y3d_lp;
handles.z3dc = data3d.z3d_lp;
handles.currentdatax=data3d.x3d_lp; % correct dada open lp button
handles.currentdatay=data3d.y3d_lp;
handles.currentdataz=data3d.z3d_lp;
handles.x3dhead=data3d.x3d_lp;
handles.y3dhead=data3d.y3d_lp;
handles.z3dhead=data3d.z3d_lp;
handles.x3dpos=data3d.x3dpos;
handles.y3dpos=data3d.y3dpos;
handles.z3dpos=data3d.z3dpos;

handles.ac = data3d.ac3d;
handles.path1=data3d.path1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.t=(1:1:(size(data3d.x3d_raw,1)))/200; %note sampling freq is 200Hz
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale=[char(39) 'auto' char(39)];
handles.cinfohead='Aplied to HC2';
handles.posOK=data3d.posOK;

handles.tri = data3d.tri3d;
handles.sub = data3d.sub3d;


siz=size(handles.x3dc);

for i=1:siz(2)
   handles.x3dc(:,i)=handles.x3dhead(:,i)-handles.x3dhead(:,8);
   handles.y3dc(:,i)=handles.y3dhead(:,i)-handles.y3dhead(:,8);  
   handles.z3dc(:,i)=handles.z3dhead(:,i)-handles.z3dhead(:,8); 
end

handles.thetajaw = zeros(siz);
handles.phijaw   = zeros(siz);

handles.rucbx='lmm';
handles.rucby='lmm';
handles.rucbz='lmm';
handles.rucbp='lmm';
handles.rucbt='lmm';
handles.figsub=1;
handles.fig=2;

handles.phi_raw=data3d.phi_raw;
handles.theta_raw=data3d.theta_raw;
handles.phi_lp=data3d.phi_lp;
handles.theta_lp=data3d.theta_lp;
handles.phihead=data3d.phi_lp;
handles.thetahead=data3d.theta_lp;
handles.phipos=data3d.phipos;  
handles.thetapos=data3d.thetapos;

handles.currentdatap=data3d.phi_lp;
handles.currentdatat=data3d.theta_lp;

openall(handles)

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


% Choose default command line output for gui_emma3d_jawhead_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_emma3d_jawhead_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_emma3d_jawhead_rh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function openall(handles)
% open or refresh all GUI plots

fs = 8; % fontsize for plotting

%note sampling freq of accoustict is 16000 Hz 
plot(handles.ac_axes1,(1:length(handles.ac))/16000,handles.ac);
set(handles.ac_axes1,'YTick',[],'XLim',handles.lim,'fontsize',fs);

%positions
currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)


% --- Executes on button press in play_ac.
function play_ac_Callback(hObject, eventdata, handles)
% hObject    handle to play_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

handles.currentdatax=handles.x3d_raw;
handles.rucbx='rrr';

currentplotx(handles)

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_lp_filterx.
function pushbutton_lp_filterx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lp_filterx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x3d_lp;
handles.rucbx='lmm';

currentplotx(handles)

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton_rawy.
function pushbutton_rawy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y3d_raw;
handles.rucby='rrr';


currentploty(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_lp_filterx.
function pushbutton_lp_filtery_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lp_filtery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y3d_lp;
handles.rucby='lmm';

currentploty(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_rawz.
function pushbutton_rawz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdataz=handles.z3d_raw;
handles.rucbz='rrr';


currentplotz(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_lp_filterx.
function pushbutton_lp_filterz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lp_filterz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdataz=handles.z3d_lp;
handles.rucbz='lmm';

currentplotz(handles)

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_rawp.
function pushbutton_rawp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatap=handles.phi_raw;
handles.rucbp='rrr';

currentplotphi(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_lp_filtert.
function pushbutton_lp_filterp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lp_filterp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatap=handles.phi_lp;
handles.rucbp='lmm';

currentplotphi(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_rawp.
function pushbutton_rawt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatat=handles.theta_raw;
handles.rucbt='rrr';

currentplottheta(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_lp_filtert.
function pushbutton_lp_filtert_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lp_filtert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatat=handles.theta_lp;
handles.rucbt='lmm';

currentplottheta(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in jawX.
function jawX_Callback(hObject, eventdata, handles)
% hObject    handle to jawX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x3dc;
handles.rucbx='cgg';

currentplotx(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in jawY.
function jawY_Callback(hObject, eventdata, handles)
% hObject    handle to jawY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatay=handles.y3dc;
handles.rucby='cgg';

currentploty(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in jawZ.
function jawZ_Callback(hObject, eventdata, handles)
% hObject    handle to jawZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdataz=handles.z3dc;
handles.rucbz='cgg';

currentplotz(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in jawP.
function jawP_Callback(hObject, eventdata, handles)
% hObject    handle to jawP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatap=handles.phijaw;
handles.rucbp='cgg';

currentplotphi(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in JawT.
function JawT_Callback(hObject, eventdata, handles)
% hObject    handle to JawT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatat=handles.thetajaw;
handles.rucbt='cgg';

currentplottheta(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in headX.
function headX_Callback(hObject, eventdata, handles)
% hObject    handle to headX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatax=handles.x3dhead;
handles.rucbx='hbb';

currentplotx(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in headY.
function headY_Callback(hObject, eventdata, handles)
% hObject    handle to headY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatay=handles.y3dhead;
handles.rucby='hbb';

currentploty(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in headZ.
function headZ_Callback(hObject, eventdata, handles)
% hObject    handle to headZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdataz=handles.z3dhead;
handles.rucbz='hbb';

currentplotz(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in HeadP.
function HeadP_Callback(hObject, eventdata, handles)
% hObject    handle to HeadP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatap=handles.phihead;
handles.rucbp='hbb';
currentplotphi(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in HeadT.
function HeadT_Callback(hObject, eventdata, handles)
% hObject    handle to HeadT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatat=handles.thetahead;
handles.rucbt='hbb';
currentplottheta(handles)
    
% Update handles structure
guidata(hObject, handles);


function currentplotx(handles)
% change the display of the 3d channel X positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 08/08/10 

fs=8;% fontsize for plotting

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

plot(handles.hex,handles.t,handles.currentdatax(:,4),handles.rucbx(2));
set(handles.hex,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
    'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.hex,'YLim',handles.limscale)
end


plot(handles.nox,handles.t,handles.currentdatax(:,5),handles.rucbx(2));
set(handles.nox,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.nox,'YLim',handles.limscale)
end

plot(handles.ulx,handles.t,handles.currentdatax(:,6),handles.rucbx(2));
set(handles.ulx,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
    'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.ulx,'YLim',handles.limscale)
end

plot(handles.llx,handles.t,handles.currentdatax(:,7),handles.rucbx(3));
set(handles.llx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.llx,'YLim',handles.limscale)
end

plot(handles.jax,handles.t,handles.currentdatax(:,8),handles.rucbx(2));
set(handles.jax,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
    'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.jax,'YLim',handles.limscale)
end

plot(handles.lcx,handles.t,handles.currentdatax(:,9),handles.rucbx(2));
set(handles.lcx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lcx,'YLim',handles.limscale)
end

plot(handles.rcx,handles.t,handles.currentdatax(:,10),handles.rucbx(2));
set(handles.rcx,'XTick',[],'fontsize',fs,'XLim',handles.lim, ...
    'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.rcx,'YLim',handles.limscale)
end

plot(handles.lex,handles.t,handles.currentdatax(:,11),handles.rucbx(2));
set(handles.lex,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lex,'YLim',handles.limscale)
end

plot(handles.rex,handles.t,handles.currentdatax(:,12),handles.rucbx(2));
set(handles.rex,'fontsize',fs,'XLim',handles.lim, ...
    'yaxislocation','right');
xlabel(handles.rex,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.rex,'YLim',handles.limscale)
end

function currentploty(handles)
% change the display of the 3d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 15/07/10

fs=8;% fontsize for plotting


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

plot(handles.hey,handles.t,handles.currentdatay(:,4),handles.rucby(2));
set(handles.hey,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.hey,'YLim',handles.limscale)
end

plot(handles.noy,handles.t,handles.currentdatay(:,5),handles.rucby(2));
set(handles.noy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.noy,'YLim',handles.limscale)
end

plot(handles.uly,handles.t,handles.currentdatay(:,6),handles.rucby(2));
set(handles.uly,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.uly,'YLim',handles.limscale)
end

plot(handles.lly,handles.t,handles.currentdatay(:,7),handles.rucby(3));
set(handles.lly,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lly,'YLim',handles.limscale)
end

plot(handles.jay,handles.t,handles.currentdatay(:,8),handles.rucby(2));
set(handles.jay,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.jay,'YLim',handles.limscale)
end

plot(handles.lcy,handles.t,handles.currentdatay(:,9),handles.rucby(2));
set(handles.lcy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lcy,'YLim',handles.limscale)
end

plot(handles.rcy,handles.t,handles.currentdatay(:,10),handles.rucby(2));
set(handles.rcy,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.rcy,'YLim',handles.limscale)
end

plot(handles.ley,handles.t,handles.currentdatay(:,11),handles.rucby(2));
set(handles.ley,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.ley,'YLim',handles.limscale)
end

plot(handles.rey,handles.t,handles.currentdatay(:,12),handles.rucby(2));
set(handles.rey,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
xlabel(handles.rey,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.rey,'YLim',handles.limscale)
end

function currentplotz(handles)
% change the display of the 3d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 8/08/10

fs=8;% fontsize for plotting

plot(handles.tdz,handles.t,handles.currentdataz(:,1),handles.rucbz(3));
set(handles.tdz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tdz,'YLim',handles.limscale)
end

plot(handles.tbz,handles.t,handles.currentdataz(:,2),handles.rucbz(3));
set(handles.tbz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.tbz,'YLim',handles.limscale)
end

plot(handles.ttz,handles.t,handles.currentdataz(:,3),handles.rucbz(3));
set(handles.ttz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tty,'YLim',handles.limscale)
end


plot(handles.hez,handles.t,handles.currentdataz(:,4),handles.rucbz(2));
set(handles.hez,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.hez,'YLim',handles.limscale)
end

plot(handles.noz,handles.t,handles.currentdataz(:,5),handles.rucbz(2));
set(handles.noz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.noz,'YLim',handles.limscale)
end

plot(handles.ulz,handles.t,handles.currentdataz(:,6),handles.rucbz(2));
set(handles.ulz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.ulz,'YLim',handles.limscale)
end

plot(handles.llz,handles.t,handles.currentdataz(:,7),handles.rucbz(3));
set(handles.llz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.llz,'YLim',handles.limscale)
end

plot(handles.jaz,handles.t,handles.currentdataz(:,8),handles.rucbz(2));
set(handles.jaz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.jaz,'YLim',handles.limscale)
end

plot(handles.lcz,handles.t,handles.currentdataz(:,9),handles.rucbz(2));
set(handles.lcz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lcz,'YLim',handles.limscale)
end

plot(handles.rcz,handles.t,handles.currentdataz(:,10),handles.rucbz(2));
set(handles.rcz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.rcz,'YLim',handles.limscale)
end

plot(handles.lez,handles.t,handles.currentdataz(:,11),handles.rucbz(2));
set(handles.lez,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lez,'YLim',handles.limscale)
end

plot(handles.rez,handles.t,handles.currentdataz(:,12),handles.rucbz(2));
set(handles.rez,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
xlabel(handles.rez,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.rez,'YLim',handles.limscale)
end


function currentplotphi(handles)
% change the display of the 3d channel phi positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 8/08/10

fs=8;% fontsize for plotting
   
plot(handles.tdp,handles.t,handles.currentdatap(:,1),handles.rucbp(3));
set(handles.tdp,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tdp,'YLim',handles.limscale)
end

plot(handles.tbp,handles.t,handles.currentdatap(:,2),handles.rucbp(3));
set(handles.tbp,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.tbp,'YLim',handles.limscale)
end

plot(handles.ttp,handles.t,handles.currentdatap(:,3),handles.rucbp(3));
set(handles.ttp,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tty,'YLim',handles.limscale)
end


plot(handles.hep,handles.t,handles.currentdatap(:,4),handles.rucbp(2));
set(handles.hep,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.hep,'YLim',handles.limscale)
end

plot(handles.nop,handles.t,handles.currentdatap(:,5),handles.rucbp(2));
set(handles.nop,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.nop,'YLim',handles.limscale)
end

plot(handles.ulp,handles.t,handles.currentdatap(:,6),handles.rucbp(2));
set(handles.ulp,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.ulp,'YLim',handles.limscale)
end

plot(handles.llp,handles.t,handles.currentdatap(:,7),handles.rucbp(3));
set(handles.llp,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.llp,'YLim',handles.limscale)
end

plot(handles.jap,handles.t,handles.currentdatap(:,8),handles.rucbp(2));
set(handles.jap,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.jap,'YLim',handles.limscale)
end

plot(handles.lcp,handles.t,handles.currentdatap(:,9),handles.rucbp(2));
set(handles.lcp,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lcp,'YLim',handles.limscale)
end

plot(handles.rcp,handles.t,handles.currentdatap(:,10),handles.rucbp(2));
set(handles.rcp,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.rcp,'YLim',handles.limscale)
end

plot(handles.lep,handles.t,handles.currentdatap(:,11),handles.rucbp(2));
set(handles.lep,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lep,'YLim',handles.limscale)
end

plot(handles.rep,handles.t,handles.currentdatap(:,12),handles.rucbp(2));
set(handles.rep,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
xlabel(handles.rep,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.rep,'YLim',handles.limscale)
end
    

function currentplottheta(handles)
% change the display of the 3d channel Theta positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 8/08/10

fs=8;% fontsize for plotting

plot(handles.tdt,handles.t,handles.currentdatat(:,1),handles.rucbt(3));
set(handles.tdt,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tdt,'YLim',handles.limscale)
end

plot(handles.tbt,handles.t,handles.currentdatat(:,2),handles.rucbt(3));
set(handles.tbt,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.tbt,'YLim',handles.limscale)
end

plot(handles.ttt,handles.t,handles.currentdatat(:,3),handles.rucbt(3));
set(handles.ttt,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.tty,'YLim',handles.limscale)
end


plot(handles.het,handles.t,handles.currentdatat(:,4),handles.rucbt(2));
set(handles.het,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.het,'YLim',handles.limscale)
end

plot(handles.not,handles.t,handles.currentdatat(:,5),handles.rucbt(2));
set(handles.not,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.not,'YLim',handles.limscale)
end

plot(handles.ult,handles.t,handles.currentdatat(:,6),handles.rucbt(2));
set(handles.ult,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.ult,'YLim',handles.limscale)
end

plot(handles.llt,handles.t,handles.currentdatat(:,7),handles.rucbt(3));
set(handles.llt,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.llt,'YLim',handles.limscale)
end

plot(handles.jat,handles.t,handles.currentdatat(:,8),handles.rucbt(2));
set(handles.jat,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.jat,'YLim',handles.limscale)
end

plot(handles.lct,handles.t,handles.currentdatat(:,9),handles.rucbt(2));
set(handles.lct,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.lct,'YLim',handles.limscale)
end

plot(handles.rct,handles.t,handles.currentdatat(:,10),handles.rucbt(2));
set(handles.rct,'XTick',[],'fontsize',fs,'XLim',handles.lim...
    ,'yaxislocation','right');
if(isnumeric(handles.limscale))
    set(handles.rct,'YLim',handles.limscale)
end

plot(handles.let,handles.t,handles.currentdatat(:,11),handles.rucbt(2));
set(handles.let,'XTick',[],'fontsize',fs,'XLim',handles.lim);
if(isnumeric(handles.limscale))
    set(handles.let,'YLim',handles.limscale)
end

plot(handles.ret,handles.t,handles.currentdatat(:,12),handles.rucbt(2));
set(handles.ret,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
xlabel(handles.ret,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.ret,'YLim',handles.limscale)
end
    

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
handles.currentdatax=handles.x3d_lp;
handles.currentdatay=handles.y3d_lp;
handles.currentdataz=handles.z3d_lp;
handles.currentdatap=handles.phi_lp;
handles.currentdatat=handles.theta_lp;
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale='auto';
handles.rucbx='lmm';
handles.rucby='lmm';
handles.rucbz='lmm';
handles.rucbp='lmm';
handles.rucbt='lmm';
handles.cinfohead='Aplied to HC2';
handles.x3dhead=handles.x3dpos;
handles.y3dhead=handles.y3dpos;
handles.z3dhead=handles.z3dpos;
handles.phihead=handles.phipos;
handles.thetahead=handles.thetapos;

set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'Pos Folder' char(39)]);
set(handles.currentjawmethod,'string',...
    ['Current Method ' char(39) 'Simple Subtraction' char(39)]);
set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'Pos Folder' char(39)]);
set(handles.headinfotojaw,'string','Aplied to HC2')

openall(handles)



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

% --- Executes on button press in maximizenx.
function maximizehex_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,4);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenx.
function maximizenx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenx (see GCBO)
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
signame=['rc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercx.
function maximizercx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeex.
function maximizeex_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeex.
function maximizerex_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,12);
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

% --- Executes on button press in maximizetty.
function maximizehey_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head y ' handles.rucby(1)];
cdata=handles.currentdatay(:,4);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeny.
function maximizeny_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeny (see GCBO)
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
signame=['lc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercy.
function maximizercy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeey.
function maximizeey_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le y ' handles.rucby(1)];
cdata=handles.currentdatay(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeey.
function maximizerey_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re y ' handles.rucby(1)];
cdata=handles.currentdatay(:,12);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);



% --- Executes on button press in maximizetdz.
function maximizetdz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetbz.
function maximizetbz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettz.
function maximizettz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettz.
function maximizehez_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,4);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenz.
function maximizenz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeulz.
function maximizeulz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeulz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizellz.
function maximizellz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejaz.
function maximizejaz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcz.
function maximizelcz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercz.
function maximizercz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeez.
function maximizeez_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeez.
function maximizerez_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,12);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);




% --- Executes on button press in maximizetdz.
function maximizetdp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetbp.
function maximizetbp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettp.
function maximizettp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettp.
function maximizehep_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,4);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenp.
function maximizenop_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeulp.
function maximizeulp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeulp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizellp.
function maximizellp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejap.
function maximizejap_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcp.
function maximizelcp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercp.
function maximizercp_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeep.
function maximizelep_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeep.
function maximizerep_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,12);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in maximizetdz.
function maximizetdt_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetbt.
function maximizetbt_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettt.
function maximizettt_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettt.
function maximizehet_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,4);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizent.
function maximizenot_Callback(hObject, eventdata, handles)
% hObject    handle to maximizent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeult.
function maximizeult_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizellt.
function maximizellt_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejat.
function maximizejat_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelct.
function maximizelct_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizerct.
function maximizerct_Callback(hObject, eventdata, handles)
% hObject    handle to maximizerct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeet.
function maximizelet_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeet.
function maximizeret_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,12);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);


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
ylabel('mm/rad')
set(ax,'color',[0.95 0.95 0.95]);
%set(hplot,'LineWidth',1.5) %hplot is output of plot

if b==1
msgbox(['figure ' num2str(handles.fig) ' is full! Select "new" or "restart" instead!']...
            ,'EMA warnning','warn')
end

hold off

guidata(hObject, handles);


%art
%subplotfigure

%% subplot button 
% --- Executes on button press in arttdx.
function arttdx_Callback(hObject, eventdata, handles)
% hObject    handle to arttdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,1);
subplotfigure(hObject, eventdata, handles, cdata, signame);

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

% --- Executes on button press in artnx.
function arthex_Callback(hObject, eventdata, handles)
% hObject    handle to artnx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,4);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnx.
function artnx_Callback(hObject, eventdata, handles)
% hObject    handle to artnx (see GCBO)
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
subplotfigure(hObject, eventdata, handles, cdata,signame);

% --- Executes on button press in artllx.
function artllx_Callback(hObject, eventdata, handles)
% hObject    handle to artllx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjax.
function artjx_Callback(hObject, eventdata, handles)
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
signame=['rc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcx.
function artrcx_Callback(hObject, eventdata, handles)
% hObject    handle to artrcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artex.
function artex_Callback(hObject, eventdata, handles)
% hObject    handle to artex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artex.
function artrex_Callback(hObject, eventdata, handles)
% hObject    handle to artex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,12);
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

% --- Executes on button press in artny.
function arthey_Callback(hObject, eventdata, handles)
% hObject    handle to artny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head y ' handles.rucby(1)];
cdata=handles.currentdatay(:,4);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artny.
function artny_Callback(hObject, eventdata, handles)
% hObject    handle to artny (see GCBO)
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
function artjy_Callback(hObject, eventdata, handles)
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
signame=['lc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcy.
function artrcy_Callback(hObject, eventdata, handles)
% hObject    handle to artrcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artey.
function artey_Callback(hObject, eventdata, handles)
% hObject    handle to artey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le y ' handles.rucby(1)];
cdata=handles.currentdatay(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artey.
function artrey_Callback(hObject, eventdata, handles)
% hObject    handle to artey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re y ' handles.rucby(1)];
cdata=handles.currentdatay(:,12);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in arttdz.
function arttdz_Callback(hObject, eventdata, handles)
% hObject    handle to arttdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttbz.
function arttbz_Callback(hObject, eventdata, handles)
% hObject    handle to arttbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artttz.
function artttz_Callback(hObject, eventdata, handles)
% hObject    handle to artttz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnz.
function arthez_Callback(hObject, eventdata, handles)
% hObject    handle to artnz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,4);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnz.
function artnz_Callback(hObject, eventdata, handles)
% hObject    handle to artnz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artulz.
function artulz_Callback(hObject, eventdata, handles)
% hObject    handle to artulz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artllz.
function artllz_Callback(hObject, eventdata, handles)
% hObject    handle to artllz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjaz.
function artjz_Callback(hObject, eventdata, handles)
% hObject    handle to artjaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcz.
function artlcz_Callback(hObject, eventdata, handles)
% hObject    handle to artlcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcz.
function artrcz_Callback(hObject, eventdata, handles)
% hObject    handle to artrcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artez.
function artez_Callback(hObject, eventdata, handles)
% hObject    handle to artez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artez.
function artrez_Callback(hObject, eventdata, handles)
% hObject    handle to artez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,12);
subplotfigure(hObject, eventdata, handles,cdata,signame);




% --- Executes on button press in arttdy.
function arttdp_Callback(hObject, eventdata, handles)
% hObject    handle to arttdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in arttbp.
function arttbp_Callback(hObject, eventdata, handles)
% hObject    handle to arttbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in artttp.
function artttp_Callback(hObject, eventdata, handles)
% hObject    handle to artttp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnp.
function arthep_Callback(hObject, eventdata, handles)
% hObject    handle to artnp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,4);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnp.
function artnop_Callback(hObject, eventdata, handles)
% hObject    handle to artnp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artulp.
function artulp_Callback(hObject, eventdata, handles)
% hObject    handle to artulp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artllp.
function artllp_Callback(hObject, eventdata, handles)
% hObject    handle to artllp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjap.
function artjap_Callback(hObject, eventdata, handles)
% hObject    handle to artjap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcp.
function artlcp_Callback(hObject, eventdata, handles)
% hObject    handle to artlcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcp.
function artrcp_Callback(hObject, eventdata, handles)
% hObject    handle to artrcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artep.
function artlep_Callback(hObject, eventdata, handles)
% hObject    handle to artep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artep.
function artrep_Callback(hObject, eventdata, handles)
% hObject    handle to artep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re p ' handles.rucbp(1)];
cdata=handles.currentdatap(:,12);
subplotfigure(hObject, eventdata, handles,cdata,signame);





% --- Executes on button press in arttdy.
function arttdt_Callback(hObject, eventdata, handles)
% hObject    handle to arttdt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['td t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in arttbt.
function arttbt_Callback(hObject, eventdata, handles)
% hObject    handle to arttbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tb t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in artttt.
function artttt_Callback(hObject, eventdata, handles)
% hObject    handle to artttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['tt t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnt.
function arthet_Callback(hObject, eventdata, handles)
% hObject    handle to artnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['head t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,4);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnt.
function artnot_Callback(hObject, eventdata, handles)
% hObject    handle to artnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['nose t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artult.
function artult_Callback(hObject, eventdata, handles)
% hObject    handle to artult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ul t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artllt.
function artllt_Callback(hObject, eventdata, handles)
% hObject    handle to artllt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['ll t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjat.
function artjat_Callback(hObject, eventdata, handles)
% hObject    handle to artjat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['jaw t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlct.
function artlct_Callback(hObject, eventdata, handles)
% hObject    handle to artlct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['lc t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrct.
function artrct_Callback(hObject, eventdata, handles)
% hObject    handle to artrct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['rc t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artet.
function artlet_Callback(hObject, eventdata, handles)
% hObject    handle to artet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['le t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artet.
function artret_Callback(hObject, eventdata, handles)
% hObject    handle to artet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['re t ' handles.rucbt(1)];
cdata=handles.currentdatat(:,12);
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
    title(handles.signame1), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==2)
    subplot(3,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(3,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==3)
    subplot(4,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==4)
    subplot(5,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm/rad')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,5),plot(handles.t,handles.sigsub4)
    title(handles.signame4), ylabel('mm/rad')
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


% --- Executes on button press in tongue_motion.
function tongue_motion_Callback(hObject, eventdata, handles)
% hObject    handle to tongue_motion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rate=200;
rateac=16000;
startpoint1=ceil(handles.lim(1)*rate);
stoppoint1=floor(handles.lim(2)*rate);
startpointa=ceil(handles.lim(1)*rateac);
stoppointa=floor(handles.lim(2)*rateac);
lentmax=size(handles.x3d_raw,1);
lentmaxac=length(handles.ac);

if (startpoint1 <=0 || startpoint1>lentmax), 
    startpoint1=1;
end
if (stoppoint1 > lentmax || stoppoint1 < 0), 
    stoppoint1=lentmax; 
end

if (startpointa <=0 || startpointa>lentmaxac), 
    startpointa=1;
end
if (stoppointa > lentmaxac || stoppointa < 0), 
    stoppointa=lentmaxac; 
end

question={'what do you want to see?';'Coil Motion:'};
see=questdlg(question,'Coil Motion', 'Without Correction',...
    'Head Correction','Jaw Correction','Without Correction');


switch see
    case 'Without Correction'
        jawmotionplotrh(handles.x3d_lp(startpoint1:stoppoint1,:),...
            handles.y3d_lp(startpoint1:stoppoint1,:),...
            handles.z3d_lp(startpoint1:stoppoint1,:),...
            rate,handles.ac(startpointa:stoppointa),rateac)
    case 'Head Correction'
        jawmotionplotrh(handles.x3dhead(startpoint1:stoppoint1,:),...
            handles.y3dhead(startpoint1:stoppoint1,:),...
            handles.z3dhead(startpoint1:stoppoint1,:),rate,...
            handles.ac(startpointa:stoppointa,:),rateac)
    case 'Jaw Correction'
        jawmotionplotrh(handles.x3dc(startpoint1:stoppoint1,:),...
            handles.y3dc(startpoint1:stoppoint1,:),...
            handles.z3dc(startpoint1:stoppoint1,:),rate,...
            handles.ac(startpointa:stoppointa,:),rateac)
    otherwise
        error('fail')
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                      %%
%%                  HEAD CORRECTIONS METHODS                            %%
%%                                                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in HeadCristianKross.
function HeadCristianKross_Callback(hObject, eventdata, handles)
% hObject    handle to HeadCristianKross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.cinfohead='Aplied to HC1';

set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'Cristian Kroos' char(39)]);

%trial and coils number
trial=get(handles.bite_trial,'String');
numbercoil=eval(['[' get(handles.NHRefcoil,'String') ']' ]);
path=handles.path1;

[x3dc,y3dc,z3dc]=KCcorrection(path,trial,numbercoil,handles.x3d_lp,...
    handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp);

siz=size(x3dc);
handles.x3dhead = x3dc;
handles.y3dhead = y3dc;
handles.z3dhead = z3dc;
handles.thetahead = zeros(siz);
handles.phihead   = zeros(siz);
handles.currentdatax = handles.x3dhead;
handles.currentdatay = handles.y3dhead;
handles.currentdataz = handles.z3dhead;
handles.currentdatap = handles.phihead;
handles.currentdatat = handles.thetahead;

handles.rucbx='hbb';
handles.rucby='hbb';
handles.rucbz='hbb';
handles.rucbp='hbb';
handles.rucbt='hbb';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)



% --- Executes on button press in HeadPosFolder.
function HeadPosFolder_Callback(hObject, eventdata, handles)
% hObject    handle to HeadPosFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.posOK)

handles.cinfohead='Aplied to HC2';

set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'Pos Folder' char(39)]);

handles.x3dhead = handles.x3dpos;
handles.y3dhead = handles.y3dpos;
handles.z3dhead = handles.z3dpos;
handles.thetahead = handles.thetapos;
handles.phihead   = handles.phipos;
handles.currentdatax = handles.x3dhead;
handles.currentdatay = handles.y3dhead;
handles.currentdataz = handles.z3dhead;
handles.currentdatap = handles.phihead;
handles.currentdatat = handles.thetahead;

handles.rucbx='hbb';
handles.rucby='hbb';
handles.rucbz='hbb';
handles.rucbp='hbb';
handles.rucbt='hbb';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)

else
   msg={'Pos Folder does not exist!';'Chose other Head correction Method'};
   errordlg(msg,'Error');
end
 
% --- Executes on button press in HeadRefAxes.
function HeadRefAxes_Callback(hObject, eventdata, handles)
% hObject    handle to HeadRefAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cinfohead='Aplied to HC3';

set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'Rafael Henriques method' char(39)]);

%bitetrial=get(handles.bite_trial,'String');
%resttrial=get(handles.Resting_trial,'String');
trial=get(handles.bite_trial,'String');
numbercoil=eval(['[' get(handles.NHRefcoil,'String') ']' ]);
path=handles.path1;

[x3dc,y3dc,z3dc,phic,thetac]=HeadCorrection(path,trial,...
    numbercoil,handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
    handles.phi_lp,handles.theta_lp);
handles.x3dhead = x3dc;
handles.y3dhead = y3dc;
handles.z3dhead = z3dc;
handles.phihead = phic;
handles.thetahead   = thetac;

handles.currentdatax = handles.x3dhead;
handles.currentdatay = handles.y3dhead;
handles.currentdataz = handles.z3dhead;
handles.currentdatap = handles.phihead;
handles.currentdatat = handles.thetahead;

handles.rucbx='hbb';
handles.rucby='hbb';
handles.rucbz='hbb';
handles.rucbp='hbb';
handles.rucbt='hbb';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)


% --- Executes on button press in HeadNone.
function HeadNone_Callback(hObject, eventdata, handles)
% hObject    handle to HeadNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cinfohead='Aplied to HC4';

set(handles.currentheadmethod,'string',...
    ['Current Method ' char(39) 'No Correction' char(39)]);

handles.x3dhead=handles.x3d_lp;
handles.y3dhead=handles.y3d_lp;
handles.z3dhead=handles.z3d_lp;
handles.phihead=handles.phi_lp;
handles.thetahead=handles.theta_lp;

handles.currentdatax = handles.x3dhead;
handles.currentdatay = handles.y3dhead;
handles.currentdataz = handles.z3dhead;
handles.currentdatap = handles.phihead;
handles.currentdatat = handles.thetahead;

handles.rucbx='hbb';
handles.rucby='hbb';
handles.rucbz='hbb';
handles.rucbp='hbb';
handles.rucbt='hbb';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)

% Update handles structure
guidata(hObject, handles);    


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                      %%
%%                   JAW CORRECTIONS METHODS                            %%
%%                                                                      %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in Jawcoil1.
function Jawcoil1_Callback(hObject, eventdata, handles)
% hObject    handle to Jawcoil1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);
numbercoilhead=eval(['[' get(handles.NHRefcoil,'String') ']' ]);
if (length(numbercoil)==3)
    
    method=questdlg('what vertion do you want to use?',...
        'Rafael Henriques', 'Simple Jaw C','Jaw Coil Angle C',...
        'Bite & Resting trials','Simple Jaw C');
    switch method
        case 'Simple Jaw C'      
            
            if(strcmp(handles.cinfohead,'Aplied to HC1'))
            
                set(handles.headinfotojaw,'string','Aplied to HC4');
                
                set(handles.currentjawmethod,'string',...
                    ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
                
                [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection(numbercoil,handles.x3d_lp,...
                    handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp);
                
                msg={'JAW correction aplied to data with no head correction',...
       'because current head correction method do not correct angles'};
   
                questdlg(msg,'warning','OK','OK');
                
            else
                set(handles.headinfotojaw,'string',handles.cinfohead);
                
                set(handles.currentjawmethod,'string',...
                    ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
                
                [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection(numbercoil,handles.x3dhead,...
                    handles.y3dhead,handles.z3dhead,handles.phihead,handles.thetahead);
            end
            
        case 'Bite & Resting trials'
            
            %trial and coils number
            Rest_trial=get(handles.Resting_trial,'String');
            %Bite_trial=get(handles.bite_trial,'String');
            path=handles.path1;
            
            if(strcmp(handles.cinfohead,'Aplied to HC1'))
            
                set(handles.headinfotojaw,'string','Aplied to HC4');
                
                set(handles.currentjawmethod,'string',...
                    ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
                
                [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection(numbercoil,handles.x3d_lp,...
                    handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp,2,...
                path,Rest_trial,numbercoilhead);
                
                msg={'JAW correction Aplied to data with no head correction,',...
     'because the head correction method chosen do not correct angles!!!'};
   
                questdlg(msg,'warning','OK','OK');
                
            else
            
            set(handles.headinfotojaw,'string',handles.cinfohead);
            
            set(handles.currentjawmethod,'string',...
                ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
            
            [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection(numbercoil,handles.x3dhead,...
                handles.y3dhead,handles.z3dhead,handles.phihead,handles.thetahead,1,...
                path,Rest_trial,numbercoilhead);
            end
            
        case 'Jaw Coil Angle C'
            
            if(strcmp(handles.cinfohead,'Aplied to HC1'))
            
                set(handles.headinfotojaw,'string','Aplied to HC4');
                
                set(handles.currentjawmethod,'string',...
                    ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
                
                [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection1(numbercoil,handles.x3d_lp,...
                    handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp);
                
                msg={'JAW correction aplied to data with no head correction',...
       'because current head correction method do not correct angles'};
   
                questdlg(msg,'warning','OK','OK');
                
            else
                set(handles.headinfotojaw,'string',handles.cinfohead);
                
                set(handles.currentjawmethod,'string',...
                    ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
                
                [x3dc,y3dc,z3dc,phic,thetac]=JawCorrection1(numbercoil,handles.x3dhead,...
                    handles.y3dhead,handles.z3dhead,handles.phihead,handles.thetahead,1);
            end
        otherwise
            error('fail')
    end
    
    
    handles.x3dc = x3dc;
    handles.y3dc = y3dc;
    handles.z3dc = z3dc;
    handles.thetajaw = phic;
    handles.phijaw   = thetac;
    handles.currentdatax = handles.x3dc;
    handles.currentdatay = handles.y3dc;
    handles.currentdataz = handles.z3dc;
    handles.currentdatap = handles.phijaw;
    handles.currentdatat = handles.thetajaw;
    
    handles.rucbx='cgg';
    handles.rucby='cgg';
    handles.rucbz='cgg';
    handles.rucbp='cgg';
    handles.rucbt='cgg';
    
    % Update handles structure
    guidata(hObject, handles);
    
    currentplotx(handles)
    currentploty(handles)
    currentplotz(handles)
    currentplotphi(handles)
    currentplottheta(handles)
    
else
    msg={'Insufficient Number of coils!';...
        'Introduce 3 numbers in trial text box or chose other correction method!'};
    errordlg(msg,'Error');
end


% --- Executes on button press in JawCristianKross.
function JawCristianKross_Callback(hObject, eventdata, handles)
% hObject    handle to JawCristianKross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%trial and coils number
%Bite_trial=get(handles.bite_trial,'String');
Rest_trial=get(handles.Resting_trial,'String');
trial=get(handles.bite_trial,'String');
numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);
numbercoilhead=eval(['[' get(handles.NHRefcoil,'String') ']' ]);

%numbercoilhead=eval(['[' get(handles.NHRefcoil,'String') ']' ]);
path=handles.path1;

if (length(numbercoil)==3)
    
    set(handles.headinfotojaw,'string',handles.cinfohead);
    
    set(handles.currentjawmethod,'string',...
        ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
    
    method=questdlg('what vertion do you want to use?',...
        'Rafael Henriques', 'Simple Jaw C',...
        'Gold Jaw C','Simple Jaw C');
    
    switch method
        case 'Simple Jaw C'
            [x3dc,y3dc,z3dc]=KCcorrection(path,Rest_trial,numbercoil, ...
                handles.x3dhead,...
                handles.y3dhead,handles.z3dhead,...
                handles.phihead,handles.thetahead);
            
                siz=size(x3dc);
                handles.thetajaw = zeros(siz);
                handles.phijaw   = zeros(siz);
            
        case 'Gold Jaw C'

[x3dc,y3dc,z3dc,phic,thetac]=Gold(path,trial,...
    numbercoilhead,handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
    handles.phi_lp,handles.theta_lp, numbercoil);

                handles.thetajaw = phic;
                handles.phijaw   = thetac;
            
        %otherwise
     %       error('fail')
    end
    
    handles.x3dc = x3dc;
    handles.y3dc = y3dc;
    handles.z3dc = z3dc;
    handles.currentdatax = handles.x3dc;
    handles.currentdatay = handles.y3dc;
    handles.currentdataz = handles.z3dc;
    handles.currentdatap = handles.phijaw;
    handles.currentdatat = handles.thetajaw;
    
    handles.rucbx='cgg';
    handles.rucby='cgg';
    handles.rucbz='cgg';
    handles.rucbp='cgg';
    handles.rucbt='cgg';
    
    % Update handles structure
    guidata(hObject, handles);
    
    currentplotx(handles)
    currentploty(handles)
    currentplotz(handles)
    currentplotphi(handles)
    currentplottheta(handles)
else
    msg={'Insufficient Number of coils!';...
        'Introduce 3 numbers in trial text box or chose other correction method!'};
    errordlg(msg,'Error');
end


% --- Executes on button press in JawWestburyMethod.
function JawWestburyMethod_Callback(hObject, eventdata, handles)
% hObject    handle to JawWestburyMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);

set(handles.headinfotojaw,'string',handles.cinfohead);

set(handles.currentjawmethod,'string',...
    ['Current Method ' char(39) 'Westbury Method' char(39)]);


siz=size(handles.x3dhead);

for i=1:siz(2)
[handles.x3dc(:,i),handles.z3dc(:,i)]=...
    decouple_rh(handles.x3dhead(:,i),handles.z3dhead(:,i),...
    handles.x3dhead(:,numbercoil(1)),handles.z3dhead(:,numbercoil(1)),200);
end

handles.y3dc = zeros(siz);
handles.thetajaw = zeros(siz);
handles.phijaw   = zeros(siz);
handles.currentdatax = handles.x3dc;
handles.currentdatay = handles.y3dc;
handles.currentdataz = handles.z3dc;
handles.currentdatap = handles.phijaw;
handles.currentdatat = handles.thetajaw;

handles.rucbx='cgg';
handles.rucby='cgg';
handles.rucbz='cgg';
handles.rucbp='cgg';
handles.rucbt='cgg';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)

% --- Executes on button press in JawSimpledSubtraction.
function JawSimpledSubtraction_Callback(hObject, eventdata, handles)
% hObject    handle to JawSimpledSubtraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);

set(handles.headinfotojaw,'string',handles.cinfohead);

set(handles.currentjawmethod,'string',...
    ['Current Method ' char(39) 'Westbury Method' char(39)]);


siz=size(handles.x3dhead);

for i=1:siz(2)
   handles.x3dc(:,i)=handles.x3dhead(:,i)-handles.x3dhead(:,numbercoil(1));
   handles.y3dc(:,i)=handles.y3dhead(:,i)-handles.y3dhead(:,numbercoil(1));  
   handles.z3dc(:,i)=handles.z3dhead(:,i)-handles.z3dhead(:,numbercoil(1)); 
end

handles.thetajaw = zeros(siz);
handles.phijaw   = zeros(siz);
handles.currentdatax = handles.x3dc;
handles.currentdatay = handles.y3dc;
handles.currentdataz = handles.z3dc;
handles.currentdatap = handles.phijaw;
handles.currentdatat = handles.thetajaw;

handles.rucbx='cgg';
handles.rucby='cgg';
handles.rucbz='cgg';
handles.rucbp='cgg';
handles.rucbt='cgg';

% Update handles structure
guidata(hObject, handles);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)


function bite_trial_Callback(hObject, eventdata, handles)
% hObject    handle to bite_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bite_trial as text
%        str2double(get(hObject,'String')) returns contents of bite_trial as a double


% --- Executes during object creation, after setting all properties.
function bite_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bite_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Resting_trial_Callback(hObject, eventdata, handles)
% hObject    handle to Resting_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Resting_trial as text
%        str2double(get(hObject,'String')) returns contents of Resting_trial as a double


% --- Executes during object creation, after setting all properties.
function Resting_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Resting_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in returntoeguana.
function returntoeguana_Callback(hObject, eventdata, handles)
% hObject    handle to returntoeguana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=get(handles.tdx,'Parent');

EGUANA

close(a)



% --- Executes on button press in JawNone.
function JawNone_Callback(hObject, eventdata, handles)
% hObject    handle to JawNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function NHRefcoil_Callback(hObject, eventdata, handles)
% hObject    handle to NHRefcoil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NHRefcoil as text
%        str2double(get(hObject,'String')) returns contents of NHRefcoil as a double


% --- Executes during object creation, after setting all properties.
function NHRefcoil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NHRefcoil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NJRefcoil_Callback(hObject, eventdata, handles)
% hObject    handle to NJRefcoil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NJRefcoil as text
%        str2double(get(hObject,'String')) returns contents of NJRefcoil as a double


% --- Executes during object creation, after setting all properties.
function NJRefcoil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NJRefcoil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in comper2head2jaw.
function comper2head2jaw_Callback(hObject, eventdata, handles)
% hObject    handle to comper2head2jaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% %trial and coils number
% trial=get(handles.Resting_trial,'String');
% numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);
% path=handles.path1;
% 
% if (length(numbercoil)==3)
%     
% set(handles.headinfotojaw,'string',handles.cinfohead);
% 
% set(handles.currentjawmethod,'string',...
%     ['Current Method ' char(39) 'Adapted Cristisn Kroos' char(39)]);
% 
% end
% 
% 
% %% pre signal processing for jaw correction methods
% phij=unwrap(handles.phi_raw(:,8)*pi/180);
% thetaj=unwrap(handles.theta_raw(:,8)*pi/180);
% 
% phij=filter_array_rhv2(phij,200,6,0);
% thetaj=filter_array_rhv2(thetaj,200,6,0);
% 
% % thetaj=zeros(size(thetaj));
% % filter suggestion in thetaj variation take the main frenquency of speech
% % structure moves
% 
% figure('name','phi/tetha');
% subplot(2,1,1),plot(handles.t,phij),title('phi');
% subplot(2,1,2),plot(handles.t,thetaj),title('tetha');
% 
% %% preparing data to correct method with head
% tic
% le=length(phij);
% JCPH=zeros(5,3,le);
% 
% 
% %correction with head coils
% for i=1:le
% P=[handles.x3d_lp(i,1),handles.y3d_lp(i,1),handles.z3d_lp(i,1);
%    handles.x3d_lp(i,2),handles.y3d_lp(i,2),handles.z3d_lp(i,2);
%    handles.x3d_lp(i,3),handles.y3d_lp(i,3),handles.z3d_lp(i,3);
%    handles.x3d_lp(i,10),handles.y3d_lp(i,10),handles.z3d_lp(i,10);
%    handles.x3d_lp(i,9),handles.y3d_lp(i,9),handles.z3d_lp(i,9)];
% JP=[handles.x3d_lp(i,8),handles.y3d_lp(i,8),handles.z3d_lp(i,8)];
% EPL=[handles.x3d_lp(i,11),handles.y3d_lp(i,11),handles.z3d_lp(i,11)];
% EPR=[handles.x3d_lp(i,12),handles.y3d_lp(i,12),handles.z3d_lp(i,12)];
% [JCPH(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phij(i),thetaj(i));
% end
% 
% x3d_rafael_tdH=squeeze(JCPH(1,1,:));
% y3d_rafael_tdH=squeeze(JCPH(1,2,:));
% z3d_rafael_tdH=squeeze(JCPH(1,3,:));
% x3d_rafael_tbH=squeeze(JCPH(2,1,:));
% y3d_rafael_tbH=squeeze(JCPH(2,2,:));
% z3d_rafael_tbH=squeeze(JCPH(2,3,:));
% x3d_rafael_ttH=squeeze(JCPH(3,1,:));
% y3d_rafael_ttH=squeeze(JCPH(3,2,:));
% z3d_rafael_ttH=squeeze(JCPH(3,3,:));
% x3d_rafael_j1H=squeeze(JCPH(4,1,:));%r
% y3d_rafael_j1H=squeeze(JCPH(4,2,:));
% z3d_rafael_j1H=squeeze(JCPH(4,3,:));
% x3d_rafael_j2H=squeeze(JCPH(5,1,:));%l
% y3d_rafael_j2H=squeeze(JCPH(5,2,:));
% z3d_rafael_j2H=squeeze(JCPH(5,3,:));
% 
% t=toc
% 
% %% preparing data to correct
% tic
% le=length(phij);
% JCPR=zeros(5,3,le);
% 
% 
% %correction for 3 jaw coils reference coils are 2 molar
% for i=1:le
% P=[handles.x3d_lp(i,1),handles.y3d_lp(i,1),handles.z3d_lp(i,1);
%    handles.x3d_lp(i,2),handles.y3d_lp(i,2),handles.z3d_lp(i,2);
%    handles.x3d_lp(i,3),handles.y3d_lp(i,3),handles.z3d_lp(i,3);
%    handles.x3d_lp(i,10),handles.y3d_lp(i,10),handles.z3d_lp(i,10);
%    handles.x3d_lp(i,9),handles.y3d_lp(i,9),handles.z3d_lp(i,9)];
% JP=[handles.x3d_lp(i,8),handles.y3d_lp(i,8),handles.z3d_lp(i,8)];
% JPL=[handles.x3d_lp(i,9),handles.y3d_lp(i,9),handles.z3d_lp(i,9)];
% JPR=[handles.x3d_lp(i,10),handles.y3d_lp(i,10),handles.z3d_lp(i,10)];
% [JCPR(:,:,i)]=JAWCRAM(P,JP,JPL,JPR,phij(i),thetaj(i));
% end
% 
% x3d_rafael_tdR=squeeze(JCPR(1,1,:));
% y3d_rafael_tdR=squeeze(JCPR(1,2,:));
% z3d_rafael_tdR=squeeze(JCPR(1,3,:));
% x3d_rafael_tbR=squeeze(JCPR(2,1,:));
% y3d_rafael_tbR=squeeze(JCPR(2,2,:));
% z3d_rafael_tbR=squeeze(JCPR(2,3,:));
% x3d_rafael_ttR=squeeze(JCPR(3,1,:));
% y3d_rafael_ttR=squeeze(JCPR(3,2,:));
% z3d_rafael_ttR=squeeze(JCPR(3,3,:));
% x3d_rafael_j1R=squeeze(JCPR(4,1,:));%r
% y3d_rafael_j1R=squeeze(JCPR(4,2,:));
% z3d_rafael_j1R=squeeze(JCPR(4,3,:));
% x3d_rafael_j2R=squeeze(JCPR(5,1,:));%l
% y3d_rafael_j2R=squeeze(JCPR(5,2,:));
% z3d_rafael_j2R=squeeze(JCPR(5,3,:));
% 
% t=toc
% 
% coildecmotioncomparation(x3d_rafael_tdH,y3d_rafael_tdH,z3d_rafael_tdH,...
% x3d_rafael_tbH,y3d_rafael_tbH,z3d_rafael_tbH,x3d_rafael_ttH,...
% y3d_rafael_ttH,z3d_rafael_ttH,x3d_rafael_j1H,y3d_rafael_j1H,...
% z3d_rafael_j1H,x3d_rafael_j2H,y3d_rafael_j2H,z3d_rafael_j2H,...
% x3d_rafael_tdR,y3d_rafael_tdR,z3d_rafael_tdR,...
% x3d_rafael_tbR,y3d_rafael_tbR,z3d_rafael_tbR,x3d_rafael_ttR,...
% y3d_rafael_ttR,z3d_rafael_ttR,x3d_rafael_j1R,y3d_rafael_j1R,...
% z3d_rafael_j1R,x3d_rafael_j2R,y3d_rafael_j2R,z3d_rafael_j2R,...
% 200,handles.ac,16000)
% 
% pause
% 
% coildecmotioncomparationsplot(x3d_rafael_tdH,y3d_rafael_tdH,z3d_rafael_tdH,...
% x3d_rafael_tbH,y3d_rafael_tbH,z3d_rafael_tbH,x3d_rafael_ttH,...
% y3d_rafael_ttH,z3d_rafael_ttH,x3d_rafael_j1H,y3d_rafael_j1H,...
% z3d_rafael_j1H,x3d_rafael_j2H,y3d_rafael_j2H,z3d_rafael_j2H,...
% x3d_rafael_tdR,y3d_rafael_tdR,z3d_rafael_tdR,...
% x3d_rafael_tbR,y3d_rafael_tbR,z3d_rafael_tbR,x3d_rafael_ttR,...
% y3d_rafael_ttR,z3d_rafael_ttR,x3d_rafael_j1R,y3d_rafael_j1R,...
% z3d_rafael_j1R,x3d_rafael_j2R,y3d_rafael_j2R,z3d_rafael_j2R,...
% 200,handles.ac,16000)


% --- Executes on button press in pushbuttonHistogramAnalysis.
function pushbuttonHistogramAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHistogramAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=handles.path1;
trialbite=get(handles.bite_trial,'String');
numbercoil=eval(['[' get(handles.NJRefcoil,'String') ']' ]);
numbercoilhead=eval(['[' get(handles.NHRefcoil,'String') ']' ]);

PaperHistogram(handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
    handles.phi_lp,handles.theta_lp,...
    path,trialbite,numbercoil,numbercoilhead,handles.sub,handles.tri)

