function varargout = EGUANA(varargin)
% EGUANA M-file for EGUANA.fig
%      EGUANA, by itself, creates a new EGUANA or raises the existing
%      singleton*.
%
%      H = EGUANA returns the handle to a new EGUANA or the handle to
%      the existing singleton*.
%
%      EGUANA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EGUANA.M with the given input arguments.
%
%      EGUANA('Property','Value',...) creates a new EGUANA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EGUANA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EGUANA

% Last Modified by GUIDE v2.5 05-Aug-2010 16:30:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EGUANA_OpeningFcn, ...
                   'gui_OutputFcn',  @EGUANA_OutputFcn, ...
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


% --- Executes just before EGUANA is made visible.
function EGUANA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EGUANA (see VARARGIN)

%surf(handles.current_data);

% s = SplashScreen('EGUANA','example_splash.png');
% pause(5);
% delete(s);

set(handles.filter_type,'enable','off');
set(handles.data_style,'enable','off');
set(handles.data_style,'string','No Data');

% Choose default command line output for EGUANA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EGUANA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EGUANA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% INPUT 2D/3D DATA 

% --- Executes on button press in input_2d.
function input_2d_Callback(hObject, eventdata, handles)
% hObject    handle to input_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ac = [];
emma2dinput_rh;

    handles.x2d_raw = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10];
    handles.y2d_raw = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10];
    handles.x2d_rawc = [x1c, x2c, x3c, x4, x5, x6, x7c, x8, x9, x10];
    handles.y2d_rawc = [y1c, y2c, y3c, y4, y5, y6, y7c, y8, y9, y10];

    clear x* y*;
    handles.bc2d = BC;
    handles.td2d = TD;
    handles.tt2d = TT;
    handles.tb2d = TB;
    handles.ac2d = ac;
    handles.tri2d = tri;
    handles.sess2d = sess;
    handles.sub2d = sub;
    handles.respath2d = respath;
    disp('Session:');
    disp(handles.sess2d);
    disp('Subject:');
    disp(handles.sub2d);
    % I had to downsample these for the PDIST function to not run out...
    % of memory when it is used later in the crqalog20 function

    handles.filtered = 0;
    set(handles.filter_type,'String','Filter Type');
    set(handles.data_style,'String','2D');

    set(handles.speech_filt_3d,'enable','off');
    set(handles.swallow_filt_3d,'enable','off');
    set(handles.speech_filt_2d,'enable','on');
    set(handles.swallow_filt_2d,'enable','on');
%end
    
guidata(hObject,handles);


% --- Executes on button press in input_3d.
function input_3d_Callback(hObject, eventdata, handles)
% hObject    handle to input_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ac = [];
emma3dinput_jaw_rh;

%if ~isempty(ac)
     
    handles.lpValue = str2num(cell2mat(lpValue));
    handles.x3d_raw = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12];
    handles.y3d_raw = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12];
    handles.z3d_raw = [z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12];
    
    handles.phi_rawi = [phi1,phi2,phi3,phi4,phi5,phi6,...
                       phi7,phi8,phi9,phi10,phi11,phi12];
    handles.theta_rawi = [ theta1,theta2,theta3,theta4,theta5,theta6,...
                          theta7,theta8,theta9,theta10,theta11,theta12];

                      
if posOK == 1
    handles.x3dpos_raw = [x1pos, x2pos, x3pos, x4pos, x5pos, x6pos, x7pos, x8pos, x9pos, x10pos, x11pos, x12pos];
    handles.y3dpos_raw = [y1pos, y2pos, y3pos, y4pos, y5pos, y6pos, y7pos, y8pos, y9pos, y10pos, y11pos, y12pos];
    handles.z3dpos_raw = [z1pos, z2pos, z3pos, z4pos, z5pos, z6pos, z7pos, z8pos, z9pos, z10pos, z11pos, z12pos];
    
    handles.phipos_raw = [phi1pos,phi2pos,phi3pos,phi4pos,phi5pos,phi6pos,...
                       phi7pos,phi8pos,phi9pos,phi10pos,phi11pos,phi12pos];
    handles.thetapos_raw = [ theta1pos,theta2pos,theta3pos,theta4pos,theta5pos,theta6pos,...
                          theta7pos,theta8pos,theta9pos,theta10pos,theta11pos,theta12pos];
else
    siz=size(handles.x3d_raw);
    handles.x3dpos_raw = zeros(siz);
    handles.y3dpos_raw = zeros(siz);
    handles.z3dpos_raw = zeros(siz);
    handles.phipos_raw = zeros(siz);
    handles.thetapos_raw = zeros(siz);
end
      
%     handles.x3d_rawc = [x1c, x2c, x3c, x4, x5, x6, x7c, x8, x9, x10, x11, x12];
%     handles.y3d_rawc = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12];
%     handles.z3d_rawc = [z1c, z2c, z3c, z4, z5, z6, z7c, z8, z9, z10, z11, z12];
   
    
    clear x* y* z*;
%     handles.bc3d = BC;
%     handles.td3d = TD;
%     handles.tt3d = TT;
%     handles.tb3d = TB;    
    handles.ac3d = ac;
    handles.Fs3d = Fs;
    handles.srate3d = srate;
    handles.tri3d = tri;
    handles.sess3d = sess;
    handles.sub3d = sub;
    handles.respath3d = respath;
    handles.posOK=posOK;
    handles.path1=path1;
    disp('Session:');
    disp(handles.sess3d);
    disp('Subject:');
    disp(handles.sub3d);
    disp('Results Save Directory:');
    disp(handles.respath3d);
    
    handles.filtered = 0;
    
    set(handles.filter_type,'String','Filter Type');
    set(handles.data_style,'String','3D');

    set(handles.speech_filt_3d,'enable','on');
    set(handles.swallow_filt_3d,'enable','on');
    
%end
guidata(hObject,handles);

function data_style_Callback(hObject, eventdata, handles)
% hObject    handle to data_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_style as text
%        str2double(get(hObject,'String')) returns contents of data_style as a double


