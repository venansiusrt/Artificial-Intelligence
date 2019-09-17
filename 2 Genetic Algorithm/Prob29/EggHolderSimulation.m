function varargout = EggHolderSimulation(varargin)
% EGGHOLDERSIMULATION MATLAB code for EggHolderSimulation.fig
%      EGGHOLDERSIMULATION, by itself, creates a new EGGHOLDERSIMULATION or raises the existing
%      singleton*.
%
%      H = EGGHOLDERSIMULATION returns the handle to a new EGGHOLDERSIMULATION or the handle to
%      the existing singleton*.
%
%      EGGHOLDERSIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EGGHOLDERSIMULATION.M with the given input arguments.
%
%      EGGHOLDERSIMULATION('Property','Value',...) creates a new EGGHOLDERSIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EggHolderSimulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EggHolderSimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EggHolderSimulation

% Last Modified by GUIDE v2.5 09-Dec-2018 21:39:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EggHolderSimulation_OpeningFcn, ...
                   'gui_OutputFcn',  @EggHolderSimulation_OutputFcn, ...
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


% --- Executes just before EggHolderSimulation is made visible.
function EggHolderSimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EggHolderSimulation (see VARARGIN)

% Choose default command line output for EggHolderSimulation
handles.output = hObject;
axes(handles.axes1); imshow('mtk.png');

axes(handles.axes2);
xlabel ('ITERATION(s)','FontSize',12,'FontWeight','bold','color','k');
ylabel ('VALUE','FontSize',12,'FontWeight','bold','color','k');
set(handles.axes2,'XColor','k');
set(handles.axes2,'YColor','k');
grid on;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EggHolderSimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = EggHolderSimulation_OutputFcn(hObject, eventdata, handles) 
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
tic; cla; grid on;
WarnWave = [sec(1:.15:500)];
Audio = audioplayer(WarnWave, 22050);
play(Audio);

set(handles.edit6,'String','');
set(handles.edit7,'String','');
set(handles.edit8,'String','');
set(handles.edit9,'String','');
set(handles.edit10,'String','');
set(handles.edit11,'String','');
set(handles.edit12,'String','');

pop = str2num(get(handles.edit1,'String'));
gen = str2num(get(handles.edit2,'String'));
pcross = str2num(get(handles.edit3,'String'));
pmut = str2num(get(handles.edit4,'String'));
max_Iteration = str2num(get(handles.edit5,'String'));

%% INITIALIZATION

x1 = generateEggHolderX(pop,gen);
x2 = generateEggHolderX(pop,gen);
x3 = generateEggHolderX(pop,gen);
x4 = generateEggHolderX(pop,gen);
x5 = generateEggHolderX(pop,gen);

x1val = bin2num(x1);
x2val = bin2num(x2);
x3val = bin2num(x3);
x4val = bin2num(x4);
x5val = bin2num(x5);

fitness = fitProb29fiveVar(bin2num(x1),bin2num(x2),bin2num(x3),bin2num(x4),bin2num(x5));

%% GENETIC ALGORITHM

