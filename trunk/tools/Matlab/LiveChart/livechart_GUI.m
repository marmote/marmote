function varargout = livechart_GUI(varargin)
% LIVECHART_GUI MATLAB code for livechart_GUI.fig
%      LIVECHART_GUI, by itself, creates a new LIVECHART_GUI or raises the existing
%      singleton*.
%
%      H = LIVECHART_GUI returns the handle to a new LIVECHART_GUI or the handle to
%      the existing singleton*.
%
%      LIVECHART_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIVECHART_GUI.M with the given input arguments.
%
%      LIVECHART_GUI('Property','Value',...) creates a new LIVECHART_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before livechart_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to livechart_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help livechart_GUI

% Last Modified by GUIDE v2.5 30-Nov-2011 08:35:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @livechart_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @livechart_GUI_OutputFcn, ...
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

%--------------------------------------------------------------------------
% --- Executes just before livechart_GUI is made visible.
function livechart_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to livechart_GUI (see VARARGIN)

% Choose default command line output for livechart_GUI
handles.output = hObject;


%BB begin
set(handles.uipanel1,'SelectionChangeFcn',@uipanel1_SelectionChangeFcn);
set(handles.uipanel3,'SelectionChangeFcn',@uipanel3_SelectionChangeFcn);
%BB end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes livechart_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%BB begin
    ResetConf(hObject);

    UpdateGUI(hObject);
%BB end



%--------------------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = livechart_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





%--------------------------------------------------------------------------
%
%                   Creation Callback functions
%
%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_IP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_refresh_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_refresh_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_RF_Gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RF_Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_RF_Gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_RF_Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_IQ_demod_fr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_IQ_demod_fr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_I_DC_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_I_DC_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_Q_DC_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_Q_DC_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_DDC_fr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_DDC_fr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_shift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function slider_shift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function edit_config_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%--------------------------------------------------------------------------
%
%                   Callback functions
%
%--------------------------------------------------------------------------

%BB begin
%--------------------------------------------------------------------------
function uipanel1_SelectionChangeFcn(hObject, eventdata)

    conf = LoadConf(hObject);
    
    switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
        case 'radiobutton_file'
            conf.source = 0; %0: file, 1: UDP

        case 'radiobutton_UDP'
            conf.source = 1; %0: file, 1: UDP

        otherwise
    end
    
    StoreConf(hObject, conf);    
    
    UpdateGUI(hObject);
%BB end    


%--------------------------------------------------------------------------
function edit_IP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_IP as text
%        str2double(get(hObject,'String')) returns contents of edit_IP as a double


%--------------------------------------------------------------------------
function edit_port_Callback(hObject, eventdata, handles)
% hObject    handle to edit_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_port as text
%        str2double(get(hObject,'String')) returns contents of edit_port as a double

%--------------------------------------------------------------------------
function edit_file_Callback(hObject, eventdata, handles)
% hObject    handle to edit_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_file as text
%        str2double(get(hObject,'String')) returns contents of edit_file as a double

%--------------------------------------------------------------------------
% --- Executes on button press in pushbutton_browse.
function pushbutton_browse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%--------------------------------------------------------------------------
% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    conf = LoadConf(hObject);
    conf.running = 1;
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    StartUDP(hObject);
    
    
%--------------------------------------------------------------------------
% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    conf = LoadConf(hObject);
    conf.running = 0;
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    StopUDP(hObject);
    
    
%--------------------------------------------------------------------------
% --- Executes on button press in checkbox_refresh_rate.
function checkbox_refresh_rate_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_refresh_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_refresh_rate
    conf = LoadConf(hObject);
    conf.en_rr = get(hObject, 'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    
%--------------------------------------------------------------------------
function edit_refresh_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_refresh_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_refresh_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_refresh_rate as a double


%BB begin
%--------------------------------------------------------------------------
function uipanel3_SelectionChangeFcn(hObject, eventdata)

    conf = LoadConf(hObject);
    
    switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
        case 'radiobutton_TX_RX'
            conf.Input = 0; %0: TX/RX, 1: RX

        case 'radiobutton_RX'
            conf.Input = 1; %0: TX/RX, 1: RX

        otherwise
    end
    
    StoreConf(hObject, conf);    
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);    
%BB end


