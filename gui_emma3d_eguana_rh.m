function varargout = gui_emma3d_eguana_rh(varargin)
% GUI_EMMA3D_EGUANA_RH M-file for gui_emma3d_eguana_rh.fig
%      GUI_EMMA3D_EGUANA_RH, by itself, creates a new GUI_EMMA3D_EGUANA_RH or raises the existing
%      singleton*.
%
%      H = GUI_EMMA3D_EGUANA_RH returns the handle to a new GUI_EMMA3D_EGUANA_RH or the handle to
%      the existing singleton*.
%
%      GUI_EMMA3D_EGUANA_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EMMA3D_EGUANA_RH.M with the given input arguments.
%
%      GUI_EMMA3D_EGUANA_RH('Property','Value',...) creates a new GUI_EMMA3D_EGUANA_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_3d_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_emma3d_eguana_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_emma3d_eguana_rh

% Last Modified by GUIDE v2.5 19-Oct-2011 16:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_emma3d_eguana_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_emma3d_eguana_rh_OutputFcn, ...
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


% --- Executes just before gui_emma3d_eguana_rh is made visible.
function gui_emma3d_eguana_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_emma3d_eguana_rh (see VARARGIN)


%set(gcf, 'Units' , 'normalized');
%set(gcf, 'Position', [0, 0, 1, 1]);

% data3d.x3d (y3d, z3d) are the signals
% data3d.x3dspd are the speeds
data3d = varargin{1};
handles.x3d = data3d.x3d;
handles.y3d = data3d.y3d;
handles.z3d = data3d.z3d;
handles.x3d_raw = data3d.x3d_raw;
handles.y3d_raw = data3d.y3d_raw;
handles.z3d_raw = data3d.z3d_raw;
handles.x3d_lp = data3d.x3d_lp;
handles.y3d_lp = data3d.y3d_lp;
handles.z3d_lp = data3d.z3d_lp;
handles.x3dc = data3d.x3dc;
handles.y3dc = data3d.y3dc;
handles.z3dc = data3d.z3dc;
handles.x3dc_lp = data3d.x3dc_lp;
handles.y3dc_lp = data3d.y3dc_lp;
handles.z3dc_lp = data3d.z3dc_lp;
handles.currentdatax=data3d.x3d;
handles.currentdatay=data3d.y3d;
handles.currentdataz=data3d.z3d;

handles.bc = data3d.bc3d';
handles.td = data3d.td3d';
handles.tt = data3d.tt3d';
handles.tb = data3d.tb3d';
handles.currentbc = data3d.bc3d';
handles.currenttd = data3d.td3d';
handles.currenttt = data3d.tt3d';
handles.currenttb = data3d.tb3d';
handles.bc_lp = data3d.bc3d_lp';
handles.td_lp = data3d.td3d_lp';
handles.tt_lp = data3d.tt3d_lp';
handles.tb_lp = data3d.tb3d_lp';

handles.ac = data3d.ac3d;
handles.Fs = data3d.Fs3d;
handles.srate = data3d.srate3d;
if data3d.Fs3d ~= 0
    handles.player = audioplayer(data3d.ac3d,data3d.Fs3d);
else
    handles.player = 0;
end
    
handles.tri = data3d.tri3d;
handles.sess = data3d.sess3d;
handles.sub = data3d.sub3d;
handles.respath = data3d.respath3d;
handles.t=(1:1:(size(data3d.x3d,1)))/data3d.srate3d; %note sampling freq is 200Hz
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale=[char(39) 'auto' char(39)];

handles.rucbx='bbb';
handles.rucby='bbb';
handles.rucbz='bbb';
handles.rucbbc='bbb';
handles.rucbtd='bbb';
handles.rucbtb='bbb';
handles.rucbtt='bbb';
handles.rucbp='bbb';
handles.rucbt='bbb';
handles.figsub=1;
handles.fig=2;

handles.phi_raw=data3d.phi_raw;
handles.theta_raw=data3d.theta_raw;
handles.phi=data3d.phi;
handles.theta=data3d.theta;
handles.phi_lp=data3d.phi_lp;
handles.theta_lp=data3d.theta_lp;
handles.currentdatap=data3d.phi;
handles.currentdatat=data3d.theta;

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


% Choose default command line output for gui_emma3d_eguana_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_emma3d_eguana_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_emma3d_eguana_rh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function openall(handles)
% open or refresh all GUI plots
% date: 08/07/10 by: Rafael Henriques ODL

fs = 8; % fontsize for plotting

%note sampling freq of accoustict is handles.Fs Hz 
plot(handles.ac_axes1,(1:length(handles.ac))/handles.Fs,handles.ac);
set(handles.ac_axes1,'YTick',[],'XLim',handles.lim,'fontsize',fs);
%xlabel(handles.ac_axes1,'time (s)');

%positions
currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotphi(handles)
currentplottheta(handles)
currentplotbc(handles)
currentplottd(handles)
currentplottb(handles)
currentplottt(handles)

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

% --- Executes on button press in btdz.
function btdz_Callback(hObject, eventdata, handles)
% hObject    handle to btdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',1,'td ');


% --- Executes on button press in btdp.
function btdp_Callback(hObject, eventdata, handles)
% hObject    handle to btdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',1,'td ');

% --- Executes on button press in btdt.
function btdt_Callback(hObject, eventdata, handles)
% hObject    handle to btdt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',1,'td ');


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

% --- Executes on button press in bhex.
function bhex_Callback(hObject, eventdata, handles)
% hObject    handle to bhex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',4,'head ');

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
sig2(hObject, eventdata, handles,'x ',9,'lc ');

% --- Executes on button press in brcx.
function brcx_Callback(hObject, eventdata, handles)
% hObject    handle to brcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',10,'rc ');