% --- Executes during object creation, after setting all properties.
function data_style_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Filters 

% --- Executes on button press in speech_filt_2d.
function speech_filt_2d_Callback(hObject, eventdata, handles)
% hObject    handle to speech_filt_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.x2d=zeros(size(handles.x2d_raw));
handles.y2d=zeros(size(handles.x2d_raw));
handles.x2dc=zeros(size(handles.x2d_raw));
handles.y2dc=zeros(size(handles.x2d_raw));

% handles.x2dspd = [];
% handles.y2dspd = [];
% handles.x2dspdc = [];
% handles.y2dspdc = [];


if handles.filtered == 1
    set(handles.filter_type,'string','Already filtered');
else
    set(handles.filter_type,'string','2D Speech');
    rate = 200;
    h = waitbar(0,'Filtering...');
    c = size(handles.x2d_raw,2);
    for k = size(handles.x2d_raw,2):-1:1
        
        waitbar(1-(k-1)/c,h);
        
       handles.x2d(:,k) = filter_array_rhv2(handles.x2d_raw(:,k),rate, handles.lpValue,0.5);
       handles.y2d(:,k) = filter_array_rhv2(handles.y2d_raw(:,k),rate, handles.lpValue,0.5);
       handles.x2dc(:,k) = filter_array_rhv2(handles.x2d_rawc(:,k),rate, handles.lpValue,0.5);
       handles.y2dc(:,k) = filter_array_rhv2(handles.y2d_rawc(:,k),rate, handles.lpValue,0.5);
    end
    close(h)
    
    handles.filtered = 1;
    handles.bc2d = filter_array_rhv2(handles.bc2d,rate, handles.lpValue,0.5);
    handles.tt2d = filter_array_rhv2(handles.tt2d,rate, handles.lpValue,0.5);
    handles.td2d = filter_array_rhv2(handles.td2d,rate, handles.lpValue,0.5);
    handles.tb2d = filter_array_rhv2(handles.tb2d,rate, handles.lpValue,0.5);
    
%     %velocities
%     for k = 10:-1:1
%         handles.x2dspd(:,k) = diff(handles.x2d(:,k))/(1/rate);
%         handles.y2dspd(:,k) = diff(handles.y2d(:,k))/(1/rate);
%         handles.x2dspdc(:,k) = diff(handles.x2dc(:,k))/(1/rate);
%         handles.y2dspdc(:,k) = diff(handles.y2dc(:,k))/(1/rate);
%     end

    set(handles.plot_2D_k,'enable','on');
    set(handles.plot_2D_dst,'enable','on');
    set(handles.plot_2D_dp,'enable','on');
    guidata(hObject,handles);
end

% --- Executes on button press in swallow_filt_2d.
function swallow_filt_2d_Callback(hObject, eventdata, handles)
% hObject    handle to swallow_filt_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.x2d=zeros(size(handles.x2d_raw));
handles.y2d=zeros(size(handles.x2d_raw));
handles.x2dc=zeros(size(handles.x2d_raw));
handles.y2dc=zeros(size(handles.x2d_raw));

% handles.x2dspd = [];
% handles.y2dspd = [];
% handles.x2dspdc = [];
% handles.y2dspdc = [];

if handles.filtered == 1
    set(handles.filter_type,'string','Already filtered');
else
    set(handles.filter_type,'string','2D Swallowing');
    rate = 400;
    h = waitbar(0,'Filtering...');
    c = size(handles.x2d_raw,2);
    for k = size(handles.x2d_raw,2):-1:1
        
        waitbar(1-(k-1)/c,h);
        
       handles.x2d(:,k) = filter_array_rhv2(handles.x2d_raw(:,k),rate, handles.lpValue,0.1);
       handles.y2d(:,k) = filter_array_rhv2(handles.y2d_raw(:,k),rate, handles.lpValue,0.1);
       handles.x2dc(:,k) = filter_array_rhv2(handles.x2d_rawc(:,k),rate, handles.lpValue,0.1);
       handles.y2dc(:,k) = filter_array_rhv2(handles.y2d_rawc(:,k),rate, handles.lpValue,0.1);
    end
    close(h)
    handles.filtered = 1;
    handles.bc2d = filter_array_rhv2(handles.bc2d,rate, handles.lpValue,0.1);
    handles.tt2d = filter_array_rhv2(handles.tt2d,rate, handles.lpValue,0.1);
    handles.td2d = filter_array_rhv2(handles.td2d,rate, handles.lpValue,0.1);
    handles.tb2d = filter_array_rhv2(handles.tb2d,rate, handles.lpValue,0.1);
    
    %velocities
%     for k = 10:-1:1
%         handles.x2dspd(:,k) = diff(handles.x2d(:,k))/(1/rate);
%         handles.y2dspd(:,k) = diff(handles.y2d(:,k))/(1/rate);
%         handles.x2dspdc(:,k) = diff(handles.x2dc(:,k))/(1/rate);
%         handles.y2dspdc(:,k) = diff(handles.y2dc(:,k))/(1/rate);
%     end
%    
    set(handles.plot_2D_k,'enable','on');
    set(handles.plot_2D_dst,'enable','on');
    set(handles.plot_2D_dp,'enable','on');
    
    guidata(hObject,handles);
end

% --- Executes on button press in speech_filt_3d.
function speech_filt_3d_Callback(hObject, eventdata, handles)
% hObject    handle to speech_filt_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

posOK=handles.posOK;

siz=size(handles.x3d_raw);

%%%%EDITED
handles.x3dpos_raw = handles.x3dpos_raw(1:siz(1),1:siz(2));
handles.y3dpos_raw = handles.y3dpos_raw(1:siz(1),1:siz(2));
handles.z3dpos_raw = handles.z3dpos_raw(1:siz(1),1:siz(2));
handles.phipos_raw = handles.phipos_raw(1:siz(1),1:siz(2));
handles.thetapos_raw = handles.thetapos_raw(1:siz(1),1:siz(2));

