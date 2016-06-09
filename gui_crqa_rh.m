function varargout = gui_crqa_rh(varargin)
% GUI_CRQA_RH M-file for gui_crqa_rh.fig
%      GUI_CRQA_RH, by itself, creates a new GUI_CRQA_RH or raises the existing
%      singleton*.
%
%      H = GUI_CRQA_RH returns the handle to a new GUI_CRQA_RH or the handle to
%      the existing singleton*.
%
%      GUI_CRQA_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CRQA_RH.M with the given input arguments.
%
%      GUI_CRQA_RH('Property','Value',...) creates a new GUI_CRQA_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_crqa_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_crqa_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_crqa_rh

% Last Modified by GUIDE v2.5 15-Jul-2010 14:47:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_crqa_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_crqa_rh_OutputFcn, ...
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


% --- Executes just before gui_crqa_rh is made visible.
function gui_crqa_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_crqa_rh (see VARARGIN)
handles.sig1 = varargin{1};
handles.sig2 = varargin{2};
handles.name1 = varargin{3};
handles.name2 = varargin{4};
handles.emdel1 = 0;
handles.emdel2 = 0;
handles.emdim1 = 0;
handles.emdim2 = 0;
handles.rad1 = 0;
set(handles.sig_string1,'string',handles.name1);
set(handles.sig_string2,'string',handles.name2);
handles.path = varargin{5};
handles.filename = varargin{6};
handles.trialnum = varargin{7};
handles.subname = varargin{8};
handles.lim = varargin{9};

rate = 200;
% Select interval that needs to be analyzed

%     p1={'Enter start time (in sec):','Enter end time (in sec):'};    
%     r1=inputdlg(p1,'Interval selection',1);
%     starttime=eval(r1{1});
%     stoptime=eval(r1{2});
%     rescale=0;
% 
%     if (starttime~=0 & stoptime~=0)
%     endpoint1=length(handles.sig1);
%     startpoint1=fix(starttime*rate)-1;
%     stoppoint1=fix(stoptime*rate)+1;
%     handles.sig1(stoppoint1:endpoint1)=[];handles.sig1(1:startpoint1)=[];
%     handles.sig2(stoppoint1:endpoint1)=[];handles.sig2(1:startpoint1)=[];   
%     end
%
 startpoint1=ceil(handles.lim(1)*rate);
    stoppoint1=floor(handles.lim(2)*rate);
    lentmax=length(handles.sig1);
    
    if startpoint1 <=0, startpoint1=1; end
    if startpoint1 >=lentmax, startpoint1=lentmax; end
    
    handles.sig1 = handles.sig1(startpoint1:stoppoint1);
    handles.sig2 = handles.sig2(startpoint1:stoppoint1);

% Choose default command line output for gui_crqa_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_crqa_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_crqa_rh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ami2.
function ami2_Callback(hObject, eventdata, handles)
% hObject    handle to ami2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.emdel2 = ami_matt(handles.sig2);
set(handles.ami2_box,'string',int2str(handles.emdel2));
set(handles.fnn2,'enable','on');
guidata(hObject, handles);

% --- Executes on button press in ami1.
function ami1_Callback(hObject, eventdata, handles)
% hObject    handle to ami1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.emdel1 = ami_matt(handles.sig1);
set(handles.ami1_box,'string',int2str(handles.emdel1));
set(handles.fnn1,'enable','on');


guidata(hObject, handles);

% --- Executes on button press in fnn2.
function fnn2_Callback(hObject, eventdata, handles)
% hObject    handle to fnn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.emdim2 = fnn_matt(handles.sig2,handles.emdel2);
set(handles.fnn2_box,'string',int2str(handles.emdim2));
set(handles.crqalog20,'enable','on');
guidata(hObject, handles);

% --- Executes on button press in fnn1.
function fnn1_Callback(hObject, eventdata, handles)
% hObject    handle to fnn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.emdim1 = fnn_matt(handles.sig1,handles.emdel1);
set(handles.fnn1_box,'string',int2str(handles.emdim1));
set(handles.crqalog20,'enable','on');
guidata(hObject, handles);