%--------------------------------------------------------------------------
function edit_RF_Gain_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RF_Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RF_Gain as text
%        str2double(get(hObject,'String')) returns contents of edit_RF_Gain as a double
    conf = LoadConf(hObject);
    conf.RF_Gain = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    

%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_RF_Gain_Callback(hObject, eventdata, handles)
% hObject    handle to slider_RF_Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.RF_Gain = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    

%--------------------------------------------------------------------------
function edit_IQ_demod_fr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_IQ_demod_fr as text
%        str2double(get(hObject,'String')) returns contents of edit_IQ_demod_fr as a double
    conf = LoadConf(hObject);
    conf.IQ_demod_fr = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);

    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_IQ_demod_fr_Callback(hObject, eventdata, handles)
% hObject    handle to slider_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.IQ_demod_fr = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    
    
%--------------------------------------------------------------------------
function edit_I_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_DC_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_I_DC_offset as a double
    conf = LoadConf(hObject);
    conf.I_DC_offset = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
  
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_I_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to slider_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.I_DC_offset = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);

    
%--------------------------------------------------------------------------
function edit_Q_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q_DC_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_Q_DC_offset as a double
    conf = LoadConf(hObject);
    conf.Q_DC_offset = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
   
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_Q_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.Q_DC_offset = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    
    
%--------------------------------------------------------------------------
function edit_DDC_fr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_DDC_fr as text
%        str2double(get(hObject,'String')) returns contents of edit_DDC_fr as a double
    conf = LoadConf(hObject);
    conf.DDC_fr = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_DDC_fr_Callback(hObject, eventdata, handles)
% hObject    handle to slider_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.DDC_fr = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);

    
%--------------------------------------------------------------------------
function edit_shift_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shift as text
%        str2double(get(hObject,'String')) returns contents of edit_shift as a double
    conf = LoadConf(hObject);
    conf.Shift = str2double(get(hObject,'String'));
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);

    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_shift_Callback(hObject, eventdata, handles)
% hObject    handle to slider_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    conf = LoadConf(hObject);
    conf.Shift = get(hObject,'Value');
    StoreConf(hObject, conf);
    
    UpdateGUI(hObject);
    
    SendConfig(hObject);
    handles.conf.Shift = get(hObject,'Value');
    

%--------------------------------------------------------------------------
function edit_config_Callback(hObject, eventdata, handles)
% hObject    handle to edit_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_config as text
%        str2double(get(hObject,'String')) returns contents of edit_config as a double





%--------------------------------------------------------------------------
%
%                   Functions
%
%--------------------------------------------------------------------------
function UpdateGUI(hObject)
    CheckConf(hObject);

    handles = guidata(hObject);
    
    conf = LoadConf(hObject);
    
    %!!!!WARNING!!!! smallstep >= 1e-6 !!!!WARNING!!!!
    set(handles.slider_RF_Gain, 'Min', conf.RF_Gain_min);
    set(handles.slider_RF_Gain, 'Max', conf.RF_Gain_max);