% --- Executes on button press in bex.
function bex_Callback(hObject, eventdata, handles)
% hObject    handle to bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',11,'lear ');

% --- Executes on button press in brex.
function brex_Callback(hObject, eventdata, handles)
% hObject    handle to brex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'x ',12,'rear ');



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

% --- Executes on button press in bhex.
function bhey_Callback(hObject, eventdata, handles)
% hObject    handle to bhey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',4,'head ');

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
sig2(hObject, eventdata, handles,'y ',9,'lc ');

% --- Executes on button press in brcy.
function brcy_Callback(hObject, eventdata, handles)
% hObject    handle to brcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',10,'rc ');

% --- Executes on button press in bey.
function bey_Callback(hObject, eventdata, handles)
% hObject    handle to bey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',11,'lear ');

% --- Executes on button press in brex.
function brey_Callback(hObject, eventdata, handles)
% hObject    handle to brey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'y ',12,'rear ');




% --- Executes on button press in btbz.
function btbz_Callback(hObject, eventdata, handles)
% hObject    handle to btbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',2,'tb ');

% --- Executes on button press in bttz.
function bttz_Callback(hObject, eventdata, handles)
% hObject    handle to bttz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',3,'tt ');

% --- Executes on button press in bhex.
function bhez_Callback(hObject, eventdata, handles)
% hObject    handle to bhez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',4,'head ');

% --- Executes on button press in bnz.
function bnz_Callback(hObject, eventdata, handles)
% hObject    handle to bnz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',5,'n ');


% --- Executes on button press in bulz.
function bulz_Callback(hObject, eventdata, handles)
% hObject    handle to bulz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',6,'ul ');


% --- Executes on button press in bllz.
function bllz_Callback(hObject, eventdata, handles)
% hObject    handle to bllz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',7,'ll ');


% --- Executes on button press in bjz.
function bjz_Callback(hObject, eventdata, handles)
% hObject    handle to bjz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',8,'jaw ');


% --- Executes on button press in blcz.
function blcz_Callback(hObject, eventdata, handles)
% hObject    handle to blcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',9,'lc ');


% --- Executes on button press in brcz.
function brcz_Callback(hObject, eventdata, handles)
% hObject    handle to brcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',10,'rc ');


% --- Executes on button press in bez.
function bez_Callback(hObject, eventdata, handles)
% hObject    handle to bez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',11,'lear ');

% --- Executes on button press in brex.
function brez_Callback(hObject, eventdata, handles)
% hObject    handle to brez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'z ',12,'rear ');





% --- Executes on button press in btbp.
function btbp_Callback(hObject, eventdata, handles)
% hObject    handle to btbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',2,'tb ');

% --- Executes on button press in bttp.
function bttp_Callback(hObject, eventdata, handles)
% hObject    handle to bttp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',3,'tt ');


% --- Executes on button press in bttp.
function bhep_Callback(hObject, eventdata, handles)
% hObject    handle to bhep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',4,'he ');

% --- Executes on button press in bnop.
function bnop_Callback(hObject, eventdata, handles)
% hObject    handle to bnop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',5,'n ');

% --- Executes on button press in bulp.
function bulp_Callback(hObject, eventdata, handles)
% hObject    handle to bulp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',6,'ul ');

% --- Executes on button press in bllp.
function bllp_Callback(hObject, eventdata, handles)
% hObject    handle to bllp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',7,'ll ');

% --- Executes on button press in bjap.
function bjap_Callback(hObject, eventdata, handles)
% hObject    handle to bjap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',8,'jaw ');

% --- Executes on button press in blcp.
function blcp_Callback(hObject, eventdata, handles)
% hObject    handle to blcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',9,'lc ');

% --- Executes on button press in brcp.
function brcp_Callback(hObject, eventdata, handles)
% hObject    handle to brcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',10,'rc ');

% --- Executes on button press in blep.
function blep_Callback(hObject, eventdata, handles)
% hObject    handle to blep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',11,'lear ');

% --- Executes on button press in blep.
function brep_Callback(hObject, eventdata, handles)
% hObject    handle to blep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'phi ',12,'rear ');




% --- Executes on button press in btbp.
function btbt_Callback(hObject, eventdata, handles)
% hObject    handle to btbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',2,'tb ');

% --- Executes on button press in bttp.
function bttt_Callback(hObject, eventdata, handles)
% hObject    handle to bttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',3,'tt ');


% --- Executes on button press in bttp.
function bhet_Callback(hObject, eventdata, handles)
% hObject    handle to bhet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',4,'he ');

% --- Executes on button press in bnop.
function bnot_Callback(hObject, eventdata, handles)
% hObject    handle to bnot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',5,'n ');

% --- Executes on button press in bulp.
function bult_Callback(hObject, eventdata, handles)
% hObject    handle to bult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',6,'ul ');

% --- Executes on button press in bllp.
function bllt_Callback(hObject, eventdata, handles)
% hObject    handle to bllt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',7,'ll ');

% --- Executes on button press in bjap.
function bjat_Callback(hObject, eventdata, handles)
% hObject    handle to bjat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',8,'jaw ');

% --- Executes on button press in blcp.
function blct_Callback(hObject, eventdata, handles)
% hObject    handle to blct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',9,'lc ');

% --- Executes on button press in brcp.
function brct_Callback(hObject, eventdata, handles)
% hObject    handle to brct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',10,'rc ');

% --- Executes on button press in blep.
function blet_Callback(hObject, eventdata, handles)
% hObject    handle to blet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',11,'lear ');

% --- Executes on button press in blep.
function bret_Callback(hObject, eventdata, handles)
% hObject    handle to blet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'theta ',12,'rear ');





% --- Executes on button press in pushbutton_bc.
function pushbutton_bc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'BC ',1);

% --- Executes on button press in pushbutton_tb.
function pushbutton_tb_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TB ',1);

