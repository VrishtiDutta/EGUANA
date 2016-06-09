function varargout = gui_emma3ddst_rh(varargin)
% GUI_EMMA3DDST_RH M-file for gui_emma3ddst_rh.fig
%      GUI_EMMA3DDST_RH, by itself, creates a new GUI_EMMA3DDST_RH or raises the existing
%      singleton*.
%
%      H = GUI_EMMA3DDST_RH returns the handle to a new GUI_EMMA3DDST_RH or the handle to
%      the existing singleton*.
%
%      GUI_EMMA3DDST_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EMMA3DDST_RH.M with the given input arguments.
%
%      GUI_EMMA3DDST_RH('Property','Value',...) creates a new GUI_EMMA3DDST_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_3d_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_emma3ddst_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_emma3ddst_rh

% Last Modified by GUIDE v2.5 01-Sep-2010 17:24:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_emma3ddst_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_emma3ddst_rh_OutputFcn, ...
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


% --- Executes just before gui_emma3ddst_rh is made visible.
function gui_emma3ddst_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_emma3ddst_rh (see VARARGIN)


%set(gcf, 'Units' , 'normalized');
%set(gcf, 'Position', [0, 0, 1, 1]);

% data3d.x3d (y3d, z3d) are the signals
% data3d.x3dspd are the speeds
data3d = varargin{1};
handles.x3d = data3d.x3d;
handles.y3d = data3d.y3d;
handles.z3d = data3d.z3d;
handles.x3d_lp = data3d.x3d_lp;
handles.y3d_lp = data3d.y3d_lp;
handles.z3d_lp = data3d.z3d_lp;
handles.x3d_raw = data3d.x3d_raw;
handles.y3d_raw = data3d.y3d_raw;
handles.z3d_raw = data3d.z3d_raw;
handles.x3dc = data3d.x3dc;
handles.y3dc = data3d.y3dc;
handles.z3dc = data3d.z3dc;
handles.xpv = data3d.x3d;
handles.ypv = data3d.y3d;
handles.zpv = data3d.z3d;
handles.xpvc = data3d.x3dc;
handles.ypvc = data3d.y3dc;
handles.zpvc = data3d.z3dc;
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
handles.tri = data3d.tri3d;
handles.sess = data3d.sess3d;
handles.sub = data3d.sub3d;
handles.respath = data3d.respath3d;
handles.t=(1:1:(size(data3d.x3d,1)))/200; %note sampling freq is 200Hz
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale=[char(39) 'auto' char(39)];
handles.rucbx='bbb';
handles.rucby='bbb';
handles.rucbz='bbb';
handles.rucbtt='bbb';
handles.rucbtb='bbb';
handles.rucbtd='bbb';
handles.rucbbc='bbb';
handles.figsub=1;
handles.fig=2;
handles.sel_posorvel='pos';
handles.RFselectionMode=0;
handles.dst=0;

%% calculate velocities
siz=size(handles.x3d_raw);
handles.velx3d_raw = zeros(siz);
handles.vely3d_raw = zeros(siz);
handles.velz3d_raw = zeros(siz);
handles.velx3d = zeros(siz);
handles.vely3d = zeros(siz);
handles.velz3d = zeros(siz);
handles.velx3d_lp = zeros(siz);
handles.vely3d_lp = zeros(siz);
handles.velz3d_lp = zeros(siz);
handles.velx3dc = zeros(siz);
handles.vely3dc = zeros(siz);
handles.velz3dc = zeros(siz);
handles.velbc = zeros(siz(1),1);
handles.veltt = zeros(siz(1),1);
handles.veltd = zeros(siz(1),1);
handles.veltb = zeros(siz(1),1);
handles.velbc_lp = zeros(siz(1),1);
handles.veltt_lp = zeros(siz(1),1);
handles.veltd_lp = zeros(siz(1),1);
handles.veltb_lp = zeros(siz(1),1);
handles.cRF=[];
handles.RF=[];
handles.dRF=[];

for k = 1:siz(2)
    handles.velx3d_raw(:,k) = AFGELEID(handles.x3d_raw(:,k),200);
    handles.vely3d_raw(:,k) = AFGELEID(handles.y3d_raw(:,k),200);
    handles.velz3d_raw(:,k) = AFGELEID(handles.z3d_raw(:,k),200);
    handles.velx3d_lp(:,k) = AFGELEID(handles.x3d_lp(:,k),200);
    handles.vely3d_lp(:,k) = AFGELEID(handles.y3d_lp(:,k),200);
    handles.velz3d_lp(:,k) = AFGELEID(handles.z3d_lp(:,k),200);
    handles.velx3d(:,k) = AFGELEID(handles.x3d(:,k),200);
    handles.vely3d(:,k) = AFGELEID(handles.y3d(:,k),200);
    handles.velz3d(:,k) = AFGELEID(handles.z3d(:,k),200);
    handles.velx3dc(:,k) = AFGELEID(handles.x3dc(:,k),200);
    handles.vely3dc(:,k) = AFGELEID(handles.y3dc(:,k),200);
    handles.velz3dc(:,k) = AFGELEID(handles.z3dc(:,k),200);
end
handles.velbc = AFGELEID(handles.bc, 200);
handles.veltt = AFGELEID(handles.tt, 200);
handles.veltd = AFGELEID(handles.td, 200);
handles.veltb = AFGELEID(handles.tb, 200);
handles.velbc_lp = AFGELEID(handles.bc_lp, 200);
handles.veltt_lp = AFGELEID(handles.tt_lp, 200);
handles.veltd_lp = AFGELEID(handles.td_lp, 200);
handles.veltb_lp = AFGELEID(handles.tb_lp, 200);

%%

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


% Choose default command line output for gui_emma3ddst_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_emma3ddst_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_emma3ddst_rh_OutputFcn(hObject, eventdata, handles) 
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

%note sampling freq of accoustict is 16000 Hz 
plot(handles.ac_axes1,(1:length(handles.ac))/16000,handles.ac);
set(handles.ac_axes1,'YTick',[],'XLim',handles.lim,'fontsize',fs);
xlabel(handles.ac_axes1,'time (s)');

%positions
currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplotbc(handles)
currentplottb(handles)
currentplottt(handles)
currentplottd(handles)

if (~isempty(handles.cRF))
    plot(handles.rf_axes,handles.t(handles.nf:handles.nl),handles.cRF)
    set(handles.rf_axes,'XLim',handles.lim,'fontsize',fs);
    xlabel(handles.rf_axes,'time (s)');
    ylabel(handles.rf_axes,'rad');