for iterasi = 1:max_Iteration
    pause(0.01);
    set(handles.edit13,'String',num2str(iterasi));
    %% SELECTION %%
    x1new = selection_EggHolder(x1,fitness);
    x2new = selection_EggHolder(x2,fitness);
    x3new = selection_EggHolder(x3,fitness);
    x4new = selection_EggHolder(x4,fitness);
    x5new = selection_EggHolder(x5,fitness);

    %% CROSS OVER %%
    x1new = crossover_EggHolder(x1new,pcross);
    x2new = crossover_EggHolder(x2new,pcross);
    x3new = crossover_EggHolder(x3new,pcross);
    x4new = crossover_EggHolder(x4new,pcross);
    x5new = crossover_EggHolder(x5new,pcross);

    %% MUTATION %%
    x1new = mutation_EggHolder(x1new,pmut);
    x2new = mutation_EggHolder(x2new,pmut);
    x3new = mutation_EggHolder(x3new,pmut);
    x4new = mutation_EggHolder(x4new,pmut);
    x5new = mutation_EggHolder(x5new,pmut);

    %% NEW GENERATION %%   
    fitnessbaru = fitProb29fiveVar(bin2num(x1new),bin2num(x2new),bin2num(x3new),bin2num(x4new),bin2num(x5new));
    for i = 1:pop
        if fitnessbaru(i)>fitness(i)
            x1(i,:) = x1new(i,:);
            x2(i,:) = x2new(i,:);
            x3(i,:) = x3new(i,:);
            x4(i,:) = x4new(i,:);
            x5(i,:) = x5new(i,:); 
        end
        if fitnessbaru == fitness
            break; 
        end
    end
    fitness = fitProb29fiveVar(bin2num(x1),bin2num(x2),bin2num(x3),bin2num(x4),bin2num(x5));
    temp(iterasi) = max(fitness);
    posisi = find(fitness==max(fitness));
    tempx1(iterasi) = max(bin2num(x1(posisi(1),:)));
    tempx2(iterasi) = max(bin2num(x2(posisi(1),:)));
    tempx3(iterasi) = max(bin2num(x3(posisi(1),:)));
    tempx4(iterasi) = max(bin2num(x4(posisi(1),:)));
    tempx5(iterasi) = max(bin2num(x5(posisi(1),:)));
    plot(iterasi,temp(iterasi),'.','linewidth',1.5,'color','k'); hold on;
    plot(iterasi,tempx1(iterasi),'.','linewidth',1.5,'color','r'); hold on;
    plot(iterasi,tempx2(iterasi),'.','linewidth',1.5,'color','b'); hold on;
    plot(iterasi,tempx3(iterasi),'.','linewidth',1.5,'color','g'); hold on;
    plot(iterasi,tempx4(iterasi),'.','linewidth',1.5,'color','c'); hold on;
    plot(iterasi,tempx5(iterasi),'.','linewidth',1.5,'color','y'); hold on;
end

%% EVALUASI POPULASI
cla;
plot(1:max_Iteration,temp  ,'linewidth',1.5,'color','k'); hold on;
plot(1:max_Iteration,tempx1,'linewidth',1.5,'color','r'); hold on;
plot(1:max_Iteration,tempx2,'linewidth',1.5,'color','g'); hold on;
plot(1:max_Iteration,tempx3,'linewidth',1.5,'color','b'); hold on;
plot(1:max_Iteration,tempx4,'linewidth',1.5,'color','c'); hold on;
plot(1:max_Iteration,tempx5,'linewidth',1.5,'color','y'); hold on;
legend('fitness','x1','x2','x3','x4','x5');

result = find(fitness == max(fitness));
index = result(1);
fitness = -fitProb29fiveVar(bin2num(x1(index,:)),bin2num(x2(index,:)),bin2num(x3(index,:)),bin2num(x4(index,:)),bin2num(x5(index,:)));

set(handles.edit6,'String',num2str(bin2num(x1(index,:))));
set(handles.edit7,'String',num2str(bin2num(x2(index,:))));
set(handles.edit8,'String',num2str(bin2num(x3(index,:))));
set(handles.edit9,'String',num2str(bin2num(x4(index,:))));
set(handles.edit10,'String',num2str(bin2num(x5(index,:))));
set(handles.edit11,'String',num2str(fitness));
set(handles.edit12,'String',round(toc*1000)/1000);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');
set(handles.edit4,'String','');
set(handles.edit5,'String','');
set(handles.edit6,'String','');
set(handles.edit7,'String','');
set(handles.edit8,'String','');
set(handles.edit9,'String','');
set(handles.edit10,'String','');
set(handles.edit11,'String','');
set(handles.edit12,'String','');
set(handles.edit13,'String','');
cla;
legend('hide');

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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
