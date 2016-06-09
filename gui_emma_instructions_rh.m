function varargout = gui_emma_instructions_rh(varargin)
% GUI_EMMA_INSTRUCTIONS_RH M-file for gui_emma_instructions_rh.fig
%      GUI_EMMA_INSTRUCTIONS_RH, by itself, creates a new GUI_EMMA_INSTRUCTIONS_RH or raises the existing
%      singleton*.
%
%      H = GUI_EMMA_INSTRUCTIONS_RH returns the handle to a new GUI_EMMA_INSTRUCTIONS_RH or the handle to
%      the existing singleton*.
%
%      GUI_EMMA_INSTRUCTIONS_RH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EMMA_INSTRUCTIONS_RH.M with the given input arguments.
%
%      GUI_EMMA_INSTRUCTIONS_RH('Property','Value',...) creates a new GUI_EMMA_INSTRUCTIONS_RH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_emma_instructions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_emma_instructions_rh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_emma_instructions_rh

% Last Modified by GUIDE v2.5 07-Jul-2010 16:27:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_emma_instructions_rh_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_emma_instructions_rh_OutputFcn, ...
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


% --- Executes just before gui_emma_instructions_rh is made visible.
function gui_emma_instructions_rh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_emma_instructions_rh (see VARARGIN)

scnsize=get(0, 'ScreenSize');

set(gcf, 'Units' , 'Pixel');
set(gcf, 'Position', [0, 0.7*scnsize(4), 0.28*scnsize(3), 0.367*scnsize(4)]);
% later get the exact pixel size of the window and insert those in for last
% 2 parameters of position so it fits any screen

% Choose default command line output for gui_emma_instructions_rh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_emma_instructions_rh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_emma_instructions_rh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