%     smallstep = conf.RF_Gain_step/(conf.RF_Gain_max - conf.RF_Gain_min);
    smallstep = 1e-6;
    set(handles.slider_RF_Gain, 'SliderStep', [smallstep 10*smallstep]);
    set(handles.text_RF_Gain_min, 'String', conf.RF_Gain_min);
    set(handles.text_RF_Gain_max, 'String', conf.RF_Gain_max);    
    
    set(handles.slider_IQ_demod_fr, 'Min', conf.IQ_demod_fr_min);
    set(handles.slider_IQ_demod_fr, 'Max', conf.IQ_demod_fr_max);
    smallstep = conf.IQ_demod_fr_step/(conf.IQ_demod_fr_max - conf.IQ_demod_fr_min);
    set(handles.slider_IQ_demod_fr, 'SliderStep', [smallstep 10*smallstep]);
    set(handles.text_IQ_demod_fr_min, 'String', conf.IQ_demod_fr_min);
    set(handles.text_IQ_demod_fr_max, 'String', conf.IQ_demod_fr_max);
    
    set(handles.slider_I_DC_offset, 'Min', conf.I_DC_offset_min);
    set(handles.slider_I_DC_offset, 'Max', conf.I_DC_offset_max);
    smallstep = conf.I_DC_offset_step/(conf.I_DC_offset_max - conf.I_DC_offset_min);
    set(handles.slider_I_DC_offset, 'SliderStep', [smallstep 10*smallstep]);
    set(handles.text_I_DC_offset_min, 'String', conf.I_DC_offset_min);
    set(handles.text_I_DC_offset_max, 'String', conf.I_DC_offset_max);
    
    set(handles.slider_Q_DC_offset, 'Min', conf.Q_DC_offset_min);
    set(handles.slider_Q_DC_offset, 'Max', conf.Q_DC_offset_max);
    smallstep = conf.Q_DC_offset_step/(conf.Q_DC_offset_max - conf.Q_DC_offset_min);
    set(handles.slider_Q_DC_offset, 'SliderStep', [smallstep 10*smallstep]);
    set(handles.text_Q_DC_offset_min, 'String', conf.Q_DC_offset_min);
    set(handles.text_Q_DC_offset_max, 'String', conf.Q_DC_offset_max);
    
    set(handles.slider_DDC_fr, 'Min', conf.DDC_fr_min);
    set(handles.slider_DDC_fr, 'Max', conf.DDC_fr_max); 
    smallstep = conf.DDC_fr_step/(conf.DDC_fr_max - conf.DDC_fr_min);
    set(handles.slider_DDC_fr, 'SliderStep', [smallstep 10*smallstep]);
    set(handles.text_DDC_fr_min, 'String', conf.DDC_fr_min);
    set(handles.text_DDC_fr_max, 'String', conf.DDC_fr_max);
    
    set(handles.slider_shift, 'Min', conf.Shift_min);
    set(handles.slider_shift, 'Max', conf.Shift_max); 
    smallstep = conf.Shift_step/(conf.Shift_max - conf.Shift_min);
    set(handles.slider_shift, 'SliderStep', [smallstep 2*smallstep]);
    set(handles.text_shift_min, 'String', conf.Shift_min);
    set(handles.text_shift_max, 'String', conf.Shift_max);
    
    % Source
    if conf.source == 0 %file
        set(handles.radiobutton_file, 'Value', 1);
        set(handles.radiobutton_UDP, 'Value', 0);
    else %UDP
        set(handles.radiobutton_file, 'Value', 0);
        set(handles.radiobutton_UDP, 'Value', 1);
    end
    
    set(handles.edit_file,'String',conf.file);
    set(handles.edit_IP,'String',conf.IP);
    set(handles.edit_port,'String',num2str(conf.port));
    
    % Control
    set(handles.checkbox_refresh_rate,'Value',conf.en_rr);
    set(handles.edit_refresh_rate,'String',num2str(conf.refresh_rate));
    
    % Config
    if conf.Input == 0 %0: TX/RX, 1: RX
        set(handles.radiobutton_TX_RX, 'Value', 1);
        set(handles.radiobutton_RX, 'Value', 0);
    else %UDP
        set(handles.radiobutton_TX_RX, 'Value', 0);
        set(handles.radiobutton_RX, 'Value', 1);
    end    
    
    set(handles.edit_RF_Gain,'String',num2str(conf.RF_Gain));
    set(handles.slider_RF_Gain, 'Value', conf.RF_Gain);
    
    set(handles.edit_IQ_demod_fr,'String',num2str(conf.IQ_demod_fr));
    set(handles.slider_IQ_demod_fr, 'Value', conf.IQ_demod_fr);
    
    set(handles.edit_I_DC_offset,'String',num2str(conf.I_DC_offset));
    set(handles.slider_I_DC_offset, 'Value', conf.I_DC_offset);    
    
    set(handles.edit_Q_DC_offset,'String',num2str(conf.Q_DC_offset));
    set(handles.slider_Q_DC_offset, 'Value', conf.Q_DC_offset);
    
    set(handles.edit_DDC_fr,'String',num2str(conf.DDC_fr));
    set(handles.slider_DDC_fr, 'Value', conf.DDC_fr);
    
    set(handles.edit_shift,'String',num2str(conf.Shift));
    set(handles.slider_shift, 'Value', conf.Shift);
    
    
    temp = dec2hex([ ...
            uint8(conf.Input) ...
            typecast(swapbytes(uint32(conf.RF_Gain)), 'uint8') ...
            typecast(swapbytes(uint32(conf.IQ_demod_fr)), 'uint8') ...
            typecast(swapbytes(uint16(conf.I_DC_offset)), 'uint8') ...
            typecast(swapbytes(uint16(conf.Q_DC_offset)), 'uint8') ...
            typecast(swapbytes(uint32(conf.DDC_fr)), 'uint8') ...
            uint8(conf.Shift) ...
        ], 2);

    temp2 = [];
    for ii=1:size(temp,1)
        temp2 = [temp2 temp(ii,:)];
    end

    set(handles.edit_config,'String', temp2);

