function varargout = rqalog20_instructions(varargin)
% RQALOG20_INSTRUCTIONS M-file for rqalog20_instructions.fig
%      RQALOG20_INSTRUCTIONS, by itself, creates a new RQALOG20_INSTRUCTIONS or raises the existing
%      singleton*.
%
%      H = RQALOG20_INSTRUCTIONS returns the handle to a new RQALOG20_INSTRUCTIONS or the handle to
%      the existing singleton*.
%
%      RQALOG20_INSTRUCTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RQALOG20_INSTRUCTIONS.M with the given input arguments.
%
%      RQALOG20_INSTRUCTIONS('Property','Value',...) creates a new RQALOG20_INSTRUCTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rqalog20_instructions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rqalog20_instructions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rqalog20_instructions

% Last Modified by GUIDE v2.5 06-Apr-2009 12:26:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rqalog20_instructions_OpeningFcn, ...
                   'gui_OutputFcn',  @rqalog20_instructions_OutputFcn, ...
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


% --- Executes just before rqalog20_instructions is made visible.
function rqalog20_instructions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rqalog20_instructions (see VARARGIN)


% later get the exact pixel size of the window and insert those in for last
% 2 parameters of position so it fits any screen

% Choose default command line output for rqalog20_instructions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rqalog20_instructions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rqalog20_instructions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
