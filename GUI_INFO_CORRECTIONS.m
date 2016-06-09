function varargout = GUI_INFO_CORRECTIONS(varargin)
% GUI_INFO_CORRECTIONS M-file for GUI_INFO_CORRECTIONS.fig
%      GUI_INFO_CORRECTIONS, by itself, creates a new GUI_INFO_CORRECTIONS or raises the existing
%      singleton*.
%
%      H = GUI_INFO_CORRECTIONS returns the handle to a new GUI_INFO_CORRECTIONS or the handle to
%      the existing singleton*.
%
%      GUI_INFO_CORRECTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INFO_CORRECTIONS.M with the given input arguments.
%
%      GUI_INFO_CORRECTIONS('Property','Value',...) creates a new GUI_INFO_CORRECTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_INFO_CORRECTIONS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_INFO_CORRECTIONS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_INFO_CORRECTIONS

% Last Modified by GUIDE v2.5 06-Aug-2011 17:21:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_INFO_CORRECTIONS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_INFO_CORRECTIONS_OutputFcn, ...
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


% --- Executes just before GUI_INFO_CORRECTIONS is made visible.
function GUI_INFO_CORRECTIONS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_INFO_CORRECTIONS (see VARARGIN)

% Choose default command line output for GUI_INFO_CORRECTIONS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_INFO_CORRECTIONS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_INFO_CORRECTIONS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
