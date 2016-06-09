function varargout = gui_rqa_eguana(varargin)
% GUI_RQA_EGUANA M-file for gui_rqa_eguana.fig
%      GUI_RQA_EGUANA, by itself, creates a new GUI_RQA_EGUANA or raises the existing
%      singleton*.
%
%      H = GUI_RQA_EGUANA returns the handle to a new GUI_RQA_EGUANA or the handle to
%      the existing singleton*.
%
%      GUI_RQA_EGUANA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_RQA_EGUANA.M with the given input arguments.
%
%      GUI_RQA_EGUANA('Property','Value',...) creates a new GUI_RQA_EGUANA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_rqa_eguana_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_rqa_eguana_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_rqa_eguana

% Last Modified by GUIDE v2.5 02-Sep-2010 13:49:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_rqa_eguana_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_rqa_eguana_OutputFcn, ...
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


% --- Executes just before gui_rqa_eguana is made visible.
function gui_rqa_eguana_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_rqa_eguana (see VARARGIN)

handles.sig1 = varargin{1};
handles.sig_string12 = varargin{2};
handles.path=varargin{3};
handles.filename = varargin{4};
handles.trialnum = varargin{5};
handles.subname = varargin{6};

% Choose default command line output for gui_rqa_eguana
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_rqa_eguana wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_rqa_eguana_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ami1.
function ami1_Callback(hObject, eventdata, handles)
% hObject    handle to ami1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.em_delay1 = ami_matt(handles.sig1);
set(handles.fnn1,'enable','on');
set(handles.em_delay1_box,'string',int2str(handles.em_delay1));
guidata(hObject, handles);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in fnn1.
function fnn1_Callback(hObject, eventdata, handles)
% hObject    handle to fnn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.em_dim1 = fnn_matt(handles.sig1,handles.em_delay1);
set(handles.rqalog20_1,'enable','on');
set(handles.em_dim1_box,'string',int2str(handles.em_dim1));
guidata(hObject, handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rqalog20_1.
function rqalog20_1_Callback(hObject, eventdata, handles)
% hObject    handle to rqalog20_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.rad1 = rqalog20_matt(handles.sig1,handles.em_delay1,handles.em_dim1);
set(handles.rqa1,'enable','on');
set(handles.rqalog20_box1,'string',int2str(handles.rad1));
guidata(hObject, handles);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in rqa1.
function rqa1_Callback(hObject, eventdata, handles)
% hObject    handle to rqa1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[delay, embed, radius, rescaletype, minline, numrecurs, numlines, percentrecurs, ...
    pdeter, entropy, RelEnt, maxline, meanline, trend] ...
    = rqa_matt(handles.sig1,handles.em_delay1,handles.em_dim1,handles.rad1);
handles.delay1 = delay;
handles.embed1 = embed;
handles.radius1 = radius;
handles.rescaletype1 = rescaletype;
handles.minline1 = minline;
handles.numrecurs1 = numrecurs;
handles.numlines1 = numlines;
handles.percentrecurs1 = percentrecurs;
handles.pdeter1 = pdeter;
handles.entropy1 = entropy;
handles.relent1 = RelEnt;
handles.maxline1 = maxline;
handles.meanline1 = meanline;
handles.trend1 = trend;
set(handles.savebtn1,'enable','on');
guidata(hObject, handles);

question='Do you want to see RQA data from shuffled version?';
Shufopt1=questdlg(question,'Shuffle?','yes','no ','yes');

if strcmp(Shufopt1,'yes')
%use random shuffle of original time series to test RQA values
    shuftem1=shuffle(handles.sig1,1);
    [delay, embed, radius, rescaletype, minline, numrecurs, numlines, percentrecurs, ...
    pdeter, entropy, RelEnt, maxline, meanline, trend] ...
    = rqa_matt(shuftem1,handles.em_delay1,handles.em_dim1,handles.rad1);
else
    msgbox('OK','Shuffle sig1');
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in savebtn1.
function savebtn1_Callback(hObject, eventdata, handles)
% hObject    handle to savebtn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.path) % test data
    errordlg('Test variables are not saved');
else
    
    sigs = handles.sig_string12;
    %fs_1 = strcat(handles.path,handles.filename,'.',num2str(handles.trialnum),'.RQA.',sigs,'.txt');
    fs_1 = strcat(handles.path,handles.filename,'.RQA.',sigs,'.txt');
    % '_NonLin_RQA_',sigs,'_',handles.subname,'_trial_',num2str(handles.trialnum),'.txt');
    
    if path~=0
        fid = fopen(fs_1,'a');
        
       fprintf(fid, ...
   '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\n',...
   handles.filename, handles.subname, num2str(handles.trialnum),...
   num2str(handles.delay1), num2str(handles.embed1), ...
   num2str(handles.radius1),num2str(handles.minline1),...
   num2str(handles.numrecurs1), num2str(handles.numlines1),...
   num2str(handles.percentrecurs1),num2str(handles.pdeter1), ...
   num2str(handles.entropy1), num2str(handles.relent1), ...
   num2str(handles.maxline1), num2str(handles.meanline1),...
   num2str(handles.trend1));
        
        fclose(fid);
        
        msgbox(fs_1, 'Written to File:');
        
    end
end
