function varargout = gui_input2Dfiles(varargin)
% GUI_INPUT2DFILES MATLAB code for gui_input2Dfiles.fig
%      GUI_INPUT2DFILES, by itself, creates a new GUI_INPUT2DFILES or raises the existing
%      singleton*.
%
%      H = GUI_INPUT2DFILES returns the handle to a new GUI_INPUT2DFILES or the handle to
%      the existing singleton*.
%
%      GUI_INPUT2DFILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INPUT2DFILES.M with the given input arguments.
%
%      GUI_INPUT2DFILES('Property','Value',...) creates a new GUI_INPUT2DFILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_input2Dfiles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_input2Dfiles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_input2Dfiles

% Last Modified by GUIDE v2.5 06-Aug-2012 13:45:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_input2Dfiles_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_input2Dfiles_OutputFcn, ...
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


% --- Executes just before gui_input2Dfiles is made visible.
function gui_input2Dfiles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_input2Dfiles (see VARARGIN)

% Choose default command line output for gui_input2Dfiles
handles.output = hObject;

set(hObject, 'Name', 'Input File for 2D EMA');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_input2Dfiles wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_input2Dfiles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.r;

delete(handles.figure1);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in datafile_button.
function datafile_button_Callback(hObject, eventdata, handles)
% hObject    handle to datafile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename2d, pathname2d] = uigetfile('*.*','Select the 2D data file');
handles.r{1} = [pathname2d filename2d];
[~, ~, ext] = fileparts(filename2d);
handles.r{2} = num2str(str2double(ext(3:length(ext))));
set(handles.edit1,'String',handles.r{1});
guidata(hObject, handles);



% --- Executes on button press in dirselect_button.
function dirselect_button_Callback(hObject, eventdata, handles)
% hObject    handle to dirselect_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.r{1} = uigetdir('','Select path for input files.');
set(handles.edit1,'String',handles.r{1});



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in resultsdirectory_button.
function resultsdirectory_button_Callback(hObject, eventdata, handles)
% hObject    handle to resultsdirectory_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.r{4} = uigetdir('','Select path for storing results.');
set(handles.edit3,'String',handles.r{4});


% --- Executes on button press in closebutton.
function closebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.r{1} = get(handles.edit1,'String');
[~, ~, ext] = fileparts(handles.r{1});
handles.r{2} = num2str(str2double(ext(3:length(ext))));
handles.r{3} = get(handles.edit2,'String');
handles.r{4} = get(handles.edit3,'String');
uiresume(handles.figure1);
guidata(hObject, handles);
