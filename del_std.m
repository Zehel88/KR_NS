function varargout = del_std(varargin)
% DEL_STD MATLAB code for del_std.fig
%      DEL_STD, by itself, creates a new DEL_STD or raises the existing
%      singleton*.
%
%      H = DEL_STD returns the handle to a new DEL_STD or the handle to
%      the existing singleton*.
%
%      DEL_STD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEL_STD.M with the given input arguments.
%
%      DEL_STD('Property','Value',...) creates a new DEL_STD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before del_std_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to del_std_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help del_std

% Last Modified by GUIDE v2.5 17-Jan-2016 00:04:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @del_std_OpeningFcn, ...
                   'gui_OutputFcn',  @del_std_OutputFcn, ...
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


% --- Executes just before del_std is made visible.
function del_std_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to del_std (see VARARGIN)

% Choose default command line output for del_std
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load('DaTa.mat');
[n_rows afsa]=size(DaTa);
if n_rows~=0

set(handles.popupmenu1,'String',DaTa(:,1))
end

% UIWAIT makes del_std wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = del_std_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
i=get(handles.popupmenu1,'Value')
load('DaTa.mat');
DaTa(i,:)=[]
save('DaTa.mat','DaTa');
close('Удалить студента')
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close('Удалить студента')
