%% Стандартные функции создания и запуска приложения
function varargout = add_std(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @add_std_OpeningFcn, ...
                   'gui_OutputFcn',  @add_std_OutputFcn, ...
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


function add_std_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = add_std_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%% ФИО 
function editF_Callback(hObject, eventdata, handles)

function editF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editI_Callback(hObject, eventdata, handles)

function editI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editO_Callback(hObject, eventdata, handles)

function editO_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Данные о студенте
function editL_Callback(hObject, eventdata, handles)

function editL_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editLR_Callback(hObject, eventdata, handles)

function editLR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editK_Callback(hObject, eventdata, handles)

function editK_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
%% Кнопка ПОДТВЕРДИТЬ 
if ~isempty(get(handles.editF,'String')) && ~isempty(get(handles.editI,'String')) && ~isempty(get(handles.editO,'String')) && ~isempty(get(handles.editL,'String')) && ~isempty(get(handles.editK,'String')) && ~isempty(get(handles.editLR,'String'))    
    
    newstd.F=get(handles.editF,'String');
    newstd.I=get(handles.editI,'String');
    newstd.O=get(handles.editO,'String');
    newstd.L=str2double(get(handles.editL,'String'));
    newstd.K=str2double(get(handles.editK,'String'));
    newstd.LR=str2double(get(handles.editLR,'String'));
    
    save('newstd.mat','newstd')
% Закрыть окно добавлния студента 
close('Добавить студента');
else
    errordlg('Заполните поля')
end




function pushbutton2_Callback(hObject, eventdata, handles)
%% Кнопка ОТМЕНА

% Закрыть окно добавлния студента 
close('Добавить студента');