% --- Executes on button press in pushbutton_tt.
function pushbutton_tt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TT ',1);

% --- Executes on button press in pushbutton_td.
function pushbutton_td_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'TD ',1);

function sig2(hObject, eventdata, handles, dim, ch, chtag)
% this function changes the selected signals in the bottom right of
% gui_emma3d_eguana_rh so you can choose which 2 signals to analyze

if strcmp(dim,'x ')
    sig = handles.currentdatax;
elseif strcmp(dim,'y ')
    sig = handles.currentdatay;
elseif strcmp(dim,'z ')
    sig = handles.currentdataz;
elseif strcmp(dim,'BC ')
    sig = handles.currentbc;
elseif strcmp(dim, 'TD ')
    sig = handles.currenttd;
elseif strcmp(dim, 'TT ')
    sig = handles.currenttt;
elseif strcmp(dim, 'TB ')
    sig = handles.currenttb;
elseif strcmp(dim, 'phi')
    sig = handles.currentdatap;
elseif strcmp(dim, 'theta')
    sig = handles.currentdatat;
    
end


    if strcmp(dim,'x '),  sig_string = strcat(chtag,dim,handles.rucbx(1));
    elseif strcmp(dim,'y '),  sig_string = strcat(chtag,dim,handles.rucby(1));
    elseif strcmp(dim,'z '),  sig_string = strcat(chtag,dim,handles.rucbz(1));
    elseif strcmp(dim,'BC '),  sig_string = strcat(dim,handles.rucbbc(1));
    elseif strcmp(dim,'TD '),  sig_string = strcat(dim,handles.rucbtd(1));
    elseif strcmp(dim,'TB '),  sig_string = strcat(dim,handles.rucbtb(1));
    elseif strcmp(dim,'TT '),  sig_string = strcat(dim,handles.rucbtt(1));
    elseif strcmp(dim,'phi'),  sig_string = strcat(chtag,dim,handles.rucbp(1));
    elseif strcmp(dim,'theta'), sig_string = strcat(chtag,dim,handles.rucbt(1));
    end


if isempty(handles.sig1)
    handles.sig1 = sig(:,ch);
    handles.sig1ch = num2str(ch);
    set(handles.sig_ana_1,'string',sig_string);
    set(handles.int_selec_display,'enable','off')
    set(handles.warningtext,'String',...
'Cannot change interval selection! All 4 signals for analysis must have the same length')
    
elseif isempty(handles.sig2)
    handles.sig2 = sig(:,ch);
    handles.sig2ch = num2str(ch);
    set(handles.sig_ana_2,'string',sig_string);
elseif isempty(handles.sig3)
    handles.sig3 = sig(:,ch);
    handles.sig3ch = num2str(ch);
    set(handles.sig_ana_3,'string',sig_string);
elseif isempty(handles.sig4)
    handles.sig4 = sig(:,ch);
    handles.sig4ch = num2str(ch);
    set(handles.sig_ana_4,'string',sig_string);
else % rotate the signals (i.e. sig 1 becomes sig 2 and sig 2 becomes new selection)
    handles.sig1 = handles.sig2;
    handles.sig2 = handles.sig3;
    handles.sig3 = handles.sig4;    
    handles.sig4 = sig(:,ch);
    handles.sig1ch = handles.sig2ch;
    handles.sig2ch = handles.sig3ch;
    handles.sig3ch = handles.sig4ch;    
    handles.sig4ch = num2str(ch);
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
else  cancel_csti = 0;
end

if cancel_csti == 0
    sig1_string = get(handles.sig_ana_1,'string');
    sig2_string = get(handles.sig_ana_2,'string');
    sig3_string = get(handles.sig_ana_3,'string');
    sig4_string = get(handles.sig_ana_4,'string');
    
    csti_3d_rhv2(handles.sig1, handles.sig2,...
        handles.sig3, handles.sig4,...
        sig1_string, sig2_string, sig3_string, sig4_string, handles.ac, handles.Fs, handles.player, handles.tri,...
        handles.respath, handles.sub, handles.sess,handles.lim,handles.srate);

        
else
    errordlg('Please select 4 signals to analyze','Error');
end

%% push button play

% --- Executes on button press in play_ac.
function play_ac_Callback(hObject, eventdata, handles)
% hObject    handle to play_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.Fs ~= 0

acfs=handles.Fs; %acoustic sampling frequency
t0ac=ceil(handles.lim(1)*acfs);
tfac=floor(handles.lim(2)*acfs);
lenmaxac=length(handles.ac);

if t0ac <=0, t0ac=1; end
if tfac >=lenmaxac, tfac=lenmaxac; end

play(handles.player,[t0ac,tfac]);

end


%% Push Buttons raw, uncorrect, correct, both

% --- Executes on button press in pushbutton_rawx.
function pushbutton_rawx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rawx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x3d_raw;
handles.rucbx='rrr';

currentplotx(handles)
pushbuttonxonX_rh(handles)

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
pushbuttonxonX_rh(handles)

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_uncorrectx.
function pushbutton_uncorrectx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrectx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x3d;
handles.rucbx='bbb';

currentplotx(handles)
pushbuttonxonX_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_correctx.
function pushbutton_correctx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correctx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatax=handles.x3dc;
handles.rucbx='cgg';

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

handles.currentdatay=handles.y3d_raw;
handles.rucby='rrr';