%Enable - Disable    
    if conf.source == 0 %file
        set(handles.edit_file,'Enable','on');
        set(handles.pushbutton_browse,'Enable','on');
        set(handles.edit_IP,'Enable','off');
        set(handles.edit_port,'Enable','off');
    else %UDP
        set(handles.edit_file,'Enable','off');
        set(handles.pushbutton_browse,'Enable','off');
        set(handles.edit_IP,'Enable','on');
        set(handles.edit_port,'Enable','on');
    end    

    if conf.running == 1
        set(handles.pushbutton_start,'Enable','off');
        set(handles.pushbutton_stop,'Enable','on');
        
        set(handles.radiobutton_file,'Enable','off');
        set(handles.edit_file,'Enable','off');
        set(handles.pushbutton_browse,'Enable','off');
        set(handles.radiobutton_UDP,'Enable','off');
        set(handles.edit_IP,'Enable','off');
        set(handles.edit_port,'Enable','off');
        
    else
        set(handles.pushbutton_start,'Enable','on');
        set(handles.pushbutton_stop,'Enable','off');
        
        set(handles.radiobutton_file,'Enable','off');
        set(handles.radiobutton_UDP,'Enable','on');
    end
    
    if conf.en_rr == 1
        set(handles.edit_refresh_rate,'Enable','on');
    else
        set(handles.edit_refresh_rate,'Enable','off');
    end
    
    
function CheckConf(hObject)

    conf = LoadConf(hObject);

    conf.RF_Gain = max(conf.RF_Gain, conf.RF_Gain_min);
    conf.RF_Gain = min(conf.RF_Gain, conf.RF_Gain_max);
    conf.RF_Gain = round(conf.RF_Gain/ conf.RF_Gain_step)*conf.RF_Gain_step;   

    conf.IQ_demod_fr = max(conf.IQ_demod_fr, conf.IQ_demod_fr_min);
    conf.IQ_demod_fr = min(conf.IQ_demod_fr, conf.IQ_demod_fr_max);
    conf.IQ_demod_fr = round(conf.IQ_demod_fr/ conf.IQ_demod_fr_step)*conf.IQ_demod_fr_step;   
    
    conf.I_DC_offset = max(conf.I_DC_offset, conf.I_DC_offset_min);
    conf.I_DC_offset = min(conf.I_DC_offset, conf.I_DC_offset_max);
    conf.I_DC_offset = round(conf.I_DC_offset/ conf.I_DC_offset_step)*conf.I_DC_offset_step;   

    conf.Q_DC_offset = max(conf.Q_DC_offset, conf.Q_DC_offset_min);
    conf.Q_DC_offset = min(conf.Q_DC_offset, conf.Q_DC_offset_max);
    conf.Q_DC_offset = round(conf.Q_DC_offset/ conf.Q_DC_offset_step)*conf.Q_DC_offset_step;   

    conf.DDC_fr = max(conf.DDC_fr, conf.DDC_fr_min);
    conf.DDC_fr = min(conf.DDC_fr, conf.DDC_fr_max);
    conf.DDC_fr = round(conf.DDC_fr/ conf.DDC_fr_step)*conf.DDC_fr_step;   
    
    conf.Shift = max(conf.Shift, conf.Shift_min);
    conf.Shift = min(conf.Shift, conf.Shift_max);
    conf.Shift = round(conf.Shift/ conf.Shift_step)*conf.Shift_step;  
    
    StoreConf(hObject, conf);    

    