end

% %Gestures
% plot(handles.bc_axes,handles.t,handles.bc);
% set(handles.bc_axes,'XLim',handles.lim,'fontsize',fs);
% xlabel(handles.bc_axes,'time (s)');
% if(isnumeric(handles.limscale))
%     set(handles.bc_axes,'YLim',handles.limscale)
% end
% 
% plot(handles.tb_axes,handles.t,handles.tb);
% set(handles.tb_axes,'XLim',handles.lim,'fontsize',fs);
% xlabel(handles.tb_axes,'time (s)');
% if(isnumeric(handles.limscale))
%     set(handles.tb_axes,'YLim',handles.limscale)
% end
% 
% plot(handles.tt_axes,handles.t,handles.tt);
% set(handles.tt_axes,'XLim',handles.lim,'fontsize',fs);
% xlabel(handles.tt_axes,'time (s)');
% if(isnumeric(handles.limscale))
%     set(handles.tt_axes,'YLim',handles.limscale)
% end
% 
% plot(handles.td_axes,handles.t,handles.td);
% set(handles.td_axes,'XLim',handles.lim,'fontsize',fs);
% xlabel(handles.td_axes,'time (s)');
% if(isnumeric(handles.limscale))
%     set(handles.td_axes,'YLim',handles.limscale)
% end



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
sig2(hObject, eventdata, handles,'x ',11,'ear ');



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
sig2(hObject, eventdata, handles,'y ',11,'ear ');


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
sig2(hObject, eventdata, handles,'z ',11,'ear ');

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


% --- Executes on button press in pushbutton_rf.
function pushbutton_rf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sig2(hObject, eventdata, handles,'RF ',1);

function sig2(hObject, eventdata, handles, dim, ch, chtag)
% this function changes the selected signals in the bottom right of
% gui_emma3ddst_rh so you can choose which 2 signals to analyze


PorV=handles.sel_posorvel;

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
elseif strcmp(dim, 'RF ')
    if(~isempty(handles.cRF)) 
        sig=zeros(size(handles.t))';
        sig(handles.nf:handles.nl)=handles.cRF;
    else return
    end
end


if strcmp(dim,'x '),  sig_string = strcat(PorV,' ', chtag,dim,handles.rucby(1));
elseif strcmp(dim,'y '),  sig_string = strcat(PorV,' ', chtag,dim,handles.rucby(1));
elseif strcmp(dim,'z '),  sig_string = strcat(PorV,' ', chtag,dim,handles.rucbz(1));
elseif strcmp(dim,'TT '),  sig_string = strcat(PorV,' ', dim,handles.rucbtt(1));
elseif strcmp(dim,'TB '),  sig_string = strcat(PorV,' ', dim,handles.rucbtb(1));
elseif strcmp(dim,'TD '),  sig_string = strcat(PorV,' ', dim,handles.rucbtd(1));
elseif strcmp(dim,'BC '),  sig_string = strcat(PorV,' ',dim,handles.rucbbc(1));
elseif strcmp(dim,'RF '),  sig_string = strcat(get(handles.info_nd,'string'),' ', dim, get(handles.sig_ana_3,'string'),' ',get(handles.sig_ana_4,'string'));
end



if (handles.RFselectionMode)
    
    if(strcmp(dim,'RF '))
         errordlg('With this program is not possible to calculate a RF with a RF signal, sorry!','Error');
    else
        if isempty(handles.sig3)
            handles.sig3 = sig(:,ch);
            set(handles.sig_ana_3,'string',sig_string,'visible','on');
            %set(handles.int_selec_display,'enable','off')
            %set(handles.warningtext,'String',...
            %    'Cannot change interval selection! 2 signals for RF must have the same length')
            set(handles.text_RF_selection, 'string', 'use [x] to select 2nd signal')
            
        else
            handles.sig4 = sig(:,ch);
            set(handles.sig_ana_4,'string',sig_string,'visible','on');
            s=get(handles.sig_ana_3,'string');
            [handles.RF,handles.nf,handles.nl]=relativephase1pair(handles.sig3,handles.sig4,s,sig_string);
            handles.cRF=handles.RF;
            handles.dRF=AFGELEID(handles.RF,200);
            plot(handles.rf_axes,handles.t(handles.nf:handles.nl),handles.cRF)
            set(handles.rf_axes,'XLim',handles.lim,'fontsize',8);
            xlabel(handles.rf_axes,'time (s)');
            ylabel(handles.rf_axes,'rad');
            handles.sig3=[];
            handles.sig4=[];
            handles.RFselectionMode=0;
            set(handles.text_RF_selection, 'string', 'RF of Pair:')
            set(handles.warningtext,'String',...
                'Warning message')
            %set(handles.int_selec_display,'enable','on')
            set(handles.pushbutton_NRF,'visible','on')
            set(handles.pushbutton_DRF,'visible','on')
            set(handles.info_nd,'visible','on','string','n')
        end
    end
    
elseif(handles.dst==1)
    
    handles.sig1 = sig(:,ch);
    set(handles.sig_ana_1,'string',sig_string)
    rate=200;
    
    startpoint1=ceil(handles.lim(1)*rate);
    stoppoint1=floor(handles.lim(2)*rate);
    lentmax=size(handles.sig1,1);
    
    if (startpoint1 <=0 || startpoint1>lentmax),
        startpoint1=1;
    end
    if (stoppoint1 > lentmax || stoppoint1 < 0),
        stoppoint1=lentmax;
    end
    
    
    if(strcmp(dim,'RF '))
        if (startpoint1 <=handles.nf || startpoint1>handles.nl),
            startpoint1=handles.nf;
        end
        if (stoppoint1 > handles.nl || stoppoint1 < handles.nf),
            stoppoint1=handles.nl;
        end
    end
       
    hurst_rh(handles.sig1(startpoint1:stoppoint1),sig_string,rate)
    
    set(handles.text_selectmethod,'string','Select DST Method')
    set(handles.sig_ana_1,'visible','off','string',' ')
    
    handles.dst=0;
    