% --- Executes on button press in crqalog20.
function crqalog20_Callback(hObject, eventdata, handles)
% hObject    handle to crqalog20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% default is to input the values from signal 1
if (handles.emdel1 > 0) ami = handles.emdel1; else ami = handles.emdel2; end
if (handles.emdim1 > 0) fnn = handles.emdim1; else fnn = handles.emdim2; end
    
handles.rad1 = crqalog20_matt(handles.sig1,handles.sig2,handles.name1,handles.name2,ami,fnn);
set(handles.crqa,'enable','on');
set(handles.crqalog20_box,'string',int2str(handles.rad1));
guidata(hObject, handles);

% --- Executes on button press in crqa.
function crqa_Callback(hObject, eventdata, handles)
% hObject    handle to crqa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[delay, embed, radius, rescaletype, minline, numrecurs, numlines, percentrecurs, pdeter, ...
    entropy, RelEnt, maxline, meanline] = ...
    crqa_matt(handles.sig1,handles.sig2,handles.name1,handles.name2,handles.emdel1,handles.emdim1,handles.rad1);

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


set(handles.savebtn,'enable','on');
guidata(hObject, handles);



% --- Executes on button press in savebtn.
function savebtn_Callback(hObject, eventdata, handles)
% hObject    handle to savebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.path) % test data
    errordlg('Test variables are not saved');
else

    sigs = strcat(handles.name1,'.',handles.name2);
  
    %fs_1 = strcat(handles.path,handles.filename,'.',num2str(handles.trialnum),'.CRQA.',sigs,'.txt');
    fs_1 = strcat(handles.path,handles.filename,'.CRQA.',sigs,'.txt');
    
    if path~=0
        %fid = fopen(fs_1,'w');
        fid = fopen(fs_1,'a');
        
        %fprintf(fid, 'Session: \t Subject: \t Trial: \t Delay: \t # Embedding Dimensions: \t Radius (%% of mean distance) \t Line length(min recurrent points): \t # Recurrent Points: \t # Lines: \t %% Recurrence: \t %% Determinism: \t Entropy: \t Relative Entropy: \t Maxline: \t Meanline: \n');
        fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\n', handles.filename, handles.subname, num2str(handles.trialnum), num2str(handles.delay1), num2str(handles.embed1), num2str(handles.radius1), ...
        num2str(handles.minline1), num2str(handles.numrecurs1), num2str(handles.numlines1), num2str(handles.percentrecurs1), ...
        num2str(handles.pdeter1), num2str(handles.entropy1), num2str(handles.relent1), num2str(handles.maxline1), ...
        num2str(handles.meanline1));
    
        fclose(fid);
    
        msgbox(fs_1, 'Written to File:');
    end
end



function ami1_box_Callback(hObject, eventdata, handles)
% hObject    handle to ami1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ami1_box as text
%        str2double(get(hObject,'String')) returns contents of ami1_box as a double


% --- Executes during object creation, after setting all properties.
function ami1_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ami1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fnn1_box_Callback(hObject, eventdata, handles)
% hObject    handle to fnn1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fnn1_box as text
%        str2double(get(hObject,'String')) returns contents of fnn1_box as a double


% --- Executes during object creation, after setting all properties.
function fnn1_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fnn1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ami2_box_Callback(hObject, eventdata, handles)
% hObject    handle to ami2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ami2_box as text
%        str2double(get(hObject,'String')) returns contents of ami2_box as a double


% --- Executes during object creation, after setting all properties.
function ami2_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ami2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fnn2_box_Callback(hObject, eventdata, handles)
% hObject    handle to fnn2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fnn2_box as text
%        str2double(get(hObject,'String')) returns contents of fnn2_box as a double


% --- Executes during object creation, after setting all properties.
function fnn2_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fnn2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function crqalog20_box_Callback(hObject, eventdata, handles)
% hObject    handle to crqalog20_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crqalog20_box as text
%        str2double(get(hObject,'String')) returns contents of crqalog20_box as a double


% --- Executes during object creation, after setting all properties.
function crqalog20_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crqalog20_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