handles.x3d=zeros(siz);
handles.y3d=zeros(siz);
handles.z3d=zeros(siz);
handles.x3d_lp=zeros(siz);%
handles.y3d_lp=zeros(siz);%
handles.z3d_lp=zeros(siz);%
handles.x3dc=zeros(siz);%
handles.y3dc=zeros(siz);%
handles.z3dc=zeros(siz);%
handles.x3dc_lp=zeros(siz);%
handles.y3dc_lp=zeros(siz);%
handles.z3dc_lp=zeros(siz);%
handles.phi=zeros(siz);
handles.theta=zeros(siz);
handles.phi_lp=zeros(siz);%
handles.theta_lp=zeros(siz);%

handles.bc3d=zeros(siz(1),1);
handles.tt3d=zeros(siz(1),1);
handles.tb3d=zeros(siz(1),1);
handles.td3d=zeros(siz(1),1);
handles.bc3d_lp=zeros(siz(1),1);
handles.tt3d_lp=zeros(siz(1),1);
handles.tb3d_lp=zeros(siz(1),1);
handles.td3d_lp=zeros(siz(1),1);


handles.phi_raw = zeros(siz);%
handles.theta_raw = zeros(siz);%

handles.x3dpos=zeros(siz);%
handles.y3dpos=zeros(siz);%
handles.z3dpos=zeros(siz);%
handles.phipos=zeros(siz);%
handles.thetapos=zeros(siz);%

srate = handles.srate3d;

%variables to delete : rawi, pos_raw


% handles.x3dspd = zeros(size(handles.x3d_raw));
% handles.y3dspd = zeros(size(handles.x3d_raw));
% handles.z3dspd = zeros(size(handles.x3d_raw));
% handles.x3dspdc = zeros(size(handles.x3d_raw));
% handles.y3dspdc = zeros(size(handles.x3d_raw));
% handles.z3dspdc = zeros(size(handles.x3d_raw));

if handles.filtered == 1
    set(handles.filter_type,'string','Already filtered');