elseif(handles.dst==2)
    
    handles.sig1 = sig(:,ch);
    set(handles.sig_ana_1,'string',sig_string)
    rate=200;
    
    startpoint1=ceil(handles.lim(1)*rate);
    stoppoint1=floor(handles.lim(2)*rate);
    lentmax=size(handles.sig1,1);
    
    if (startpoint1 <=0 || startpoint1>lentmax),
        startpoint1=1;
    end
    if (stoppoint1 > lentmax || stoppoint1 < 0),
        stoppoint1=lentmax;
    end
    
    
    if(strcmp(dim,'RF '))
        if (startpoint1 <=handles.nf || startpoint1>handles.nl),
            startpoint1=handles.nf;
        end
        if (stoppoint1 > handles.nl || stoppoint1 < handles.nf),
            stoppoint1=handles.nl;
        end
    end
    
    set(handles.text_selectmethod,'string','Select DST Method')
    set(handles.sig_ana_1,'visible','off','string',' ')
    
    gui_rqa_eguana(handles.sig1(startpoint1:stoppoint1),sig_string,...
        handles.respath,handles.sess,handles.tri,handles.sub)
    
    handles.dst=0;
            
elseif(handles.dst==3)
    
    if (isempty(handles.sig1))
        handles.sig1 = sig(:,ch);
        set(handles.sig_ana_1,'string',sig_string)
    else 
        
        handles.sig2 = sig(:,ch);
        sig1_string = get(handles.sig_ana_1,'string');
        
        set(handles.sig_ana_2,'string',sig_string)
                
        gui_crqa_rh(handles.sig1, handles.sig2, sig1_string, sig_string,...
            handles.respath,handles.sess, handles.tri, handles.sub,handles.lim);
   
        set(handles.text_selectmethod,'string','Select DST Method')
        set(handles.sig_ana_1,'visible','off','string',' ')
        set(handles.sig_ana_2,'visible','off','string',' ')
    
        handles.dst=0;
        
    end
    
 
    
elseif(handles.dst==4)
    
    set(handles.text_selectmethod,'string','Select DST Method')
    set(handles.sig_ana_1,'visible','off','string',' ')
    
    handles.dst=0;
else
        errordlg('First Select DST method!!!','Error');