function ResetConf(hObject)
    conf.fig_handle    = 0;
    conf.timerObject   = 0;
    conf.u             = 0;

    conf.running       = 0;

    conf.source        = 1; %0: file, 1: UDP
    conf.file          = 'log.txt';
    conf.IP            = '192.168.1.2';
    conf.port          = 49151;

    conf.en_rr         = 0; %0: disabled, 1: enabled
    conf.refresh_rate  = 10;
    
    
    conf.Input              = 1; %0: TX/RX, 1: RX
    
    conf.RF_Gain            = 0; 
    conf.RF_Gain_min        = 0; 
    conf.RF_Gain_max        = (2^24)-1; 
    conf.RF_Gain_step       = 1; 
    
    %ADF4360-7 (NCO)
    %   350 MHz <= ... <= 1800 MHz but the signal is divided in the mixer by 2 thus
    %   175 MHz <= ... <= 900 MHz
    
    %AD8348 (mixer)
    %   100 MHz <= ... <= 2000 MHz but the signal is divided in the mixer by 2 thus
    %   50 MHz <= ... <= 1000 MHz
    conf.IQ_demod_fr        = 433e6; % [Hz]
    conf.IQ_demod_fr_min    = 175e6/2; % [Hz]
    conf.IQ_demod_fr_max    = 900e6/2; % [Hz]
    conf.IQ_demod_fr_step   = 125e3; % [Hz]
    
    conf.I_DC_offset        = -1666; % 14bits signed
    conf.I_DC_offset_min    = -8192; 
    conf.I_DC_offset_max    = 8191;
    conf.I_DC_offset_step   = 1;

    conf.Q_DC_offset        = -219; % 14bits signed
    conf.Q_DC_offset_min    = -8192; 
    conf.Q_DC_offset_max    = 8191;
    conf.Q_DC_offset_step   = 1;
    
    % TODO: Figure out real limits
    conf.DDC_fr             = 5000; % [Hz]
    conf.DDC_fr_step        = 50e6/18/4/2^14; % [Hz]
    conf.DDC_fr_min         = round(-300e3/conf.DDC_fr_step)*conf.DDC_fr_step; % [Hz]
    conf.DDC_fr_max         = round(300e3/conf.DDC_fr_step)*conf.DDC_fr_step; % [Hz]
    
    conf.Shift             = 3;
    conf.Shift_step        = 1;
    conf.Shift_min         = 0;
    conf.Shift_max         = 11;

    StoreConf(hObject, conf);

    
function StoreConf(hObject, conf)
    handles = guidata(hObject);
    handles.conf = conf;
    guidata(hObject, handles);

    
function conf = LoadConf(hObject)
    handles = guidata(hObject);
    conf = handles.conf;
    

function StartUDP(hObject)
    conf = LoadConf(hObject);

    if conf.running == 0 %Because at this point running status is alread set
        return;
    end
    
    DSPconf = GetDSPConfig();
    
    conf.u = OpenUDP( conf.IP, conf.port, 10 * DSPconf.BUFF_LENGTH * 32/8 );
    
    if conf.en_rr == 0
        Period = 0;
    else
        Period = 1/conf.refresh_rate;
    end
    Period = max(0.001, Period);
    
    conf.timerObject = timer('TimerFcn',{@TimerCallback, hObject},...
                        'ExecutionMode','fixedRate',...
                        'Period', Period);
    
    conf.fig_handle = figure;
    
    StoreConf(hObject, conf);
    
    SendConfig(hObject);

    start(conf.timerObject);
       

function StopUDP(hObject)
    conf = LoadConf(hObject);

    if conf.running == 1 %Because at this point running status is alread set
        return;
    end
    
    stop(conf.timerObject);
%    wait(conf.timerObject);
    delete(conf.timerObject);
    conf.timerObject = 0;
    
    CloseUDP( conf.u );
    conf.u = 0;
    
    StoreConf(hObject, conf);
    
    
function TimerCallback(obj, event, hObject)
    persistent TS_history

    conf = LoadConf(hObject);
    
    DSPconf = GetDSPConfig();
    
    DSPconf.F_offset = conf.IQ_demod_fr - conf.DDC_fr; 
    
    chunk = ReadBuffer( conf.u, DSPconf );
    
    [ TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft ] = processing( DSPconf, chunk, TS_history );

    drawchart( conf.fig_handle, DSPconf, TS, TS_history, chunk1, chunk2, chunk1fft, chunk2fft, chunkfft);

    
function SendConfig(hObject)
    conf = LoadConf(hObject);
    
    if conf.u == 0
        return;
    end
    
    WriteConfig( conf.u, conf.Input, conf.RF_Gain, conf.IQ_demod_fr, conf.I_DC_offset, conf.Q_DC_offset, conf.DDC_fr, conf.Shift );