else
    
    % LOW FILTER
    %h = waitbar(0,'Filtering...');
    for k = 1:siz(2)
        %   waitbar(k/siz(2),h);
        
        handles.x3d_lp(:,k) = filter_array_rhv2(handles.x3d_raw(:,k),srate, handles.lpValue,0);
        handles.y3d_lp(:,k) = filter_array_rhv2(handles.y3d_raw(:,k),srate, handles.lpValue,0);
        handles.z3d_lp(:,k) = filter_array_rhv2(handles.z3d_raw(:,k),srate, handles.lpValue,0);
        
        handles.phi_raw(:,k)=unwrap(handles.phi_rawi(:,k)*pi/180);
        handles.theta_raw(:,k)=unwrap(handles.theta_rawi(:,k)*pi/180);
        handles.phi_lp(:,k) = filter_array_rhv2(handles.phi_raw(:,k),srate, handles.lpValue,0);
        handles.theta_lp(:,k) = filter_array_rhv2(handles.theta_raw(:,k),srate, handles.lpValue,0);
        
        
        if(posOK==1)
            handles.x3dpos(:,k) = filter_array_rhv2(handles.x3dpos_raw(:,k),srate, handles.lpValue,0);
            handles.y3dpos(:,k) = filter_array_rhv2(handles.y3dpos_raw(:,k),srate, handles.lpValue,0);
            handles.z3dpos(:,k) = filter_array_rhv2(handles.z3dpos_raw(:,k),srate, handles.lpValue,0);
            
            handles.phipos(:,k)=unwrap(handles.phipos_raw(:,k)*pi/180);
            handles.thetapos(:,k)=unwrap(handles.thetapos_raw(:,k)*pi/180);
            handles.phipos(:,k) = filter_array_rhv2(handles.phipos(:,k),srate, handles.lpValue,0);
            handles.thetapos(:,k) = filter_array_rhv2(handles.thetapos(:,k),srate, handles.lpValue,0);
        end
        
        %         [handles.x3d(:,k),handles.x3d_lp(:,k)] = filter_array_rhv3(handles.x3d_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.y3d(:,k),handles.y3d_lp(:,k)] = filter_array_rhv3(handles.y3d_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.z3d(:,k),handles.z3d_lp(:,k)] = filter_array_rhv3(handles.z3d_raw(:,k),srate, handles.lpValue,0.1);
        %         handles.x3dc(:,k) = filter_array_rhv2(handles.x3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         handles.y3dc(:,k) = filter_array_rhv2(handles.y3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         handles.z3dc(:,k) = filter_array_rhv2(handles.z3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         [handles.phi(:,k),handles.phi_lp(:,k)] = filter_array_rhv3(handles.phi_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.theta(:,k),handles.theta_lp(:,k)] = filter_array_rhv3(handles.theta_raw(:,k),srate, handles.lpValue,0.1);
    end
    %close(h);
    %     [handles.bc3d,handles.bc3d_lp] = filter_array_rhv3(handles.bc3d, srate, handles.lpValue,0.1);
    %     [handles.tt3d,handles.tt3d_lp] = filter_array_rhv3(handles.tt3d, srate, handles.lpValue,0.1);
    %     [handles.td3d,handles.td3d_lp] = filter_array_rhv3(handles.td3d, srate, handles.lpValue,0.1);
    %     [handles.tb3d,handles.tb3d_lp] = filter_array_rhv3(handles.tb3d, srate, handles.lpValue,0.1);
    
    
    %     % velocities
    %     for k = 1:12
    %         handles.x3dspd(:,k) = diff(handles.x3d(:,k))/(1/srate);
    %         handles.y3dspd(:,k) = diff(handles.y3d(:,k))/(1/srate);
    %         handles.z3dspd(:,k) = diff(handles.z3d(:,k))/(1/srate);
    %         handles.x3dspdc(:,k) = diff(handles.x3dc(:,k))/(1/srate);
    %         handles.y3dspdc(:,k) = diff(handles.y3dc(:,k))/(1/srate);
    %         handles.z3dspdc(:,k) = diff(handles.z3dc(:,k))/(1/srate);
    %     end
    %
    
    guidata(hObject,handles);
    
    %OPEN GUI TO SELECT JAW AND HEAD CORRECTION METHODS
    [selheadc,seljawc,bite_trial,rest_trial,headcoils,jawcoils,sel,hfig]=...
        CorrectionGUI_HJ(handles);  % August 6/08/11 Rafael Henriques Copy the new version of CorrectionGUI_HJ
    
     
   bite_trial= num2str(bite_trial);
   rest_trial= num2str(rest_trial);
   
    
    %continue correction if it was been selected the methods of head and jaw correction
    if(sel)
        
        close(hfig)
        handles.filtered = 1;
        
        % August 6/08/11 Rafael Henriques
        %SPECIAL case when jaw' correction method chosen is Rafael' Method and it
        % was chosen the Cristian Kroos Head correction methods
        %if(selheadc==3&&seljawc==1)
        %    msg={'JAW correction aplied to data with no head correction',...
        %        'because current head correction method do not correct angles'};
        %    
        %    questdlg(msg,'warning','OK','OK');
        %    seljawc=-1;
        %    
        %    method=questdlg('what vertion do you want to use?',...
        %        'Rafael Henriques', 'Simple Jaw C',...
        %       'Bite & Resting trials','Simple Jaw C');
        %    switch method
        %        case 'Simple Jaw C'
        %            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
        %                handles.phic_lp,handles.thetac_lp]=...
        %                JawCorrection(jawcoils,handles.x3d_lp,handles.y3d_lp,...
        %                handles.z3d_lp,handles.phi_lp,handles.theta_lp);
        %        case 'Bite & Resting trials'
        %            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,handles.phic_lp,...
        %                handles.thetac_lp]=JawCorrection(jawcoils,handles.x3d_lp,...
        %                handles.y3d_lp,handles.z3d_lp,handles.phi_lp,...
        %                handles.theta_lp,1,handles.path1,rest_trial,headcoils);
        %    end
        %    
        %end
        
        
        %August 6/08/11 Rafael Henriques adaption of lines
        %Jaw correction can be independet of Head correction so I created
        %this new local variables that saves initial lp values
        
        inicx=handles.x3d_lp;
        inicy=handles.y3d_lp;
        inicz=handles.z3d_lp;
        inicphi=handles.phi_lp;
        inictheta=handles.theta_lp;
        
        %Head correction
        if(selheadc==1)
            [handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
                handles.phi_lp,handles.theta_lp]=HeadCorrection(handles.path1,...
                bite_trial,headcoils,handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
                handles.phi_lp,handles.theta_lp);
        elseif(selheadc==2)
            handles.x3d_lp = handles.x3dpos;
            handles.y3d_lp = handles.y3dpos;
            handles.z3d_lp = handles.z3dpos;
            handles.theta_lp = handles.thetapos;
            handles.phi_lp   = handles.phipos;
        elseif(selheadc==3)
            %August 6/08/11 Rafael Henriques adaption of lines, now this
            %head correction method also corrects angular information
            [handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,handles.theta_lp,handles.phi_lp]=...
                KCcorrection(handles.path1,bite_trial,headcoils,handles.x3d_lp,...
                handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp);
           % handles.theta_lp = zeros(siz);
           % handles.phi_lp   = zeros(siz);
        end
        
        %JAW METHODS
        if(seljawc==1)
            
            method=questdlg('what vertion do you want to use?',...
                'JOANA', 'Simple Jaw C',...
                'Jaw Coil Angle C','Simple Jaw C');
            switch method
                case 'Simple Jaw C'
                    [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                        handles.phic_lp,handles.thetac_lp]=JOANA(...
                        jawcoils,inicx,inicy,inicz,inicphi,inictheta,0);
                case 'Jaw Coil Angle C'
                    [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                        handles.phic_lp,handles.thetac_lp]=JOANA(...
                        jawcoils,inicx,inicy,inicz,inicphi,inictheta,1);
            end
            
        elseif(seljawc==2)
            
            for i=1:siz(2)
                [handles.x3dc_lp(:,i),handles.z3dc_lp(:,i)]=...
                    decouple_rh(handles.x3d_lp(:,i),handles.z3d_lp(:,i),...
                    handles.x3d_lp(:,jawcoils(1)),handles.z3d_lp(:,jawcoils(1)),srate);
            end
            
            for i=1:siz(2)
                handles.y3dc_lp(:,i)=handles.y3d_lp(:,i)-handles.y3d_lp(:,jawcoils(1));
            end
            handles.phic_lp=zeros(siz);
            handles.thetac_lp=zeros(siz);
            
        elseif(seljawc==3)
            
            for i=1:siz(2)
                handles.x3dc_lp(:,i)=handles.x3d_lp(:,i)-handles.x3d_lp(:,jawcoils(1));
                handles.y3dc_lp(:,i)=handles.y3d_lp(:,i)-handles.y3d_lp(:,jawcoils(1));
                handles.z3dc_lp(:,i)=handles.z3d_lp(:,i)-handles.z3d_lp(:,jawcoils(1));
            end
            
            handles.phic_lp=zeros(siz);
            handles.thetac_lp=zeros(siz);
            
        elseif(seljawc==4)
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                method=questdlg('what vertion do you want to use?',...
        'Christian Kroos', 'Simple Jaw C',...
        'Gold Jaw C','Simple Jaw C');
    
    switch method
        case 'Simple Jaw C'
            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                handles.thetac_lp,handles.phic_lp]=KCcorrection(handles.path1,...
                rest_trial,jawcoils, inicx,inicy,inicz,...
                inicphi,inictheta);

            
        case 'Gold Jaw C'
            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                handles.thetac_lp,handles.phic_lp]=Gold(handles.path1,bite_trial,...
                headcoils,inicx,inicy,inicz,inicphi,inictheta, jawcoils);
            

    end
    
    %%%%%%%%%%%%%%%%%%%%%           
        end
        
        %GESTURES
        
        %BC = bilabial closure
        x6=handles.x3d_lp(:,6);
        y6=handles.y3d_lp(:,6);
        z6=handles.z3d_lp(:,6);
        x7=handles.x3d_lp(:,7);
        y7=handles.y3d_lp(:,7);
        z7=handles.z3d_lp(:,7);
        
        
        ges_stop = 0;
        if x6 == 0, ges_stop = 1;
        elseif y6 == 0, ges_stop = 1;
        elseif z6 == 0, ges_stop = 1;
        elseif x7 == 0, ges_stop = 1;
        elseif y7 == 0, ges_stop = 1;
        elseif z7 == 0, ges_stop = 1;
        end
        
        if ges_stop == 0
            hulpsig1=x6-x7;
            hulpsig2=y6-y7;
            hulpsigt=z6-z7;
            hulpsig3=(hulpsig1).^2;
            hulpsig4=(hulpsig2).^2;
            hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.bc3d_lp=sqrt(hulpsig5)';
        end
        
        %TD = tongue dorsum
        x1=handles.x3d_lp(:,1);
        y1=handles.y3d_lp(:,1);
        z1=handles.z3d_lp(:,1);
        x5=handles.x3d_lp(:,5);
        y5=handles.y3d_lp(:,5);
        z5=handles.z3d_lp(:,5);
        ges_stop = 0;
        if x1 == 0, ges_stop = 1;
        elseif y1 == 0, ges_stop = 1;
        elseif z1 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            hulpsig1=x1-x5;
            hulpsig2=y1-y5;
            hulpsigt=z1-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.td3d_lp=sqrt(hulpsig5)';
        end
        
        %TB = tongue body
        x2=handles.x3d_lp(:,2);
        y2=handles.y3d_lp(:,2);
        z2=handles.z3d_lp(:,2);
        
        ges_stop = 0;
        if x2 == 0, ges_stop = 1;
        elseif y2 == 0, ges_stop = 1;
        elseif z2 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            
            hulpsig1=x2-x5;% use nose position as upper limit (like ul in BC)
            hulpsig2=y2-y5;
            hulpsigt=z2-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.tb3d_lp=sqrt(hulpsig5)';
        end
        
        %TT = tongue tip (actually blade)
        x3=handles.x3d_lp(:,3);
        y3=handles.y3d_lp(:,3);
        z3=handles.z3d_lp(:,3);
        ges_stop = 0;
        if x3 == 0, ges_stop = 1;
        elseif y3 == 0, ges_stop = 1;
        elseif z3 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            
            hulpsig1=x3-x5;
            hulpsig2=y3-y5;
            hulpsigt=z3-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.tt3d_lp=sqrt(hulpsig5)';
        end
        
        
        % FILTER DATA WITH HIGH FILTER
        
        for k = 1:siz(2)
            %   waitbar(k/siz(2),h);
            
            handles.x3d(:,k) = filter_array_rhv2(handles.x3d_lp(:,k),srate,0,0.5);
            handles.y3d(:,k) = filter_array_rhv2(handles.y3d_lp(:,k),srate,0,0.5);
            handles.z3d(:,k) = filter_array_rhv2(handles.z3d_lp(:,k),srate,0,0.5);
            handles.x3dc(:,k) = filter_array_rhv2(handles.x3dc_lp(:,k),srate,0,0.5);
            handles.y3dc(:,k) = filter_array_rhv2(handles.y3dc_lp(:,k),srate,0,0.5);
            handles.z3dc(:,k) = filter_array_rhv2(handles.z3dc_lp(:,k),srate,0,0.5);
            handles.phi(:,k) = filter_array_rhv2(handles.phi_lp(:,k),srate,0,0.5);
            handles.theta(:,k) = filter_array_rhv2(handles.theta_lp(:,k),srate,0,0.5);
            
        end
        %close(h);
        
        handles.bc3d = filter_array_rhv2(handles.bc3d_lp,srate,0,0.5);
        handles.td3d = filter_array_rhv2(handles.td3d_lp,srate,0,0.5);
        handles.tb3d = filter_array_rhv2(handles.tb3d_lp,srate,0,0.5);
        handles.tt3d = filter_array_rhv2(handles.tt3d_lp,srate,0,0.5);
        
               
        set(handles.filter_type,'string','3D Speech');
        set(handles.plot_3d_k,'enable','on');
        set(handles.plot_3D_dst,'enable','on');
        set(handles.plot_3D_dp,'enable','on');
        
        
        %     % velocities
        %     for k = 1:12
        %         handles.x3dspd(:,k) = diff(handles.x3d(:,k))/(1/srate);
        %         handles.y3dspd(:,k) = diff(handles.y3d(:,k))/(1/srate);
        %         handles.z3dspd(:,k) = diff(handles.z3d(:,k))/(1/srate);
        %         handles.x3dspdc(:,k) = diff(handles.x3dc(:,k))/(1/srate);
        %         handles.y3dspdc(:,k) = diff(handles.y3dc(:,k))/(1/srate);
        %         handles.z3dspdc(:,k) = diff(handles.z3dc(:,k))/(1/srate);
        %     end
        %
        guidata(hObject,handles);
    end