end

        
%     if isempty(handles.sig3)
%         handles.sig1 = sig(:,ch);
%         set(handles.sig_ana_1,'string',sig_string);
%     elseif isempty(handles.sig4)
%         handles.sig4 = sig(:,ch);
%         set(handles.sig_ana_4,'string',sig_string);
%     else % rotate the signals (i.e. sig 1 becomes sig 2 and sig 2 becomes new selection)
%         handles.sig1 = handles.sig2;
%         handles.sig2 = handles.sig3;
%         handles.sig3 = handles.sig4;
%         handles.sig4 = sig(:,ch);
%         set(handles.sig_ana_1','string',get(handles.sig_ana_2,'String'));
%         set(handles.sig_ana_2','string',get(handles.sig_ana_3,'String'));
%         set(handles.sig_ana_3','string',get(handles.sig_ana_4,'String'));
%         set(handles.sig_ana_4,'string',sig_string);
%     end
    

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


%% push button play

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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatax=handles.x3d_raw;
else
    handles.currentdatax=handles.velx3d_raw;
end
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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatax=handles.x3d;
else
    handles.currentdatax=handles.velx3d;
end
handles.rucbx='bbb';

currentplotx(handles)
pushbuttonxonX_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_lpx.
function pushbutton_lpx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lpx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatax=handles.x3d_lp;
else
    handles.currentdatax=handles.velx3d_lp;
end
handles.rucbx='lmm';

currentplotx(handles)
pushbuttonxonX_rh(handles)

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton_correctx.
function pushbutton_correctx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correctx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatax=handles.x3dc;
else
    handles.currentdatax=handles.velx3dc;
end

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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatay=handles.y3d_raw;
else
    handles.currentdatay=handles.vely3d_raw;
end
handles.rucby='rrr';


currentploty(handles)
pushbuttonxonY_rh(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_lpy.
function pushbutton_lpy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lpy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatay=handles.y3d_lp;
else
    handles.currentdatay=handles.vely3d_lp;
end
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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatay=handles.y3d;
else
    handles.currentdatay=handles.vely3d;
end
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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdatay=handles.y3dc;
else
    handles.currentdatay=handles.vely3dc;
end
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


if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdataz=handles.z3d_raw;
else
    handles.currentdataz=handles.velz3d_raw;
end
handles.rucbz='rrr';


currentplotz(handles)
pushbuttonxonZ_rh(handles)
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_lpz.
function pushbutton_lpz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lpz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdataz=handles.z3d_lp;
else
    handles.currentdataz=handles.velz3d_lp;
end
handles.rucbz='rrr';
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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdataz=handles.z3d;
else
    handles.currentdataz=handles.velz3d;
end
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

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentdataz=handles.z3dc;
else
    handles.currentdataz=handles.velz3dc;
end
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


function currentplotx(handles)
% change the display of the 2d channel X positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 15/07/10

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
        set(handles.nox,'YLim',handles.limscale)
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
   set(handles.rcx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.rcx,'YLim',handles.limscale)
   end
   
   plot(handles.ex,handles.t,handles.currentdatax(:,11),handles.rucbx(2));
   set(handles.ex,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.ex,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.ex,'YLim',handles.limscale)
   end
   
   
else
    plot(handles.tdx,handles.t,handles.xpv(:,1),'b',...
                     handles.t,handles.xpvc(:,1),'g');
    set(handles.tdx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdx,'YLim',handles.limscale)
    end
    
    plot(handles.tbx,handles.t,handles.xpv(:,2),'b',...
                     handles.t,handles.xpvc(:,2),'g');
    set(handles.tbx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbx,'YLim',handles.limscale)
    end
   
    plot(handles.ttx,handles.t,handles.xpv(:,3),'b',...
                     handles.t,handles.xpvc(:,3),'g');
    set(handles.ttx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttx,'YLim',handles.limscale)
    end
    
    plot(handles.nox,handles.t,handles.xpv(:,5),'b',...
        handles.t,handles.xpvc(:,5),'g');
    set(handles.nox,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.nox,'YLim',handles.limscale)
    end
    
    plot(handles.ulx,handles.t,handles.xpv(:,6),'b',...
        handles.t,handles.xpvc(:,6),'g');
    set(handles.ulx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ulx,'YLim',handles.limscale)
    end
   
    plot(handles.llx,handles.t,handles.xpv(:,7),'b',...
                     handles.t,handles.xpvc(:,7),'g');
    set(handles.llx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.llx,'YLim',handles.limscale)
    end
    
    plot(handles.jax,handles.t,handles.xpv(:,8),'b',...
        handles.t,handles.xpvc(:,8),'g');
    set(handles.jax,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jax,'YLim',handles.limscale)
    end
    
    plot(handles.lcx,handles.t,handles.xpv(:,9),'b',...
        handles.t,handles.xpvc(:,9),'g');
    set(handles.lcx,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcx,'YLim',handles.limscale)
    end
    
    plot(handles.rcx,handles.t,handles.xpv(:,10),'b',...
        handles.t,handles.xpvc(:,10),'g');
    set(handles.rcx,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.rcx,'YLim',handles.limscale)
    end
    
    plot(handles.ex,handles.t,handles.xpv(:,11),'b',...
        handles.t,handles.xpvc(:,11),'g');
    set(handles.ex,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
    xlabel(handles.ex,'time (s)');
    if(isnumeric(handles.limscale))
        set(handles.ex,'YLim',handles.limscale)
    end
    
end

function currentploty(handles)
% change the display of the 2d channel Y positions according to 
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
   set(handles.rcy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.rcy,'YLim',handles.limscale)
   end
   
   plot(handles.ey,handles.t,handles.currentdatay(:,11),handles.rucby(2));
   set(handles.ey,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.ey,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.ey,'YLim',handles.limscale)
   end
    
    
else
    
    plot(handles.tdy,handles.t,handles.ypv(:,1),'b',...
                     handles.t,handles.ypvc(:,1),'g');
    set(handles.tdy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdy,'YLim',handles.limscale)
    end
    
    plot(handles.tby,handles.t,handles.ypv(:,2),'b',...
                     handles.t,handles.ypvc(:,2),'g');
    set(handles.tby,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tby,'YLim',handles.limscale)
    end
    
    plot(handles.tty,handles.t,handles.ypv(:,3),'b',...
                     handles.t,handles.ypvc(:,3),'g');
    set(handles.tty,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tty,'YLim',handles.limscale)
    end
    
    plot(handles.noy,handles.t,handles.ypv(:,5),'b',...
                     handles.t,handles.ypvc(:,5),'g');
    set(handles.noy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.noy,'YLim',handles.limscale)
    end
    
    plot(handles.uly,handles.t,handles.ypv(:,6),'b',...
                     handles.t,handles.ypvc(:,6),'g');
    set(handles.uly,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.uly,'YLim',handles.limscale)
    end
    
    plot(handles.lly,handles.t,handles.ypv(:,7),'b',...
                     handles.t,handles.ypvc(:,7),'g');
    set(handles.lly,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lly,'YLim',handles.limscale)
    end
    
    plot(handles.jay,handles.t,handles.ypv(:,8),'b',...
                     handles.t,handles.ypvc(:,8),'g');
    set(handles.jay,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jay,'YLim',handles.limscale)
    end
    
    plot(handles.lcy,handles.t,handles.ypv(:,9),'b',...
                     handles.t,handles.ypvc(:,9),'g');
    set(handles.lcy,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcy,'YLim',handles.limscale)
    end
    
   plot(handles.rcy,handles.t,handles.ypv(:,10),'b',...
                     handles.t,handles.ypvc(:,10),'g');
   set(handles.rcy,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.rcy,'YLim',handles.limscale)
   end
   
   plot(handles.ey,handles.t,handles.ypv(:,11),'b',...
                     handles.t,handles.ypvc(:,11),'g');
   set(handles.ey,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.ey,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.ey,'YLim',handles.limscale)
   end
    
end

function currentplotz(handles)
% change the display of the 2d channel Y positions according to 
% raw/ correct / uncorrect push button, 
% For the both button it is displayed the comparision of the corrected
% and uncorrected data.

%date: 15/07/10 ------------------------- by: Rafael Henriques   ODL
%last update: 15/07/10

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
    
    plot(handles.noz,handles.t,handles.currentdataz(:,5),handles.rucbz(2));
    set(handles.noz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
        ,'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.noz,'YLim',handles.limscale)
    end
    
    plot(handles.ulz,handles.t,handles.currentdataz(:,6),handles.rucbz(2));
    set(handles.ulz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ulz,'YLim',handles.limscale)
    end
    
    plot(handles.llz,handles.t,handles.currentdataz(:,7),handles.rucbz(3));
    set(handles.llz,'XTick',[],'fontsize',fs,'XLim',handles.lim...
        ,'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.llz,'YLim',handles.limscale)
    end
    
    plot(handles.jaz,handles.t,handles.currentdataz(:,8),handles.rucbz(2));
    set(handles.jaz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jaz,'YLim',handles.limscale)
    end
    
    plot(handles.lcz,handles.t,handles.currentdataz(:,9),handles.rucbz(2));
    set(handles.lcz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcz,'YLim',handles.limscale)
    end
    
   plot(handles.rcz,handles.t,handles.currentdataz(:,10),handles.rucbz(2));
   set(handles.rcz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.rcz,'YLim',handles.limscale)
   end
   
   plot(handles.ez,handles.t,handles.currentdataz(:,11),handles.rucbz(2));
   set(handles.ez,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.ez,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.ez,'YLim',handles.limscale)
   end
    
    
else
    
    plot(handles.tdz,handles.t,handles.zpv(:,1),'b',...
                     handles.t,handles.zpvc(:,1),'g');
    set(handles.tdz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.tdz,'YLim',handles.limscale)
    end
    
    plot(handles.tbz,handles.t,handles.zpv(:,2),'b',...
                     handles.t,handles.zpvc(:,2),'g');
    set(handles.tbz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.tbz,'YLim',handles.limscale)
    end
    
    plot(handles.ttz,handles.t,handles.zpv(:,3),'b',...
                     handles.t,handles.zpvc(:,3),'g');
    set(handles.ttz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ttz,'YLim',handles.limscale)
    end
    
    plot(handles.noz,handles.t,handles.zpv(:,5),'b',...
                     handles.t,handles.zpvc(:,5),'g');
    set(handles.noz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.noz,'YLim',handles.limscale)
    end
    
    plot(handles.ulz,handles.t,handles.zpv(:,6),'b',...
                     handles.t,handles.zpvc(:,6),'g');
    set(handles.ulz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.ulz,'YLim',handles.limscale)
    end
    
    plot(handles.llz,handles.t,handles.zpv(:,7),'b',...
                     handles.t,handles.zpvc(:,7),'g');
    set(handles.llz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.llz,'YLim',handles.limscale)
    end
    
    plot(handles.jaz,handles.t,handles.zpv(:,8),'b',...
                     handles.t,handles.zpvc(:,8),'g');
    set(handles.jaz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
    if(isnumeric(handles.limscale))
        set(handles.jaz,'YLim',handles.limscale)
    end
    
    plot(handles.lcz,handles.t,handles.zpv(:,9),'b',...
                     handles.t,handles.zpvc(:,9),'g');
    set(handles.lcz,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
        'yaxislocation','right');
    if(isnumeric(handles.limscale))
        set(handles.lcz,'YLim',handles.limscale)
    end
    
   plot(handles.rcz,handles.t,handles.zpv(:,10),'b',...
                     handles.t,handles.zpvc(:,10),'g');
   set(handles.rcz,'XTick',[],'fontsize',fs,'XLim',handles.lim);
   if(isnumeric(handles.limscale))
        set(handles.rcz,'YLim',handles.limscale)
   end
   
   plot(handles.ez,handles.t,handles.zpv(:,11),'b',...
                     handles.t,handles.zpvc(:,11),'g');
   set(handles.ez,'fontsize',fs,'XLim',handles.lim,'yaxislocation','right');
   xlabel(handles.ez,'time (s)');
   if(isnumeric(handles.limscale))
        set(handles.ez,'YLim',handles.limscale)
   end
    
end


% --- Executes on button press in bc_bpf.
function gest_bpf_Callback(hObject, eventdata, handles)
% hObject    handle to bc_bpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentbc=handles.bc;
    handles.currenttt=handles.tt;
    handles.currenttb=handles.tb;
    handles.currenttd=handles.td;
else
    handles.currentbc=handles.velbc;
    handles.currenttt=handles.veltt;
    handles.currenttb=handles.veltb;
    handles.currenttd=handles.veltd;
end


handles.rucbbc='bbb';
handles.rucbtt='bbb';
handles.rucbtb='bbb';
handles.rucbtd='bbb';

currentplotbc(handles)
currentplottt(handles)
currentplottb(handles)
currentplottd(handles)
    
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in bc_lpf.
function gest_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to bc_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(handles.sel_posorvel,'pos'))
    handles.currentbc=handles.bc_lp;
    handles.currenttt=handles.tt_lp;
    handles.currenttb=handles.tb_lp;
    handles.currenttd=handles.td_lp;
else
    handles.currentbc=handles.velbc_lp;
    handles.currenttt=handles.veltt_lp;
    handles.currenttb=handles.veltb_lp;
    handles.currenttd=handles.veltd_lp;
end

handles.rucbbc='lmm';
handles.rucbtt='lmm';
handles.rucbtb='lmm';
handles.rucbtd='lmm';

currentplotbc(handles)
currentplottt(handles)
currentplottb(handles)
currentplottd(handles)
    
% Update handles structure
guidata(hObject, handles);


function currentplotbc(handles)
%Gesture bc
fs=8;
plot(handles.bc_axes,handles.t,handles.currentbc,handles.rucbbc(2));
set(handles.bc_axes,'XTick',[],'fontsize',fs,'XLim',handles.lim);
%xlabel(handles.bc_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.bc_axes,'YLim',handles.limscale)
end

function currentplottb(handles)
%Gesture tb
fs=8;
plot(handles.tb_axes,handles.t,handles.currenttb,handles.rucbtb(2));
set(handles.tb_axes,'XTick',[],'fontsize',fs,'XLim',handles.lim);
%xlabel(handles.tb_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tb_axes,'YLim',handles.limscale)
end

function currentplottt(handles)
%Gesture tt
fs=8;
plot(handles.tt_axes,handles.t,handles.currenttt,handles.rucbtt(2));
set(handles.tt_axes,'XLim',handles.lim,'fontsize',fs,...
     'yaxislocation','right');
%xlabel(handles.tt_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.tt_axes,'YLim',handles.limscale)
end

function currentplottd(handles)
%Gesture td
fs=8;
plot(handles.td_axes,handles.t,handles.currenttd,handles.rucbtd(2));
set(handles.td_axes,'XTick',[],'fontsize',fs,'XLim',handles.lim,...
     'yaxislocation','right');
%xlabel(handles.td_axes,'time (s)');
if(isnumeric(handles.limscale))
    set(handles.td_axes,'YLim',handles.limscale)
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
set(handles.bnx,'enable',on_off);
set(handles.bulx,'enable',on_off);
set(handles.bllx,'enable',on_off);
set(handles.bjx,'enable',on_off);
set(handles.blcx,'enable',on_off);
set(handles.brcx,'enable',on_off);
set(handles.bex,'enable',on_off);

set(handles.maximizetdx,'enable',on_off);
set(handles.maximizetbx,'enable',on_off);
set(handles.maximizettx,'enable',on_off);
set(handles.maximizenx,'enable', on_off)
set(handles.maximizeulx,'enable',on_off);
set(handles.maximizellx,'enable',on_off);
set(handles.maximizejax,'enable',on_off);
set(handles.maximizelcx,'enable',on_off);
set(handles.maximizercx,'enable',on_off);
set(handles.maximizeex,'enable',on_off);

set(handles.arttdx,'enable',on_off);
set(handles.arttbx,'enable',on_off);
set(handles.artttx,'enable',on_off);
set(handles.artnx,'enable',on_off);
set(handles.artulx,'enable',on_off);
set(handles.artllx,'enable',on_off);
set(handles.artjx,'enable',on_off);
set(handles.artlcx,'enable',on_off);
set(handles.artrcx,'enable',on_off);
set(handles.artex,'enable',on_off);

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
set(handles.bny,'enable',on_off);
set(handles.buly,'enable',on_off);
set(handles.blly,'enable',on_off);
set(handles.bjy,'enable',on_off);
set(handles.blcy,'enable',on_off);
set(handles.brcy,'enable',on_off);
set(handles.brcy,'enable',on_off);
set(handles.bey,'enable',on_off);


set(handles.maximizetdy,'enable',on_off);
set(handles.maximizetby,'enable',on_off);
set(handles.maximizetty,'enable',on_off);
set(handles.maximizeny,'enable',on_off);
set(handles.maximizeuly,'enable',on_off);
set(handles.maximizelly,'enable',on_off);
set(handles.maximizejay,'enable',on_off);
set(handles.maximizelcy,'enable',on_off);
set(handles.maximizercy,'enable',on_off);
set(handles.maximizeey,'enable',on_off);

set(handles.arttdy,'enable',on_off);
set(handles.arttby,'enable',on_off);
set(handles.arttty,'enable',on_off);
set(handles.artny,'enable',on_off);
set(handles.artuly,'enable',on_off);
set(handles.artlly,'enable',on_off);
set(handles.artjy,'enable',on_off);
set(handles.artlcy,'enable',on_off);
set(handles.artrcy,'enable',on_off);
set(handles.artey,'enable',on_off);

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
set(handles.bnz,'enable',on_off);
set(handles.bulz,'enable',on_off);
set(handles.bllz,'enable',on_off);
set(handles.bjz,'enable',on_off);
set(handles.blcz,'enable',on_off);
set(handles.brcz,'enable',on_off);
set(handles.brcz,'enable',on_off);
set(handles.bez,'enable',on_off);


set(handles.maximizetdz,'enable',on_off);
set(handles.maximizetbz,'enable',on_off);
set(handles.maximizettz,'enable',on_off);
set(handles.maximizenz,'enable',on_off);
set(handles.maximizeulz,'enable',on_off);
set(handles.maximizellz,'enable',on_off);
set(handles.maximizejaz,'enable',on_off);
set(handles.maximizelcz,'enable',on_off);
set(handles.maximizercz,'enable',on_off);
set(handles.maximizeez,'enable',on_off);

set(handles.arttdz,'enable',on_off);
set(handles.arttbz,'enable',on_off);
set(handles.artttz,'enable',on_off);
set(handles.artnz,'enable',on_off);
set(handles.artulz,'enable',on_off);
set(handles.artllz,'enable',on_off);
set(handles.artjz,'enable',on_off);
set(handles.artlcz,'enable',on_off);
set(handles.artrcz,'enable',on_off);
set(handles.artez,'enable',on_off);

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
handles.currenttt=handles.tt;
handles.currentbc=handles.bc;
handles.currenttb=handles.tb;
handles.currenttd=handles.td;
handles.lim=[handles.t(1) handles.t(end)];
handles.limscale='auto';
handles.rucbx='bbb';
handles.rucby='bbb';
handles.rucbz='bbb';
handles.rucbbc='bbb';
handles.rucbtt='bbb';
handles.rucbtb='bbb';
handles.rucbtd='bbb';

handles.sel_posorvel='pos';
handles.RFselectionMode=0;

% clear signals to analyze
handles.sig1 = [];
handles.sig2 = [];

set(handles.sig_ana_1,'string','');
set(handles.sig_ana_2,'string','');

openall(handles)
pushbuttonxonX_rh(handles)
pushbuttonxonY_rh(handles)
pushbuttonxonZ_rh(handles)

set(handles.figure1,'Color',[0.941,0.941,0.941]);
set([handles.text17,handles.text16,handles.text30,handles.text12,...
    handles.text13,handles.text14,handles.text45,handles.uipanel6,...
    handles.text_RF_selection,handles.sig_ana_3,handles.sig_ana_4],...
    'BackgroundColor',[0.941,0.941,0.941]);

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
signame=[handles.sel_posorvel ' td x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,1);
maximazedfigure2(hObject, eventdata, handles, cdata, signame);

% --- Executes on button press in maximizetbx.
function maximizetbx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettx.
function maximizettx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenx.
function maximizenx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeulx.
function maximizeulx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeulx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,6);
maximazedfigure2(hObject, eventdata, handles, cdata,signame);

% --- Executes on button press in maximizellx.
function maximizellx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejax.
function maximizejax_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcx.
function maximizelcx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercx.
function maximizercx_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeex.
function maximizeex_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);





% --- Executes on button press in maximizetdy.
function maximizetdy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' td y ' handles.rucby(1)];
cdata=handles.currentdatay(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in maximizetby.
function maximizetby_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb y ' handles.rucby(1)];
cdata=handles.currentdatay(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in maximizetty.
function maximizetty_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt y ' handles.rucby(1)];
cdata=handles.currentdatay(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeny.
function maximizeny_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose y ' handles.rucby(1)];
cdata=handles.currentdatay(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeuly.
function maximizeuly_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeuly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul y ' handles.rucby(1)];
cdata=handles.currentdatay(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelly.
function maximizelly_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll y ' handles.rucby(1)];
cdata=handles.currentdatay(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejay.
function maximizejay_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw y ' handles.rucby(1)];
cdata=handles.currentdatay(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcy.
function maximizelcy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercy.
function maximizercy_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeey.
function maximizeey_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le y ' handles.rucby(1)];
cdata=handles.currentdatay(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);



% --- Executes on button press in maximizetdz.
function maximizetdz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' td z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,1);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetbz.
function maximizetbz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,2);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizettz.
function maximizettz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizettz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,3);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizenz.
function maximizenz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizenz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,5);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeulz.
function maximizeulz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeulz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,6);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizellz.
function maximizellz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizellz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,7);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizejaz.
function maximizejaz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizejaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,8);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizelcz.
function maximizelcz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizelcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,9);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizercz.
function maximizercz_Callback(hObject, eventdata, handles)
% hObject    handle to maximizercz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,10);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizeez.
function maximizeez_Callback(hObject, eventdata, handles)
% hObject    handle to maximizeez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,11);
maximazedfigure2(hObject, eventdata, handles,cdata,signame);




% --- Executes on button press in maximizebc.
function maximizebc_Callback(hObject, eventdata, handles)
% hObject    handle to maximizebc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' BC' handles.rucbbc(1)];
cdata=handles.bc;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetb.
function maximizetb_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TB' handles.rucbtb(1)];
cdata=handles.tb;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizett.
function maximizett_Callback(hObject, eventdata, handles)
% hObject    handle to maximizett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TT'  handles.rucbtt(1)];
cdata=handles.tt;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizetd.
function maximizetd_Callback(hObject, eventdata, handles)
% hObject    handle to maximizetd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TD' handles.rucbtd(1)];
cdata=handles.td;
maximazedfigure2(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in maximizerf.
function maximizerf_Callback(hObject, eventdata, handles)
% hObject    handle to maximizerf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[get(handles.info_nd,'string') ' RF',get(handles.sig_ana_3,'string'),' ',get(handles.sig_ana_4,'string') ];
cdata=zeros(size(handles.t));
if(~isempty(handles.cRF))
cdata(handles.nf:handles.nl)=handles.cRF;
end
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
ylabel('mm')
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
signame=[handles.sel_posorvel ' td x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,1);
subplotfigure(hObject, eventdata, handles, cdata, signame);

% --- Executes on button press in arttbx.
function arttbx_Callback(hObject, eventdata, handles)
% hObject    handle to arttbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artttx.
function artttx_Callback(hObject, eventdata, handles)
% hObject    handle to artttx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnx.
function artnx_Callback(hObject, eventdata, handles)
% hObject    handle to artnx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artulx.
function artulx_Callback(hObject, eventdata, handles)
% hObject    handle to artulx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,6);
subplotfigure(hObject, eventdata, handles, cdata,signame);

% --- Executes on button press in artllx.
function artllx_Callback(hObject, eventdata, handles)
% hObject    handle to artllx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjax.
function artjax_Callback(hObject, eventdata, handles)
% hObject    handle to artjax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcx.
function artlcx_Callback(hObject, eventdata, handles)
% hObject    handle to artlcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcx.
function artrcx_Callback(hObject, eventdata, handles)
% hObject    handle to artrcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artex.
function artex_Callback(hObject, eventdata, handles)
% hObject    handle to artex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le x ' handles.rucbx(1)];
cdata=handles.currentdatax(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);





% --- Executes on button press in arttdy.
function arttdy_Callback(hObject, eventdata, handles)
% hObject    handle to arttdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' td y ' handles.rucby(1)];
cdata=handles.currentdatay(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in arttby.
function arttby_Callback(hObject, eventdata, handles)
% hObject    handle to arttby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb y ' handles.rucby(1)];
cdata=handles.currentdatay(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);


% --- Executes on button press in arttty.
function arttty_Callback(hObject, eventdata, handles)
% hObject    handle to arttty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt y ' handles.rucby(1)];
cdata=handles.currentdatay(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artny.
function artny_Callback(hObject, eventdata, handles)
% hObject    handle to artny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose y ' handles.rucby(1)];
cdata=handles.currentdatay(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artuly.
function artuly_Callback(hObject, eventdata, handles)
% hObject    handle to artuly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul y ' handles.rucby(1)];
cdata=handles.currentdatay(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlly.
function artlly_Callback(hObject, eventdata, handles)
% hObject    handle to artlly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll y ' handles.rucby(1)];
cdata=handles.currentdatay(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjay.
function artjay_Callback(hObject, eventdata, handles)
% hObject    handle to artjay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw y ' handles.rucby(1)];
cdata=handles.currentdatay(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcy.
function artlcy_Callback(hObject, eventdata, handles)
% hObject    handle to artlcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcy.
function artrcy_Callback(hObject, eventdata, handles)
% hObject    handle to artrcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc y ' handles.rucby(1)];
cdata=handles.currentdatay(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artey.
function artey_Callback(hObject, eventdata, handles)
% hObject    handle to artey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le y ' handles.rucby(1)];
cdata=handles.currentdatay(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);



% --- Executes on button press in arttdz.
function arttdz_Callback(hObject, eventdata, handles)
% hObject    handle to arttdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' td z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,1);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttbz.
function arttbz_Callback(hObject, eventdata, handles)
% hObject    handle to arttbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tb z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,2);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artttz.
function artttz_Callback(hObject, eventdata, handles)
% hObject    handle to artttz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' tt z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,3);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artnz.
function artnz_Callback(hObject, eventdata, handles)
% hObject    handle to artnz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' nose z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,5);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artulz.
function artulz_Callback(hObject, eventdata, handles)
% hObject    handle to artulz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ul z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,6);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artllz.
function artllz_Callback(hObject, eventdata, handles)
% hObject    handle to artllz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' ll z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,7);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artjaz.
function artjaz_Callback(hObject, eventdata, handles)
% hObject    handle to artjaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' jaw z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,8);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artlcz.
function artlcz_Callback(hObject, eventdata, handles)
% hObject    handle to artlcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' lc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,9);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrcz.
function artrcz_Callback(hObject, eventdata, handles)
% hObject    handle to artrcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' rc z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,10);
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artez.
function artez_Callback(hObject, eventdata, handles)
% hObject    handle to artez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' le z ' handles.rucbz(1)];
cdata=handles.currentdataz(:,11);
subplotfigure(hObject, eventdata, handles,cdata,signame);




% --- Executes on button press in artbc.
function artbc_Callback(hObject, eventdata, handles)
% hObject    handle to artbc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' BC', handles.rucbbc(1)];
cdata=handles.bc;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttb.
function arttb_Callback(hObject, eventdata, handles)
% hObject    handle to arttb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TB', handles.rucbtb(1)];
cdata=handles.tb;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttt.
function arttt_Callback(hObject, eventdata, handles)
% hObject    handle to arttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TT', handles.rucbtt(1)];
cdata=handles.tt;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in arttd.
function arttd_Callback(hObject, eventdata, handles)
% hObject    handle to arttd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[handles.sel_posorvel ' TD', handles.rucbtd(1)];
cdata=handles.td;
subplotfigure(hObject, eventdata, handles,cdata,signame);

% --- Executes on button press in artrf.
function artrf_Callback(hObject, eventdata, handles)
% hObject    handle to artrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signame=[get(handles.info_nd,'string') ' RF',get(handles.sig_ana_3,'string'),' ',get(handles.sig_ana_4,'string') ];
cdata=zeros(size(handles.t));
if(~isempty(handles.cRF))
cdata(handles.nf:handles.nl)=handles.cRF;
end
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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_POSITION.
function pushbutton_POSITION_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_POSITION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sel_posorvel='pos';

handles.xpv = handles.x3d;
handles.ypv = handles.y3d;
handles.zpv = handles.z3d;
handles.xpvc = handles.x3dc;
handles.ypvc = handles.y3dc;
handles.zpvc = handles.z3dc;

if(strcmp(handles.rucbbc,'bbb') );
    handles.currentbc = handles.bc;
    handles.currenttd = handles.td;
    handles.currenttt = handles.tt;
    handles.currenttb = handles.tb;  
elseif(strcmp(handles.rucbbc,'lmm'));
    handles.currentbc = handles.bc_lp;
    handles.currenttd = handles.td_lp;
    handles.currenttt = handles.tt_lp;
    handles.currenttb = handles.tb_lp;  
end

if(handles.rucbx(1)=='r');
    handles.currentdatax= handles.x3d_raw;
elseif(handles.rucbx(1)=='l');
    handles.currentdatax= handles.x3d_lp;
elseif(handles.rucbx(1)=='b');
    handles.currentdatax= handles.x3d;
elseif(handles.rucbx(1)=='c');
    handles.currentdatax= handles.x3dc;
end

if(handles.rucby(1)=='r');
    handles.currentdatay= handles.y3d_raw;
elseif(handles.rucby(1)=='l');
    handles.currentdatay= handles.y3d_lp;
elseif(handles.rucby(1)=='b');
    handles.currentdatay= handles.y3d;
elseif(handles.rucby(1)=='c');
    handles.currentdatay= handles.y3dc;
end

if(handles.rucbz(1)=='r');
    handles.currentdataz= handles.z3d_raw;
elseif(handles.rucbz(1)=='l');
    handles.currentdataz= handles.z3d_lp;
elseif(handles.rucbz(1)=='b');
    handles.currentdataz= handles.z3d;
elseif(handles.rucbz(1)=='c');
    handles.currentdataz= handles.z3dc;
end

set(handles.figure1,'Color',[0.941,0.941,0.941]);
set([handles.text17,handles.text16,handles.text30,handles.text12,...
    handles.text13,handles.text14,handles.text45,handles.uipanel6,...
    handles.text_RF_selection,handles.sig_ana_3,handles.sig_ana_4,...
    handles.info_nd],...
    'BackgroundColor',[0.941,0.941,0.941]);

currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplottt(handles)
currentplotbc(handles)
currentplottd(handles)
currentplottb(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbuttonVELOCITY.
function pushbutton_VELOCITY_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VELOCITY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.sel_posorvel='vel';

if( strcmp(handles.rucbbc,'bbb') );
    handles.currentbc = handles.velbc;
    handles.currenttd = handles.veltd;
    handles.currenttt = handles.veltt;
    handles.currenttb = handles.veltb;  
elseif(strcmp(handles.rucbbc,'lmm'));
    handles.currentbc = handles.velbc_lp;
    handles.currenttd = handles.veltd_lp;
    handles.currenttt = handles.veltt_lp;
    handles.currenttb = handles.veltb_lp;  
end

handles.xpv = handles.velx3d;
handles.ypv = handles.vely3d;
handles.zpv = handles.velz3d;
handles.xpvc = handles.velx3dc;
handles.ypvc = handles.vely3dc;
handles.zpvc = handles.velz3dc;


if(handles.rucbx(1)=='r');
    handles.currentdatax= handles.velx3d_raw;
elseif(handles.rucbx(1)=='l');
    handles.currentdatax= handles.velx3d_lp;
elseif(handles.rucbx(1)=='b');
    handles.currentdatax= handles.velx3d;
elseif(handles.rucbx(1)=='c');
    handles.currentdatax= handles.velx3dc;
end

if(handles.rucby(1)=='r');
    handles.currentdatay= handles.vely3d_raw;
elseif(handles.rucby(1)=='l');
    handles.currentdatay= handles.vely3d_lp;
elseif(handles.rucby(1)=='b');
    handles.currentdatay= handles.vely3d;
elseif(handles.rucby(1)=='c');
    handles.currentdatay= handles.vely3dc;
end

if(handles.rucbz(1)=='r');
    handles.currentdataz= handles.velz3d_raw;
elseif(handles.rucbz(1)=='l');
    handles.currentdataz= handles.velz3d_lp;
elseif(handles.rucbz(1)=='b');
    handles.currentdataz= handles.velz3d;
elseif(handles.rucbz(1)=='c');
    handles.currentdataz= handles.velz3dc;
end
 
set(handles.figure1,'Color',[0.75,0.867,0.75]);
set([handles.text17,handles.text16,handles.text30,handles.text12,...
    handles.text13,handles.text14,handles.text45,handles.uipanel6,...
    handles.text_RF_selection,handles.sig_ana_3,handles.sig_ana_4,...
    handles.info_nd],...
    'BackgroundColor',[0.75,0.867,0.75]);


currentplotx(handles)
currentploty(handles)
currentplotz(handles)
currentplottt(handles)
currentplottb(handles)
currentplottd(handles)
currentplotbc(handles)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in CoilMottion.
function CoilMottion_Callback(hObject, eventdata, handles)
% hObject    handle to CoilMottion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rate=200;
rateac=16000;
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



% --- Executes on button press in pushbutton_select_RFpair.
function pushbutton_select_RFpair_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_RFpair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sig3=[];
handles.sig4=[];
set([handles.sig_ana_3,handles.sig_ana_4],'string',[])
handles.RFselectionMode=1;
set(handles.text_RF_selection, 'string', 'use [x] to select 1st signal')

% Update handles structure
guidata(hObject, handles);


%% Analysis push button
% --- Executes on button press in dst1_hurst.
function dst1_hurst_Callback(hObject, eventdata, handles)
% hObject    handle to dst1_hurst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sig1=[];
handles.sig2=[];
set(handles.text_selectmethod,'string','Hurst')
set(handles.sig_ana_1,'visible','on','string',' ')
set(handles.sig_ana_2,'visible','off','string',' ')
handles.dst=1;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in dst2_rqa.
function dst2_rqa_Callback(hObject, eventdata, handles)
% hObject    handle to dst2_rqa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sig1=[];
handles.sig2=[];
set(handles.text_selectmethod,'string','RQA')
set(handles.sig_ana_1,'visible','on','string',' ')
set(handles.sig_ana_2,'visible','off','string',' ')
handles.dst=2;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in dst3_crqa.
function dst3_crqa_Callback(hObject, eventdata, handles)
% hObject    handle to dst3_crqa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sig1=[];
handles.sig2=[];
set(handles.text_selectmethod,'string','CRQA')
set(handles.sig_ana_1,'visible','on','string',' ')
set(handles.sig_ana_2,'visible','on','string',' ')
handles.dst=3;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in dst4_entropy.
function dst4_entropy_Callback(hObject, eventdata, handles)
% hObject    handle to dst4_entropy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sig1=[];
handles.sig2=[];
set(handles.text_selectmethod,'string','Entroy')
set(handles.sig_ana_1,'visible','on','string',' ')
%set(handles.sig_ana_2,'visible','on','string',' ')
handles.dst=4;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton_NRF.
function pushbutton_NRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_NRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.info_nd,'string','n')
handles.cRF=handles.RF;

if(~isempty(handles.cRF))
plot(handles.rf_axes,handles.t(handles.nf:handles.nl),handles.cRF)
set(handles.rf_axes,'XLim',handles.lim,'fontsize',8);
xlabel(handles.rf_axes,'time (s)');
ylabel(handles.rf_axes,'rad');
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_DRF.
function pushbutton_DRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_DRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.info_nd,'string','d')
handles.cRF=handles.dRF;

if(~isempty(handles.cRF))
plot(handles.rf_axes,handles.t(handles.nf:handles.nl),handles.cRF)
set(handles.rf_axes,'XLim',handles.lim,'fontsize',8);
xlabel(handles.rf_axes,'time (s)');
ylabel(handles.rf_axes,'drad');
end

% Update handles structure
guidata(hObject, handles);