currentploty(handles)
pushbuttonxonY_rh(handles)
    
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
pushbuttonxonY_rh(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_uncorrecty.
function pushbutton_uncorrecty_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrecty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y3d;
handles.rucby='bbb';

currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_correcty.
function pushbutton_correcty_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correcty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=handles.y3dc;
handles.rucby='cgg';

currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_bothy.
function pushbutton_bothy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bothz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdatay=[];

currentploty(handles)
pushbuttonxonY_rh(handles)
    
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
pushbuttonxonZ_rh(handles)
    
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
pushbuttonxonZ_rh(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_uncorrectz.
function pushbutton_uncorrectz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrectz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdataz=handles.z3d;
handles.rucbz='bbb';

currentplotz(handles)
pushbuttonxonZ_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_correctz.
function pushbutton_correctz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correctz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdataz=handles.z3dc;
handles.rucbz='cgg';

currentplotz(handles)
pushbuttonxonZ_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_bothz.
function pushbutton_bothz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bothz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.currentdataz=[];

currentplotz(handles)
pushbuttonxonZ_rh(handles)
    
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

% --- Executes on button press in pushbutton_uncorrectp.
function pushbutton_uncorrectp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrectp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatap=handles.phi;
handles.rucbp='bbb';

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

% --- Executes on button press in pushbutton_uncorrectp.
function pushbutton_uncorrectt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uncorrectt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentdatat=handles.theta;
handles.rucbt='bbb';

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


% --- Executes on button press in bc_bpf.
function bc_bpf_Callback(hObject, eventdata, handles)
% hObject    handle to bc_bpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentbc=handles.bc;
handles.rucbbc='bbb';

currentplotbc(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in bc_lpf.
function bc_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to bc_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentbc=handles.bc_lp;
handles.rucbbc='lmm';

currentplotbc(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in td_bpf.
function td_bpf_Callback(hObject, eventdata, handles)
% hObject    handle to td_bpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttd=handles.td;
handles.rucbtd='bbb';

currentplottd(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in td_lpf.
function td_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to td_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttd=handles.td_lp;
handles.rucbtd='lmm';

currentplottd(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in tb_bpf.
function tb_bpf_Callback(hObject, eventdata, handles)
% hObject    handle to tb_bpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttb=handles.tb;
handles.rucbtb='bbb';

currentplottb(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in tb_lpf.
function tb_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to tb_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttb=handles.tb_lp;
handles.rucbtb='lmm';

currentplottb(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in tt_bpf.
function tt_bpf_Callback(hObject, eventdata, handles)
% hObject    handle to tt_bpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttt=handles.tt;
handles.rucbtt='bbb';

currentplottt(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in tt_lpf.
function tt_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to tt_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currenttt=handles.tt_lp;
handles.rucbtt='lmm';

currentplottt(handles)
    
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
   
else
    plot(handles.tdx,handles.t,handles.x3d(:,1),'b',...
                     handles.t,handles.x3dc(:,1),'g');
    set(handles.tdx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdx,'YLim',handles.limscale)
    end
    
    plot(handles.tbx,handles.t,handles.x3d(:,2),'b',...
                     handles.t,handles.x3dc(:,2),'g');
    set(handles.tbx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbx,'YLim',handles.limscale)
    end
   
    plot(handles.ttx,handles.t,handles.x3d(:,3),'b',...
                     handles.t,handles.x3dc(:,3),'g');
    set(handles.ttx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttx,'YLim',handles.limscale)
    end
    
    plot(handles.hex,handles.t,handles.x3d(:,4),'b',...
                     handles.t,handles.x3dc(:,4),'g');
    set(handles.hex,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.hex,'YLim',handles.limscale)
    end
    
    plot(handles.nox,handles.t,handles.x3d(:,5),'b',...
                     handles.t,handles.x3dc(:,5),'g');
    set(handles.nox,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.nox,'YLim',handles.limscale)
    end
    
    plot(handles.ulx,handles.t,handles.x3d(:,6),'b',...
                     handles.t,handles.x3dc(:,6),'g');
    set(handles.ulx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.ulx,'YLim',handles.limscale)
    end
   
    plot(handles.llx,handles.t,handles.x3d(:,7),'b',...
                     handles.t,handles.x3dc(:,7),'g');
    set(handles.llx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.llx,'YLim',handles.limscale)
    end
    
    plot(handles.jax,handles.t,handles.x3d(:,8),'b',...
                     handles.t,handles.x3dc(:,8),'g');
    set(handles.jax,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.jax,'YLim',handles.limscale)
    end
    
    plot(handles.lcx,handles.t,handles.x3d(:,9),'b',...
                     handles.t,handles.x3dc(:,9),'g');
    set(handles.lcx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.lcx,'YLim',handles.limscale)
    end
    
    plot(handles.rcx,handles.t,handles.x3d(:,10),'b',...
                     handles.t,handles.x3dc(:,10),'g');
    set(handles.rcx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.rcx,'YLim',handles.limscale)
    end
    
    plot(handles.lex,handles.t,handles.x3d(:,11),'b',...
                     handles.t,handles.x3dc(:,11),'g');
    set(handles.lex,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.lex,'YLim',handles.limscale)
    end
    
    plot(handles.rex,handles.t,handles.x3d(:,12),'b',...
                     handles.t,handles.x3dc(:,12),'g');
    set(handles.rex,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
    xlabel(handles.rex,'time (s)');
    if(isnumeric(handles.limscale))
        set(handles.rex,'YLim',handles.limscale)
    end
    
end

function currentploty(handles)
% change the display of the 3d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 15/07/10

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
    
else
    
    plot(handles.tdy,handles.t,handles.y3d(:,1),'b',...
                     handles.t,handles.y3dc(:,1),'g');
    set(handles.tdy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdy,'YLim',handles.limscale)
    end
    
    plot(handles.tby,handles.t,handles.y3d(:,2),'b',...
                     handles.t,handles.y3dc(:,2),'g');
    set(handles.tby,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tby,'YLim',handles.limscale)
    end
    
    plot(handles.tty,handles.t,handles.y3d(:,3),'b',...
                     handles.t,handles.y3dc(:,3),'g');
    set(handles.tty,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tty,'YLim',handles.limscale)
    end
    
    plot(handles.hey,handles.t,handles.y3d(:,4),'b',...
                     handles.t,handles.y3dc(:,4),'g');
    set(handles.hey,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.hey,'YLim',handles.limscale)
    end
    
    plot(handles.noy,handles.t,handles.y3d(:,5),'b',...
                     handles.t,handles.y3dc(:,5),'g');
    set(handles.noy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.noy,'YLim',handles.limscale)
    end
    
    plot(handles.uly,handles.t,handles.y3d(:,6),'b',...
                     handles.t,handles.y3dc(:,6),'g');
    set(handles.uly,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.uly,'YLim',handles.limscale)
    end
    
    plot(handles.lly,handles.t,handles.y3d(:,7),'b',...
                     handles.t,handles.y3dc(:,7),'g');
    set(handles.lly,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.lly,'YLim',handles.limscale)
    end
    
    plot(handles.jay,handles.t,handles.y3d(:,8),'b',...
                     handles.t,handles.y3dc(:,8),'g');
    set(handles.jay,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.jay,'YLim',handles.limscale)
    end
    
    plot(handles.lcy,handles.t,handles.y3d(:,9),'b',...
                     handles.t,handles.y3dc(:,9),'g');
    set(handles.lcy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.lcy,'YLim',handles.limscale)
    end
    
   plot(handles.rcy,handles.t,handles.y3d(:,10),'b',...
                     handles.t,handles.y3dc(:,10),'g');
   set(handles.rcy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
   if(isnumeric(handles.limscale))
        set(handles.rcy,'YLim',handles.limscale)
   end
   
   plot(handles.ley,handles.t,handles.y3d(:,11),'b',...
                     handles.t,handles.y3dc(:,11),'g');
   set(handles.ley,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.ley,'YLim',handles.limscale)
   end
   
      
   plot(handles.rey,handles.t,handles.y3d(:,12),'b',...
                     handles.t,handles.y3dc(:,12),'g');
   set(handles.rey,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.rey,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.rey,'YLim',handles.limscale)
   end
   
end

function currentplotz(handles)
% change the display of the 3d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 8/08/10

fs=8;% fontsize for plotting

if (~isempty(handles.currentdataz))
    
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
    
else
    
    plot(handles.tdz,handles.t,handles.z3d(:,1),'b',...
                     handles.t,handles.z3dc(:,1),'g');
    set(handles.tdz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdz,'YLim',handles.limscale)
    end
    
    plot(handles.tbz,handles.t,handles.z3d(:,2),'b',...
                     handles.t,handles.z3dc(:,2),'g');
    set(handles.tbz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbz,'YLim',handles.limscale)
    end
    
    plot(handles.ttz,handles.t,handles.z3d(:,3),'b',...
                     handles.t,handles.z3dc(:,3),'g');
    set(handles.ttz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttz,'YLim',handles.limscale)
    end
    
    plot(handles.hez,handles.t,handles.z3d(:,4),'b',...
                     handles.t,handles.z3dc(:,4),'g');
    set(handles.hez,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.hez,'YLim',handles.limscale)
    end
    
    plot(handles.noz,handles.t,handles.z3d(:,5),'b',...
                     handles.t,handles.z3dc(:,5),'g');
    set(handles.noz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.noz,'YLim',handles.limscale)
    end
    
    plot(handles.ulz,handles.t,handles.z3d(:,6),'b',...
                     handles.t,handles.z3dc(:,6),'g');
    set(handles.ulz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.ulz,'YLim',handles.limscale)
    end
    
    plot(handles.llz,handles.t,handles.z3d(:,7),'b',...
                     handles.t,handles.z3dc(:,7),'g');
    set(handles.llz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.llz,'YLim',handles.limscale)
    end
    
    plot(handles.jaz,handles.t,handles.z3d(:,8),'b',...
                     handles.t,handles.z3dc(:,8),'g');
    set(handles.jaz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.jaz,'YLim',handles.limscale)
    end
    
    plot(handles.lcz,handles.t,handles.z3d(:,9),'b',...
                     handles.t,handles.z3dc(:,9),'g');
    set(handles.lcz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.lcz,'YLim',handles.limscale)
    end
    
   plot(handles.rcz,handles.t,handles.z3d(:,10),'b',...
                     handles.t,handles.z3dc(:,10),'g');
   set(handles.rcz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
   if(isnumeric(handles.limscale))
        set(handles.rcz,'YLim',handles.limscale)
   end
   
   plot(handles.lez,handles.t,handles.z3d(:,11),'b',...
                     handles.t,handles.z3dc(:,11),'g');
   set(handles.lez,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.lez,'YLim',handles.limscale)
   end
   
   plot(handles.rez,handles.t,handles.z3d(:,12),'b',...
                     handles.t,handles.z3dc(:,12),'g');
   set(handles.rez,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.rez,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.rez,'YLim',handles.limscale)
   end
    
end

function currentplotbc(handles)
%Gesture bc
fs=8;
plot(handles.bc_axes,handles.t,handles.currentbc,handles.rucbbc(2));
set(handles.bc_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.bc_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.bc_axes,'YLim',handles.limscale)
end

function currentplottb(handles)
%Gesture tb
fs=8;
plot(handles.tb_axes,handles.t,handles.currenttb,handles.rucbtb(2));
set(handles.tb_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.tb_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tb_axes,'YLim',handles.limscale)
end

function currentplottt(handles)
%Gesture tt
fs=8;
plot(handles.tt_axes,handles.t,handles.currenttt,handles.rucbtt(2));
set(handles.tt_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.tt_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tt_axes,'YLim',handles.limscale)
end

function currentplottd(handles)
%Gesture td
fs=8;
plot(handles.td_axes,handles.t,handles.currenttd,handles.rucbtd(2));
set(handles.td_axes,'XLim',handles.lim,'fontsize',fs);
xlabel(handles.td_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.td_axes,'YLim',handles.limscale)
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
    

function pushbuttonxonX_rh(handles)

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update (2d for 3d): 16/07/10

if(~isempty(handles.currentdatax))
    on_off='on';
else
    on_off='off';
end

set(handles.btdx,'enable',on_off);
set(handles.btbx,'enable',on_off);
set(handles.bttx,'enable',on_off);
set(handles.bhex,'enable',on_off);
set(handles.bnx,'enable',on_off);
set(handles.bulx,'enable',on_off);
set(handles.bllx,'enable',on_off);
set(handles.bjx,'enable',on_off);
set(handles.blcx,'enable',on_off);
set(handles.brcx,'enable',on_off);
set(handles.bex,'enable',on_off);
set(handles.brex,'enable',on_off);

set(handles.maximizetdx,'enable',on_off);
set(handles.maximizetbx,'enable',on_off);
set(handles.maximizettx,'enable',on_off);
set(handles.maximizehex,'enable',on_off);
set(handles.maximizenx,'enable', on_off)
set(handles.maximizeulx,'enable',on_off);
set(handles.maximizellx,'enable',on_off);
set(handles.maximizejax,'enable',on_off);
set(handles.maximizelcx,'enable',on_off);
set(handles.maximizercx,'enable',on_off);
set(handles.maximizeex,'enable',on_off);
set(handles.maximizerex,'enable',on_off);

set(handles.arttdx,'enable',on_off);
set(handles.arttbx,'enable',on_off);
set(handles.artttx,'enable',on_off);
set(handles.arthex,'enable',on_off);
set(handles.artnx,'enable',on_off);
set(handles.artulx,'enable',on_off);
set(handles.artllx,'enable',on_off);
set(handles.artjx,'enable',on_off);
set(handles.artlcx,'enable',on_off);
set(handles.artrcx,'enable',on_off);
set(handles.artex,'enable',on_off);
set(handles.artrex,'enable',on_off);

function pushbuttonxonY_rh(handles)

%date: 07/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 16/07/10 (2d for 3d)

if (~isempty(handles.currentdatay))
    on_off='on';
else
    on_off='off';
end

set(handles.btdy,'enable',on_off);
set(handles.btby,'enable',on_off);
set(handles.btty,'enable',on_off);
set(handles.bhey,'enable',on_off);
set(handles.bny,'enable',on_off);
set(handles.buly,'enable',on_off);
set(handles.blly,'enable',on_off);
set(handles.bjy,'enable',on_off);
set(handles.blcy,'enable',on_off);
set(handles.brcy,'enable',on_off);
set(handles.brcy,'enable',on_off);
set(handles.bey,'enable',on_off);
set(handles.brey,'enable',on_off);

set(handles.maximizetdy,'enable',on_off);
set(handles.maximizetby,'enable',on_off);
set(handles.maximizetty,'enable',on_off);
set(handles.maximizehey,'enable',on_off);
set(handles.maximizeny,'enable',on_off);
set(handles.maximizeuly,'enable',on_off);
set(handles.maximizelly,'enable',on_off);
set(handles.maximizejay,'enable',on_off);
set(handles.maximizelcy,'enable',on_off);
set(handles.maximizercy,'enable',on_off);
set(handles.maximizeey,'enable',on_off);
set(handles.maximizerey,'enable',on_off);

set(handles.arttdy,'enable',on_off);
set(handles.arttby,'enable',on_off);
set(handles.arttty,'enable',on_off);
set(handles.arthey,'enable',on_off);
set(handles.artny,'enable',on_off);
set(handles.artuly,'enable',on_off);
set(handles.artlly,'enable',on_off);
set(handles.artjy,'enable',on_off);
set(handles.artlcy,'enable',on_off);
set(handles.artrcy,'enable',on_off);
set(handles.artey,'enable',on_off);
set(handles.artrey,'enable',on_off);

function pushbuttonxonZ_rh(handles)

%date: 16/07/10 ------------------------- by: Rafael Henriques   ODL

if (~isempty(handles.currentdataz))
    on_off='on';
else
    on_off='off';
end

set(handles.btdz,'enable',on_off);
set(handles.btbz,'enable',on_off);
set(handles.bttz,'enable',on_off);
set(handles.bhez,'enable',on_off);
set(handles.bnz,'enable',on_off);
set(handles.bulz,'enable',on_off);
set(handles.bllz,'enable',on_off);
set(handles.bjz,'enable',on_off);
set(handles.blcz,'enable',on_off);
set(handles.brcz,'enable',on_off);
set(handles.brcz,'enable',on_off);
set(handles.bez,'enable',on_off);
set(handles.brez,'enable',on_off);


set(handles.maximizetdz,'enable',on_off);
set(handles.maximizetbz,'enable',on_off);
set(handles.maximizettz,'enable',on_off);
set(handles.maximizehez,'enable',on_off);
set(handles.maximizenz,'enable',on_off);
set(handles.maximizeulz,'enable',on_off);
set(handles.maximizellz,'enable',on_off);
set(handles.maximizejaz,'enable',on_off);
set(handles.maximizelcz,'enable',on_off);
set(handles.maximizercz,'enable',on_off);
set(handles.maximizeez,'enable',on_off);
set(handles.maximizerez,'enable',on_off);

set(handles.arttdz,'enable',on_off);
set(handles.arttbz,'enable',on_off);
set(handles.artttz,'enable',on_off);
set(handles.arthez,'enable',on_off);
set(handles.artnz,'enable',on_off);
set(handles.artulz,'enable',on_off);
set(handles.artllz,'enable',on_off);
set(handles.artjz,'enable',on_off);
set(handles.artlcz,'enable',on_off);
set(handles.artrcz,'enable',on_off);
set(handles.artez,'enable',on_off);
set(handles.artrez,'enable',on_off);

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
handles.currentdatax=handles.x3d;
handles.currentdatay=handles.y3d;
handles.currentdataz=handles.z3d;
handles.currentdatap=handles.phi;
handles.currentdatat=handles.theta;
handles.currentbc=handles.bc;
handles.currenttd=handles.td;
handles.currenttb=handles.tb;
handles.currenttt=handles.tt;
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale='auto';
handles.rucbx='bbb';
handles.rucby='bbb';
handles.rucbz='bbb';
handles.rucbp='bbb';
handles.rucbt='bbb';
handles.rucbbc='bbb';
handles.rucbtd='bbb';
handles.rucbtb='bbb';
handles.rucbtt='bbb';

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
pushbuttonxonZ_rh(handles)

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


% --- Executes on button press in maximizebc.
function maximizebc_Callback(hObject, eventdata, handles)
% hObject    handle to maximizebc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['BC ', handles.rucbbc(1)];
cdata=handles.currentbc;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetb.
function maximizetb_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TB ', handles.rucbtb(1)];
cdata=handles.currenttb;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizett.
function maximizett_Callback(hObject, eventdata, handles)
% hObject    handle to maximizett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TT ', handles.rucbtt(1)];
cdata=handles.currenttt;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetd.
function maximizetd_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TD ', handles.rucbtd(1)];
cdata=handles.currenttd;
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
    plot(ax,(1:length(handles.ac))/handles.Fs,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1);
    legend('acoustic',handles.signame1,1)
elseif(a==2)
    plot(ax,(1:length(handles.ac))/handles.Fs,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1,handles.t,handles.sigmax2);
    legend('acoustic',handles.signame1,handles.signame2,1)
elseif(a==3)
    plot(ax,(1:length(handles.ac))/handles.Fs,...
    handles.ac/(max(handles.ac))*max(handles.sigmax1),...
    handles.t,handles.sigmax1,handles.t,handles.sigmax2,...
    handles.t,handles.sigmax3);
    legend('acoustic',handles.signame1,handles.signame2,handles.signame3,1)
elseif(a==4)
    plot(ax,(1:length(handles.ac))/handles.Fs,...
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
ylabel('mm/deg')
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




% --- Executes on button press in artbc.
function artbc_Callback(hObject, eventdata, handles)
% hObject    handle to artbc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['BC ' handles.rucbbc(1)];
cdata=handles.currentbc;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttb.
function arttb_Callback(hObject, eventdata, handles)
% hObject    handle to arttb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TB ' handles.rucbtb(1)];
cdata=handles.tb;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttt.
function arttt_Callback(hObject, eventdata, handles)
% hObject    handle to arttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TT ' handles.rucbtt(1)];
cdata=handles.currenttt;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttd.
function arttd_Callback(hObject, eventdata, handles)
% hObject    handle to arttd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=['TD ' handles.rucbtd(1)];
cdata=handles.currenttd;
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
subplot(a+1,1,1), plot((1:length(handles.ac))/handles.Fs,handles.ac)
set(gca,'YTick',[],'XLim',handles.lim);
title('acoustic')

if(a==1)
    subplot(2,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==2)
    subplot(3,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(3,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==3)
    subplot(4,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(4,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    xlabel('time (s)')
    
elseif(a==4)
    subplot(5,1,2),plot(handles.t,handles.sigsub1)
    title(handles.signame1), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,3),plot(handles.t,handles.sigsub2)
    title(handles.signame2), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,4),plot(handles.t,handles.sigsub3)
    title(handles.signame3), ylabel('mm/deg')
    set(gca,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(gca,'YLim',handles.limscale)
    end
    
    subplot(5,1,5),plot(handles.t,handles.sigsub4)
    title(handles.signame4), ylabel('mm/deg')
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


% --- Executes on button press in pushbutton_data.
function pushbutton_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hf=figure;
 
scnsize=get(0, 'ScreenSize');

set(hf,'color',[0.8 0.8 0.8],'name','Coils Motion',...
    'position',...
    [0.2*scnsize(3),0.05*scnsize(4),0.55*scnsize(3),0.85*scnsize(4)]);
   
uipanel('Title','Data','FontSize',14,...
        'BackgroundColor',[0.93 0.93 0.93],'Units','Normalized',...
        'Position',[.025 .025 .95 .95],'HighlightColor','b',...
        'ForegroundColor','b');
Datatable=[handles.x3d_raw,handles.y3d_raw,handles.z3d_raw,...
          handles.phi_raw,handles.theta_raw,handles.x3d_lp,...
          handles.y3d_lp,handles.z3d_lp,handles.phi_lp,...
          handles.theta_lp,handles.x3d,handles.y3d,handles.z3d,...
          handles.phi,handles.theta,handles.x3dc,handles.y3dc,handles.z3dc,...
          handles.bc_lp,handles.td_lp,handles.tb_lp,handles.tt_lp,...
          handles.bc,handles.td,handles.tb,handles.tt]; 
          


names={'raw x td','raw x tb','raw x tt','raw x head','raw x nose','raw x ul','raw x ll','raw x jaw','raw x lc','raw x rc','raw x lear','raw x rear',...
'raw y td','raw y tb','raw y tt','raw y head','raw y nose','raw y ul','raw y ll','raw y jaw','raw y lc','raw y rc','raw y lear','raw y rear',...
'raw z td','raw z tb','raw z tt','raw z head','raw z nose','raw z ul','raw z ll','raw z jaw','raw z lc','raw z rc','raw z lear','raw z rear',...
'raw phi td','raw phi tb','raw phi tt','raw phi head','raw phi nose','raw phi ul','raw phi ll','raw phi jaw','raw phi lc','raw phi rc','raw phi lear','raw phi rear',...
'raw theta td','raw theta tb','raw theta tt','raw theta head','raw theta nose','raw theta ul','raw theta ll','raw theta jaw','raw theta lc','raw theta rc','raw theta lear','raw theta rear',...
'low pass x td','low pass x tb','low pass x tt','low pass x head','low pass x nose','low pass x ul','low pass x ll','low pass x jaw','low pass x lc','low pass x rc','low pass x lear','low pass x rear',...
'low pass y td','low pass y tb','low pass y tt','low pass y head','low pass y nose','low pass y ul','low pass y ll','low pass y jaw','low pass y lc','low pass y rc','low pass y lear','low pass y rear',...
'low pass z td','low pass z tb','low pass z tt','low pass z head','low pass z nose','low pass z ul','low pass z ll','low pass z jaw','low pass z lc','low pass z rc','low pass z lear','low pass z rear',...
'low pass phi td','low pass phi tb','low pass phi tt','low pass phi head','low pass phi nose','low pass phi ul','low pass phi ll','low pass phi jaw','low pass phi lc','low pass phi rc','low pass phi lear','low pass phi rear',...
'low pass theta td','low pass theta tb','low pass theta tt','low pass theta head','low pass theta nose','low pass theta ul','low pass theta ll','low pass theta jaw','low pass theta lc','low pass theta rc','low pass theta lear','low pass theta rear',...
'band pass x td','band pass x tb','band pass x tt','band pass x head','band pass x nose','band pass x ul','band pass x ll','band pass x jaw','band pass x lc','band pass x rc','band pass x lear','band pass x rear',...
'band pass y td','band pass y tb','band pass y tt','band pass y head','band pass y nose','band pass y ul','band pass y ll','band pass y jaw','band pass y lc','band pass y rc','band pass y lear','band pass y rear',...
'band pass z td','band pass z tb','band pass z tt','band pass z head','band pass z nose','band pass z ul','band pass z ll','band pass z jaw','band pass z lc','band pass z rc','band pass z lear','band pass z rear',...
'band pass phi td','band pass phi tb','band pass phi tt','band pass phi head','band pass phi nose','band pass phi ul','band pass phi ll','band pass phi jaw','band pass phi lc','band pass phi rc','band pass phi lear','band pass phi rear',...
'band pass theta td','band pass theta tb','band pass theta tt','band pass theta head','band pass theta nose','band pass theta ul','band pass theta ll','band pass theta jaw','band pass theta lc','band pass theta rc','band pass theta lear','band pass theta rear',...
'jaw correct x td','jaw correct x tb','jaw correct x tt','jaw correct x head','jaw correct x nose','jaw correct x ul','jaw correct x ll','jaw correct x jaw','jaw correct x lc','jaw correct x rc','jaw correct x lear','jaw correct x rear',...
'jaw correct y td','jaw correct y tb','jaw correct y tt','jaw correct y head','jaw correct y nose','jaw correct y ul','jaw correct y ll','jaw correct y jaw','jaw correct y lc','jaw correct y rc','jaw correct y lear','jaw correct y rear',...
'jaw correct z td','jaw correct z tb','jaw correct z tt','jaw correct z head','jaw correct z nose','jaw correct z ul','jaw correct z ll','jaw correct z jaw','jaw correct z lc','jaw correct z rc','jaw correct z lear','jaw correct z rear',...    
'low pass BC','low pass TD','low pass TB','low pass TT','band pass BC','band pass TD','band pass TB','band pass TT'};

uitable('Parent',hf,'Units','Normalized','position',[0.1 0.1 0.8 0.8],...
    'Data',Datatable,'ColumnName',names);

% --- Executes on button press in tongue_motion.
function tongue_motion_Callback(hObject, eventdata, handles)
% hObject    handle to tongue_motion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rate=handles.srate;
rateac=handles.Fs;
startpoint1=ceil(handles.lim(1)*rate);
stoppoint1=floor(handles.lim(2)*rate);
startpointa=ceil(handles.lim(1)*rateac);
stoppointa=floor(handles.lim(2)*rateac);
lentmax=size(handles.x3d,1);
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

% coilmotionplotrh(handles.x3d_lp(startpoint1:stoppoint1,:),...
%     handles.y3d_lp(startpoint1:stoppoint1,:),...
%     handles.z3d_lp(startpoint1:stoppoint1,:),...
%     rate,handles.ac(startpointa:stoppointa),rateac)

question={'what do you want to see?';'Coil Motion:'};
see=questdlg(question,'Coil Motion', ...
    'Head Correction','Jaw Correction','Head Correction');


switch see
    case 'Head Correction'
        jawmotionplotrh(handles.x3d_lp(startpoint1:stoppoint1,:),...
            handles.y3d_lp(startpoint1:stoppoint1,:),...
            handles.z3d_lp(startpoint1:stoppoint1,:),...
            rate,handles.ac(startpointa:stoppointa),rateac)

    case 'Jaw Correction'
        jawmotionplotrh(handles.x3dc_lp(startpoint1:stoppoint1,:),...
            handles.y3dc_lp(startpoint1:stoppoint1,:),...
            handles.z3dc_lp(startpoint1:stoppoint1,:),rate,...
            handles.ac(startpointa:stoppointa,:),rateac)
    otherwise
        error('fail')
end






% --- Executes on button press in disph.
function disph_Callback(hObject, eventdata, handles)
% hObject    handle to disph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



if (isempty(handles.sig1)||isempty(handles.sig2) ||isempty(handles.sig3)...
    ||isempty(handles.sig4)), cancel_disph = 1; 
else  cancel_disph = 0;
end

if cancel_disph == 0
    
    gui_disp_select(handles);

else
    errordlg('Please select 4 signals to analyze','Error');
end