end

% --- Executes on button press in swallow_filt_3d.
function swallow_filt_3d_Callback(hObject, eventdata, handles)
% hObject    handle to swallow_filt_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

posOK=handles.posOK;

siz=size(handles.x3d_raw);
handles.x3d=zeros(siz);
handles.y3d=zeros(siz);
handles.z3d=zeros(siz);
handles.x3d_lp=zeros(siz);%
handles.y3d_lp=zeros(siz);%
handles.z3d_lp=zeros(siz);%
handles.x3dc=zeros(siz);%
handles.y3dc=zeros(siz);%
handles.z3dc=zeros(siz);%
handles.x3dc_lp=zeros(siz);%
handles.y3dc_lp=zeros(siz);%
handles.z3dc_lp=zeros(siz);%
handles.phi=zeros(siz);
handles.theta=zeros(siz);
handles.phi_lp=zeros(siz);%
handles.theta_lp=zeros(siz);%

handles.bc3d=zeros(siz(1),1);
handles.tt3d=zeros(siz(1),1);
handles.tb3d=zeros(siz(1),1);
handles.td3d=zeros(siz(1),1);
handles.bc3d_lp=zeros(siz(1),1);
handles.tt3d_lp=zeros(siz(1),1);
handles.tb3d_lp=zeros(siz(1),1);
handles.td3d_lp=zeros(siz(1),1);


