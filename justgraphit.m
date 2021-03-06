function varargout = justgraphit(varargin)
% JUSTGRAPHIT M-file for justgraphit.fig
%      JUSTGRAPHIT, by itself, creates a new JUSTGRAPHIT or raises the existing
%      singleton*.
%
%      H = JUSTGRAPHIT returns the handle to a new JUSTGRAPHIT or the handle to
%      the existing singleton*.
%
%      JUSTGRAPHIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JUSTGRAPHIT.M with the given input arguments.
%
%      JUSTGRAPHIT('Property','Value',...) creates a new JUSTGRAPHIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before justgraphit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to justgraphit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help justgraphit

% Last Modified by GUIDE v2.5 02-Sep-2011 12:50:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @justgraphit_OpeningFcn, ...
                   'gui_OutputFcn',  @justgraphit_OutputFcn, ...
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


% --- Executes just before justgraphit is made visible.
function justgraphit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to justgraphit (see VARARGIN)

set(handles.edit1,'String','Y:\odlftp\ag501\data\recorder\current');

% Choose default command line output for justgraphit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes justgraphit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = justgraphit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filepath = uigetdir('','Select path for input files.');
set(handles.edit1,'String',filepath);


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Read data, CALL INPUT FUNCTION 
        
    r{1} = get(handles.edit1,'String');
    r{2} = get(handles.edit2,'String');
    %% FORM THE PATH STRING
    path = r{1};
    if isempty(path)
        path = '';
    elseif path(length(path)) ~= filesep;
        path(length(path)+1) = filesep;
    end
    
    % see if there is a pos file
    folders=ls(path);
    numfol=size(folders,1);
    posOK=0;
    
    for i=1:numfol
        if(size(find(folders(i,1:3)=='pos'),2)==3),posOK=1; end
    end
    pathpos=path;
    path = strcat(path, 'rawpos\');
    
    if r{2}(length(r{2})) ~= 'c' && r{2}(length(r{2})) ~= 'r'
        for i = 1:(4-length(r{2}))
            path = strcat(path, '0');
        end
        path = strcat(path, r{2},'.pos');
    else
        for i = 1:(5-length(r{2}))
            path = strcat(path, '0');
        end
        path = strcat(path, r{2},'.pos');
    end
    
    if posOK==1
        pathpos = strcat(pathpos, 'pos\');
        if r{2}(length(r{2})) ~= 'c' && r{2}(length(r{2})) ~= 'r'
            for i = 1:(4-length(r{2}))
                pathpos = strcat(pathpos, '0');
            end
            pathpos = strcat(pathpos, r{2},'.pos');
        else
            for i = 1:(5-length(r{2}))
                pathpos = strcat(pathpos, '0');
            end
            pathpos = strcat(pathpos, r{2},'.pos');
        end
    end
    
    if fopen(path,'r') == -1
        questdlg('File does not exist.  Please ensure PATH is correct.',...
            'ERROR','OK','OK');
        data = -1;
    else
        f = fopen(path, 'r');
        array = fread(f,[84 inf], 'single');
        data = array';
        fclose(f);
    end

    %PREPARE VARIABLES FOR RETURN (ac is already prepared)
    x1=data(:,1);y1=data(:,2);z1=data(:,3);phi1=data(:,4);theta1=data(:,5);
    x2=data(:,8);y2=data(:,9);z2=data(:,10);phi2=data(:,11);theta2=data(:,12);
    x3=data(:,15);y3=data(:,16);z3=data(:,17);phi3=data(:,18);theta3=data(:,19);
    x4=data(:,22);y4=data(:,23);z4=data(:,24);phi4=data(:,25);theta4=data(:,26);
    x5=data(:,29);y5=data(:,30);z5=data(:,31);phi5=data(:,32);theta5=data(:,33);

    if posOK==1
        if fopen(pathpos,'r') == -1
            questdlg('File does not exist.  Please ensure PATH is correct.',...
                'ERROR','OK','OK');
            data2 = -1;
        else
            f = fopen(pathpos, 'r');
            array = fread(f,[84 inf], 'single');
            data2 = array';
            fclose(f);
        end

        %PREPARE VARIABLES FOR RETURN (ac is already prepared)
        x1pos=data2(:,1);y1pos=data2(:,2);z1pos=data2(:,3);phi1pos=data2(:,4);theta1pos=data2(:,5);
        x2pos=data2(:,8);y2pos=data2(:,9);z2pos=data2(:,10);phi2pos=data2(:,11);theta2pos=data2(:,12);
        x3pos=data2(:,15);y3pos=data2(:,16);z3pos=data2(:,17);phi3pos=data2(:,18);theta3pos=data2(:,19);
        x4pos=data2(:,22);y4pos=data2(:,23);z4pos=data2(:,24);phi4pos=data2(:,25);theta4pos=data2(:,26);
        x5pos=data2(:,29);y5pos=data2(:,30);z5pos=data2(:,31);phi5pos=data2(:,32);theta5pos=data2(:,33);
    end
    
    if get(handles.checkbox1,'Value') == 1 && get(handles.checkbox2,'Value') == 0
        subplot(5,3,1)
        plot(1:length(x1),x1)
        subplot(5,3,2)
        plot(1:length(y1),y1)
        subplot(5,3,3)
        plot(1:length(z1),z1)
        subplot(5,3,4)
        plot(1:length(x2),x2)
        subplot(5,3,5)
        plot(1:length(y2),y2)
        subplot(5,3,6)
        plot(1:length(z2),z2)
        subplot(5,3,7)
        plot(1:length(x3),x3)
        subplot(5,3,8)
        plot(1:length(y3),y3)
        subplot(5,3,9)
        plot(1:length(z3),z3)
        subplot(5,3,10)
        plot(1:length(x4),x4)
        subplot(5,3,11)
        plot(1:length(y4),y4)
        subplot(5,3,12)
        plot(1:length(z4),z4)
        subplot(5,3,13)
        plot(1:length(x5),x5)
        subplot(5,3,14)
        plot(1:length(y5),y5)
        subplot(5,3,15)
        plot(1:length(z5),z5)
    end
    
    if get(handles.checkbox1,'Value') == 0 && get(handles.checkbox2,'Value') == 1
        subplot(5,3,1)
        plot(1:length(x1pos),x1pos,'Color','red')
        subplot(5,3,2)
        plot(1:length(y1pos),y1pos,'Color','red')
        subplot(5,3,3)
        plot(1:length(z1pos),z1pos,'Color','red')
        subplot(5,3,4)
        plot(1:length(x2pos),x2pos,'Color','red')
        subplot(5,3,5)
        plot(1:length(y2pos),y2pos,'Color','red')
        subplot(5,3,6)
        plot(1:length(z2pos),z2pos,'Color','red')
        subplot(5,3,7)
        plot(1:length(x3pos),x3pos,'Color','red')
        subplot(5,3,8)
        plot(1:length(y3pos),y3pos,'Color','red')
        subplot(5,3,9)
        plot(1:length(z3pos),z3pos,'Color','red')
        subplot(5,3,10)
        plot(1:length(x4pos),x4pos,'Color','red')
        subplot(5,3,11)
        plot(1:length(y4pos),y4pos,'Color','red')
        subplot(5,3,12)
        plot(1:length(z4pos),z4pos,'Color','red')
        subplot(5,3,13)
        plot(1:length(x5pos),x5pos,'Color','red')
        subplot(5,3,14)
        plot(1:length(y5pos),y5pos,'Color','red')
        subplot(5,3,15)
        plot(1:length(z5pos),z5pos,'Color','red')
    end
    
    if get(handles.checkbox1,'Value') == 1 && get(handles.checkbox2,'Value') == 1
        subplot(5,3,1)
        plot(1:length(x1),x1,1:length(x1pos),x1pos)
        subplot(5,3,2)
        plot(1:length(y1),y1,1:length(y1pos),y1pos)
        subplot(5,3,3)
        plot(1:length(z1),z1,1:length(z1pos),z1pos)
        subplot(5,3,4)
        plot(1:length(x2),x2,1:length(x2pos),x2pos)
        subplot(5,3,5)
        plot(1:length(y2),y2,1:length(y2pos),y2pos)
        subplot(5,3,6)
        plot(1:length(z2),z2,1:length(z2pos),z2pos)
        subplot(5,3,7)
        plot(1:length(x3),x3,1:length(x3pos),x3pos)
        subplot(5,3,8)
        plot(1:length(y3),y3,1:length(y3pos),y3pos)
        subplot(5,3,9)
        plot(1:length(z3),z3,1:length(z3pos),z3pos)
        subplot(5,3,10)
        plot(1:length(x4),x4,1:length(x4pos),x4pos)
        subplot(5,3,11)
        plot(1:length(y4),y4,1:length(y4pos),y4pos)
        subplot(5,3,12)
        plot(1:length(z4),z4,1:length(z4pos),z4pos)
        subplot(5,3,13)
        plot(1:length(x5),x5,1:length(x5pos),x5pos)
        subplot(5,3,14)
        plot(1:length(y5),y5,1:length(y5pos),y5pos)
        subplot(5,3,15)
        plot(1:length(z5),z5,1:length(z5pos),z5pos)
    end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
