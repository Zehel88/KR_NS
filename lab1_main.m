%% Стандартные функции создания и запуска приложения
function varargout = lab1_main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab1_main_OpeningFcn, ...
                   'gui_OutputFcn',  @lab1_main_OutputFcn, ...
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

function lab1_main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
%% Пре-загрузка
load('DaTa.mat');
set(handles.uitable1,'DaTa',DaTa)
load('dic_DaTa.mat');
set(handles.uitable2,'DaTa',dic_DaTa)


function varargout = lab1_main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%% Задание
% Разработка подсистемы поддержки принятия решений о рейтинге
% студентов на основе данных о посещении ими лекций, прочтении книг и сдаче лабораторных
% работ. Требуется найти рейтинг для двух и более студентов

%% Реализация

function pushbutton1_Callback(hObject, eventdata, handles)
%% Кнопка добавления студента
% Открытие окна добавления студента
run('add_std.m')
% Ждем результат выполнения добавочной формы
uiwait

if exist('newstd.mat')~=0

%  Получаем имеющиеся данные
 DaTa=get(handles.uitable1,'DaTa');
%  
[n_r n_c]=size(DaTa);

if n_r==0
    i=1
else
    i=n_r+1
end

load('newstd.mat');
DaTa{i(1),1}=[newstd.F ' ' newstd.I ' ' newstd.O];
DaTa{i(1),2}=newstd.L;
DaTa{i(1),3}=newstd.K;
DaTa{i(1),4}=newstd.LR;

save('DaTa.mat','DaTa');

set(handles.uitable1,'DaTa',DaTa)

delete newstd.mat
end 



function pushbutton2_Callback(hObject, eventdata, handles)
%% Удалить студента
run('del_std')
uiwait
load('DaTa.mat')
set(handles.uitable1,'DaTa',DaTa);

% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)



function pushbutton3_Callback(hObject, eventdata, handles)
%% УСПЕВАЕМОСТЬ

dic_DaTa=get(handles.uitable2,'DaTa');
load('DaTa.mat')
% Создаем нечеткую систему
F=newfis('lab1_fis');
% a=addvar(a,'input','service',[0 10]);
% Задаем входные переменные
F=addvar(F,'input','L',[0 dic_DaTa(1)]);
F=addvar(F,'input','K',[0 dic_DaTa(2)]);
F=addvar(F,'input','LR',[0 dic_DaTa(3)]);
% Задаем выходную переменную
F=addvar(F,'output','out',[0 1]);

% Задаем функции принадлежности для термов переменных
% Для входов
% Лекции
F=addmf(F,'input',1,'low','trapmf',[0 dic_DaTa(1)*0.2 dic_DaTa(1)*0.3 dic_DaTa(1)*0.5]);
F=addmf(F,'input',1,'medium','trapmf',[dic_DaTa(1)*0.3 dic_DaTa(1)*0.5 dic_DaTa(1)*0.7 dic_DaTa(1)*0.8]);
F=addmf(F,'input',1,'high','trapmf',[dic_DaTa(1)*0.7 dic_DaTa(1)*0.9 dic_DaTa(1) dic_DaTa(1)]);
% Книги
F=addmf(F,'input',2,'low','trimf',[0 0 dic_DaTa(2)*0.1]);
F=addmf(F,'input',2,'medium','trimf',[0 dic_DaTa(2)*0.2 dic_DaTa(2)*0.4]);
F=addmf(F,'input',2,'high','trimf',[dic_DaTa(2)*0.1 dic_DaTa(2)*0.4 dic_DaTa(2)*0.9]);
F=addmf(F,'input',2,'very high','trimf',[dic_DaTa(2)*0.5 dic_DaTa(2) dic_DaTa(2)]);
% Лабораторные работы
F=addmf(F,'input',3,'low','trimf',[0 dic_DaTa(3)*0.25 dic_DaTa(3)*0.5]);
F=addmf(F,'input',3,'medium','trimf',[dic_DaTa(3)*0.25 dic_DaTa(3)*0.6 dic_DaTa(3)]);
F=addmf(F,'input',3,'high','trimf',[dic_DaTa(3)*0.7 dic_DaTa(3) dic_DaTa(3)]);



% Для выхода
F=addmf(F,'output',1,'low','trapmf',[0 0 0.2 0.3]);
F=addmf(F,'output',1,'medium','trapmf',[0.1 0.3 0.4 0.6]);
F=addmf(F,'output',1,'high','trapmf',[0.5 0.7 0.8 0.9]);
F=addmf(F,'output',1,'very high','trapmf',[0.8 0.9 1 1]);

% Создаем базу правил
row=1;
for i=1:3
    for j=1:4
        for k=1:3
                ruleslist(row,1:3)=[i j k];
                if sum(ruleslist(row,1:3))<5
                    ruleslist(row,4)=1;
                elseif sum(ruleslist(row,1:3))<6
                    ruleslist(row,4)=2;
                elseif sum(ruleslist(row,1:3))<8
                    ruleslist(row,4)=3;
                elseif sum(ruleslist(row,1:3))<=10
                    ruleslist(row,4)=4;
                end
ruleslist(row,5:6)=[1 1];
                row=row+1;
        end
    end
end
F = addrule(F,ruleslist);



writefis(F,'lab1_fis');

%  Получение решения
try
for i=1:numel(DaTa(:,1))
   
    res(i,:)=evalfis(cell2mat(DaTa(i,2:4)),F)*100;
    
end
DaTa(:,5)=num2cell((res));
save('DaTa.mat','DaTa');
set(handles.uitable1,'DaTa',DaTa)
catch
    disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
end




% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Untitled_2_Callback(hObject, eventdata, handles)
%% Построение функций принадлежности
F=readfis('lab1_fis')
figure(2)
set(figure(2),'Position',[300 200 600 650])
set(figure(2),'Name','Графики принадлежности НС')
subplot(4,1,1)
plotmf(F,'input',1)

subplot(4,1,2)
plotmf(F,'input',2)

subplot(4,1,3)
plotmf(F,'input',3)

subplot(4,1,4)
plotmf(F,'output',1)



function Untitled_3_Callback(hObject, eventdata, handles)
%% Графики правил
F=readfis('lab1_fis')

ruleview(F)
