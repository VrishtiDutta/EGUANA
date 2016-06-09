function varargout = fnn_instructions(varargin)
% FNN_INSTRUCTIONS M-file for fnn_instructions.fig
%      FNN_INSTRUCTIONS, by itself, creates a new FNN_INSTRUCTIONS or raises the existing
%      singleton*.
%
%      H = FNN_INSTRUCTIONS returns the handle to a new FNN_INSTRUCTIONS or the handle to
%      the existing singleton*.
%
%      FNN_INSTRUCTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FNN_INSTRUCTIONS.M with the given input arguments.
%
%      FNN_INSTRUCTIONS('Property','Value',...) creates a new FNN_INSTRUCTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fnn_instructions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fnn_instructions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fnn_instructions

% Last Modified by GUIDE v2.5 06-Apr-2009 12:26:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fnn_instructions_OpeningFcn, ...
                   'gui_OutputFcn',  @fnn_instructions_OutputFcn, ...
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


% --- Executes just before fnn_instructions is made visible.
function fnn_instructions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fnn_instructions (see VARARGIN)


% later get the exact pixel size of the window and insert those in for last
% 2 parameters of position so it fits any screen

% Choose default command line output for fnn_instructions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fnn_instructions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fnn_instructions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