handles.phi_raw = zeros(siz);%
handles.theta_raw = zeros(siz);%

handles.x3dpos=zeros(siz);%
handles.y3dpos=zeros(siz);%
handles.z3dpos=zeros(siz);%
handles.phipos=zeros(siz);%
handles.thetapos=zeros(siz);%

srate = handles.srate;

%variables to delete : rawi, pos_raw


% handles.x3dspd = zeros(size(handles.x3d_raw));
% handles.y3dspd = zeros(size(handles.x3d_raw));
% handles.z3dspd = zeros(size(handles.x3d_raw));
% handles.x3dspdc = zeros(size(handles.x3d_raw));
% handles.y3dspdc = zeros(size(handles.x3d_raw));
% handles.z3dspdc = zeros(size(handles.x3d_raw));

if handles.filtered == 1
    set(handles.filter_type,'string','Already filtered');
else
    
    % LOW FILTER
    %h = waitbar(0,'Filtering...');
    for k = 1:siz(2)
        %   waitbar(k/siz(2),h);
        
        handles.x3d_lp(:,k) = filter_array_rhv2(handles.x3d_raw(:,k),srate, handles.lpValue,0);
        handles.y3d_lp(:,k) = filter_array_rhv2(handles.y3d_raw(:,k),srate, handles.lpValue,0);
        handles.z3d_lp(:,k) = filter_array_rhv2(handles.z3d_raw(:,k),srate, handles.lpValue,0);
        
        handles.phi_raw(:,k)=unwrap(handles.phi_rawi(:,k)*pi/180);
        handles.theta_raw(:,k)=unwrap(handles.theta_rawi(:,k)*pi/180);
        handles.phi_lp(:,k) = filter_array_rhv2(handles.phi_raw(:,k),srate, handles.lpValue,0);
        handles.theta_lp(:,k) = filter_array_rhv2(handles.theta_raw(:,k),srate, handles.lpValue,0);
        
        
        if(posOK==1)
            handles.x3dpos(:,k) = filter_array_rhv2(handles.x3dpos_raw(:,k),srate, handles.lpValue,0);
            handles.y3dpos(:,k) = filter_array_rhv2(handles.y3dpos_raw(:,k),srate, handles.lpValue,0);
            handles.z3dpos(:,k) = filter_array_rhv2(handles.z3dpos_raw(:,k),srate, handles.lpValue,0);
            
            handles.phipos(:,k)=unwrap(handles.phipos_raw(:,k)*pi/180);
            handles.thetapos(:,k)=unwrap(handles.thetapos_raw(:,k)*pi/180);
            handles.phipos(:,k) = filter_array_rhv2(handles.phipos(:,k),srate, handles.lpValue,0);
            handles.thetapos(:,k) = filter_array_rhv2(handles.thetapos(:,k),srate, handles.lpValue,0);
        end
        
        %         [handles.x3d(:,k),handles.x3d_lp(:,k)] = filter_array_rhv3(handles.x3d_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.y3d(:,k),handles.y3d_lp(:,k)] = filter_array_rhv3(handles.y3d_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.z3d(:,k),handles.z3d_lp(:,k)] = filter_array_rhv3(handles.z3d_raw(:,k),srate, handles.lpValue,0.1);
        %         handles.x3dc(:,k) = filter_array_rhv2(handles.x3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         handles.y3dc(:,k) = filter_array_rhv2(handles.y3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         handles.z3dc(:,k) = filter_array_rhv2(handles.z3d_rawc(:,k),srate, handles.lpValue,0.1);
        %         [handles.phi(:,k),handles.phi_lp(:,k)] = filter_array_rhv3(handles.phi_raw(:,k),srate, handles.lpValue,0.1);
        %         [handles.theta(:,k),handles.theta_lp(:,k)] = filter_array_rhv3(handles.theta_raw(:,k),srate, handles.lpValue,0.1);
    end
    %close(h);
    %     [handles.bc3d,handles.bc3d_lp] = filter_array_rhv3(handles.bc3d, srate, handles.lpValue,0.1);
    %     [handles.tt3d,handles.tt3d_lp] = filter_array_rhv3(handles.tt3d, srate, handles.lpValue,0.1);
    %     [handles.td3d,handles.td3d_lp] = filter_array_rhv3(handles.td3d, srate, handles.lpValue,0.1);
    %     [handles.tb3d,handles.tb3d_lp] = filter_array_rhv3(handles.tb3d, srate, handles.lpValue,0.1);
    
    
    %     % velocities
    %     for k = 1:12
    %         handles.x3dspd(:,k) = diff(handles.x3d(:,k))/(1/srate);
    %         handles.y3dspd(:,k) = diff(handles.y3d(:,k))/(1/srate);
    %         handles.z3dspd(:,k) = diff(handles.z3d(:,k))/(1/srate);
    %         handles.x3dspdc(:,k) = diff(handles.x3dc(:,k))/(1/srate);
    %         handles.y3dspdc(:,k) = diff(handles.y3dc(:,k))/(1/srate);
    %         handles.z3dspdc(:,k) = diff(handles.z3dc(:,k))/(1/srate);
    %     end
    %
    
    guidata(hObject,handles);
    
    %OPEN GUI TO SELECT JAW AND HEAD CORRECTION METHODS
    [selheadc,seljawc,bite_trial,rest_trial,headcoils,jawcoils,sel,hfig]=...
        CorrectionGUI_HJ(handles);  % August 6/08/11 Rafael Henriques Copy the new version of CorrectionGUI_HJ
    
     
   bite_trial= num2str(bite_trial);
   rest_trial= num2str(rest_trial);
   
    
    %continue correction if it was been selected the methods of head and jaw correction
    if(sel)
        
        close(hfig)
        handles.filtered = 1;
        
        % August 6/08/11 Rafael Henriques
        %SPECIAL case when jaw' correction method chosen is Rafael' Method and it
        % was chosen the Cristian Kroos Head correction methods
        %if(selheadc==3&&seljawc==1)
        %    msg={'JAW correction aplied to data with no head correction',...
        %        'because current head correction method do not correct angles'};
        %    
        %    questdlg(msg,'warning','OK','OK');
        %    seljawc=-1;
        %    
        %    method=questdlg('what vertion do you want to use?',...
        %        'Rafael Henriques', 'Simple Jaw C',...
        %       'Bite & Resting trials','Simple Jaw C');
        %    switch method
        %        case 'Simple Jaw C'
        %            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
        %                handles.phic_lp,handles.thetac_lp]=...
        %                JawCorrection(jawcoils,handles.x3d_lp,handles.y3d_lp,...
        %                handles.z3d_lp,handles.phi_lp,handles.theta_lp);
        %        case 'Bite & Resting trials'
        %            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,handles.phic_lp,...
        %                handles.thetac_lp]=JawCorrection(jawcoils,handles.x3d_lp,...
        %                handles.y3d_lp,handles.z3d_lp,handles.phi_lp,...
        %                handles.theta_lp,1,handles.path1,rest_trial,headcoils);
        %    end
        %    
        %end
        
        
        %August 6/08/11 Rafael Henriques adaption of lines
        %Jaw correction can be independet of Head correction so I created
        %this new local variables that saves initial lp values
        
        inicx=handles.x3d_lp;
        inicy=handles.y3d_lp;
        inicz=handles.z3d_lp;
        inicphi=handles.phi_lp;
        inictheta=handles.theta_lp;
        
        %Head correction
        if(selheadc==1)
            [handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
                handles.phi_lp,handles.theta_lp]=HeadCorrection(handles.path1,...
                bite_trial,headcoils,handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,...
                handles.phi_lp,handles.theta_lp);
        elseif(selheadc==2)
            handles.x3d_lp = handles.x3dpos;
            handles.y3d_lp = handles.y3dpos;
            handles.z3d_lp = handles.z3dpos;
            handles.theta_lp = handles.thetapos;
            handles.phi_lp   = handles.phipos;
        elseif(selheadc==3)
            %August 6/08/11 Rafael Henriques adaption of lines, now this
            %head correction method also corrects angular information
            [handles.x3d_lp,handles.y3d_lp,handles.z3d_lp,handles.theta_lp,handles.phi_lp]=...
                KCcorrection(handles.path1,bite_trial,headcoils,handles.x3d_lp,...
                handles.y3d_lp,handles.z3d_lp,handles.phi_lp,handles.theta_lp);
           % handles.theta_lp = zeros(siz);
           % handles.phi_lp   = zeros(siz);
        end
        
        %JAW METHODS
        if(seljawc==1)
            
            method=questdlg('what vertion do you want to use?',...
                'JOANA', 'Simple Jaw C',...
                'Angular Jaw C','Simple Jaw C');
            switch method
                case 'Simple Jaw C'
                    [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                        handles.phic_lp,handles.thetac_lp]=JOANA(...
                        jawcoils,inicx,inicy,inicz,inicphi,inictheta,0);
                case 'Bite & Resting trials'
                    [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                        handles.phic_lp,handles.thetac_lp]=JOANA(...
                        jawcoils,inicx,inicy,inicz,inicphi,inictheta,1);
            end
            
        elseif(seljawc==2)
            
            for i=1:siz(2)
                [handles.x3dc_lp(:,i),handles.z3dc_lp(:,i)]=...
                    decouple_rh(handles.x3d_lp(:,i),handles.z3d_lp(:,i),...
                    handles.x3d_lp(:,jawcoils(1)),handles.z3d_lp(:,jawcoils(1)),srate);
            end
            
            for i=1:siz(2)
                handles.y3dc_lp(:,i)=handles.y3d_lp(:,i)-handles.y3d_lp(:,jawcoils(1));
            end
            handles.phic_lp=zeros(siz);
            handles.thetac_lp=zeros(siz);
            
        elseif(seljawc==3)
            
            for i=1:siz(2)
                handles.x3dc_lp(:,i)=handles.x3d_lp(:,i)-handles.x3d_lp(:,jawcoils(1));
                handles.y3dc_lp(:,i)=handles.y3d_lp(:,i)-handles.y3d_lp(:,jawcoils(1));
                handles.z3dc_lp(:,i)=handles.z3d_lp(:,i)-handles.z3d_lp(:,jawcoils(1));
            end
            
            handles.phic_lp=zeros(siz);
            handles.thetac_lp=zeros(siz);
            
        elseif(seljawc==4)
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                method=questdlg('what vertion do you want to use?',...
        'Christian Kroos', 'Simple Jaw C',...
        'Gold Jaw C','Simple Jaw C');
    
    switch method
        case 'Simple Jaw C'
            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                handles.thetac_lp,handles.phic_lp]=KCcorrection(handles.path1,...
                rest_trial,jawcoils, inicx,inicy,inicz,...
                inicphi,inictheta);

            
        case 'Gold Jaw C'
            [handles.x3dc_lp,handles.y3dc_lp,handles.z3dc_lp,...
                handles.thetac_lp,handles.phic_lp]=Gold(handles.path1,bite_trial,...
                headcoils,inicx,inicy,inicz,inicphi,inictheta, jawcoils);
            

    end
    
    %%%%%%%%%%%%%%%%%%%%%           
        end
        
        %GESTURES
        
        %BC = bilabial closure
        x6=handles.x3d_lp(:,6);
        y6=handles.y3d_lp(:,6);
        z6=handles.z3d_lp(:,6);
        x7=handles.x3d_lp(:,7);
        y7=handles.y3d_lp(:,7);
        z7=handles.z3d_lp(:,7);
        
        
        ges_stop = 0;
        if x6 == 0, ges_stop = 1;
        elseif y6 == 0, ges_stop = 1;
        elseif z6 == 0, ges_stop = 1;
        elseif x7 == 0, ges_stop = 1;
        elseif y7 == 0, ges_stop = 1;
        elseif z7 == 0, ges_stop = 1;
        end
        
        if ges_stop == 0
            hulpsig1=x6-x7;
            hulpsig2=y6-y7;
            hulpsigt=z6-z7;
            hulpsig3=(hulpsig1).^2;
            hulpsig4=(hulpsig2).^2;
            hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.bc3d_lp=sqrt(hulpsig5)';
        end
        
        %TD = tongue dorsum
        x1=handles.x3d_lp(:,1);
        y1=handles.y3d_lp(:,1);
        z1=handles.z3d_lp(:,1);
        x5=handles.x3d_lp(:,5);
        y5=handles.y3d_lp(:,5);
        z5=handles.z3d_lp(:,5);
        ges_stop = 0;
        if x1 == 0, ges_stop = 1;
        elseif y1 == 0, ges_stop = 1;
        elseif z1 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            hulpsig1=x1-x5;
            hulpsig2=y1-y5;
            hulpsigt=z1-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.td3d_lp=sqrt(hulpsig5)';
        end
        
        %TB = tongue body
        x2=handles.x3d_lp(:,2);
        y2=handles.y3d_lp(:,2);
        z2=handles.z3d_lp(:,2);
        
        ges_stop = 0;
        if x2 == 0, ges_stop = 1;
        elseif y2 == 0, ges_stop = 1;
        elseif z2 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            
            hulpsig1=x2-x5;% use nose position as upper limit (like ul in BC)
            hulpsig2=y2-y5;
            hulpsigt=z2-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.tb3d_lp=sqrt(hulpsig5)';
        end
        
        %TT = tongue tip (actually blade)
        x3=handles.x3d_lp(:,3);
        y3=handles.y3d_lp(:,3);
        z3=handles.z3d_lp(:,3);
        ges_stop = 0;
        if x3 == 0, ges_stop = 1;
        elseif y3 == 0, ges_stop = 1;
        elseif z3 == 0, ges_stop = 1;
        elseif x5 == 0, ges_stop = 1;
        elseif y5 == 0, ges_stop = 1;
        elseif z5 == 0, ges_stop = 1;
        end
        if ges_stop == 0
            
            hulpsig1=x3-x5;
            hulpsig2=y3-y5;
            hulpsigt=z3-z5;
            hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
            hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
            handles.tt3d_lp=sqrt(hulpsig5)';
        end
        
        % FILTER DATA WITH HIGH FILTER 
        
        for k = 1:siz(2)
            %   waitbar(k/siz(2),h);
            
            handles.x3d(:,k) = filter_array_rhv2(handles.x3d_lp(:,k),srate,0,0.1);
            handles.y3d(:,k) = filter_array_rhv2(handles.y3d_lp(:,k),srate,0,0.1);
            handles.z3d(:,k) = filter_array_rhv2(handles.z3d_lp(:,k),srate,0,0.1);
            handles.x3dc(:,k) = filter_array_rhv2(handles.x3dc_lp(:,k),srate,0,0.1);
            handles.y3dc(:,k) = filter_array_rhv2(handles.y3dc_lp(:,k),srate,0,0.1);
            handles.z3dc(:,k) = filter_array_rhv2(handles.z3dc_lp(:,k),srate,0,0.1);
            handles.phi(:,k) = filter_array_rhv2(handles.phi_lp(:,k),srate,0,0.1);
            handles.theta(:,k) = filter_array_rhv2(handles.theta_lp(:,k),srate,0,0.1);
                       
        end
        % close(h);
        
        handles.bc3d= filter_array_rhv2(handles.bc3d_lp,srate,0,0.1);
        handles.td3d = filter_array_rhv2(handles.td3d_lp,srate,0,0.1);
        handles.tb3d = filter_array_rhv2(handles.tb3d_lp,srate,0,0.1);
        handles.tt3d = filter_array_rhv2(handles.tt3d_lp,srate,0,0.1);
        
        set(handles.filter_type,'string','3D Swallowing');
        set(handles.plot_3d_k,'enable','on');
        set(handles.plot_3D_dst,'enable','on');
        set(handles.plot_3D_dp,'enable','on');
        
        guidata(hObject,handles);
    end
