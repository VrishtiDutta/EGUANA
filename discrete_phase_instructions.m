function varargout = discrete_phase_instructions(varargin)
% DISCRETE_PHASE_INSTRUCTIONS M-file for discrete_phase_instructions.fig
%      DISCRETE_PHASE_INSTRUCTIONS, by itself, creates a new DISCRETE_PHASE_INSTRUCTIONS or raises the existing
%      singleton*.
%
%      H = DISCRETE_PHASE_INSTRUCTIONS returns the handle to a new DISCRETE_PHASE_INSTRUCTIONS or the handle to
%      the existing singleton*.
%
%      DISCRETE_PHASE_INSTRUCTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISCRETE_PHASE_INSTRUCTIONS.M with the given input arguments.
%
%      DISCRETE_PHASE_INSTRUCTIONS('Property','Value',...) creates a new DISCRETE_PHASE_INSTRUCTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before discrete_phase_instructions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to discrete_phase_instructions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help discrete_phase_instructions

% Last Modified by GUIDE v2.5 06-Apr-2009 12:26:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @discrete_phase_instructions_OpeningFcn, ...
                   'gui_OutputFcn',  @discrete_phase_instructions_OutputFcn, ...
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


% --- Executes just before discrete_phase_instructions is made visible.
function discrete_phase_instructions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to discrete_phase_instructions (see VARARGIN)

%scnsize=get(0, 'ScreenSize');
%set(gcf, 'Units' , 'Pixel');
%set(gcf, 'Position', [0, 0.7*scnsize(4), 0.25*scnsize(3), 0.08*scnsize(4)]);

% later get the exact pixel size of the window and insert those in for last
% 2 parameters of position so it fits any screen

% Choose default command line output for discrete_phase_instructions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes discrete_phase_instructions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = discrete_phase_instructions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