end
    


function filter_type_Callback(hObject, eventdata, handles)
% hObject    handle to filter_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filter_type as text
%        str2double(get(hObject,'String')) returns contents of filter_type as a double


% --- Executes during object creation, after setting all properties.
function filter_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% 3D/2D plots button

% --- Executes on button press in plot_2D_k.
function plot_2D_k_Callback(hObject, eventdata, handles)
% hObject    handle to plot_2D_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


gui_emma2d_rh(handles);
guidata(hObject,handles);

% --- Executes on button press in plot_3d_k.
function plot_3d_k_Callback(hObject, eventdata, handles)
% hObject    handle to plot_3d_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


gui_emma3d_eguana_rh(handles);
guidata(hObject,handles);


% --- Executes on button press in plot_3D_dst.
function plot_3D_dst_Callback(hObject, eventdata, handles)
% hObject    handle to plot_3D_dst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_emma3ddst_rh(handles);
guidata(hObject,handles);

% --- Executes on button press in plot_2D_dst.
function plot_2D_dst_Callback(hObject, eventdata, handles)
% hObject    handle to plot_2D_dst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_3D_dp.
function plot_3D_dp_Callback(hObject, eventdata, handles)
% hObject    handle to plot_3D_dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_2D_dp.
function plot_2D_dp_Callback(hObject, eventdata, handles)
% hObject    handle to plot_2D_dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
