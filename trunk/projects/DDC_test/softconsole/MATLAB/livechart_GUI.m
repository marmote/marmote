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

% Last Modified by GUIDE v2.5 24-Nov-2011 15:59:56

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
%BB end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes livechart_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%BB begin
    ResetConf(handles);

    UpdateGUI(handles);
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

    %retrieve GUI data, i.e. the handles structure
    handles = guidata(hObject); 

    conf = LoadConf(handles);
    
    switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
        case 'radiobutton_file'
            conf.source = 0; %0: file, 1: UDP

        case 'radiobutton_UDP'
            conf.source = 1; %0: file, 1: UDP

        otherwise
    end
    
    StoreConf(handles, conf);    
    
    UpdateGUI(handles);
    
    %updates the handles structure
   %guidata(hObject, handles);
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
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.running = 1;
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.running = 0;
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on button press in checkbox_refresh_rate.
function checkbox_refresh_rate_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_refresh_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_refresh_rate
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.en_rr = get(handles.checkbox_refresh_rate, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
function edit_refresh_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_refresh_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_refresh_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_refresh_rate as a double

%--------------------------------------------------------------------------
function edit_IQ_demod_fr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_IQ_demod_fr as text
%        str2double(get(hObject,'String')) returns contents of edit_IQ_demod_fr as a double
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.IQ_demod_fr = str2double(get(handles.edit_IQ_demod_fr, 'String'));
    StoreConf(handles, conf);
    
    UpdateGUI(handles);

    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_IQ_demod_fr_Callback(hObject, eventdata, handles)
% hObject    handle to slider_IQ_demod_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.IQ_demod_fr = get(handles.slider_IQ_demod_fr, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
function edit_I_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_DC_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_I_DC_offset as a double
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.I_DC_offset = str2double(get(handles.edit_I_DC_offset, 'String'));
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_I_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to slider_I_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.I_DC_offset = get(handles.slider_I_DC_offset, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
function edit_Q_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q_DC_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_Q_DC_offset as a double
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.Q_DC_offset = str2double(get(handles.edit_Q_DC_offset, 'String'));
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_Q_DC_offset_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Q_DC_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.Q_DC_offset = get(handles.slider_Q_DC_offset, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
function edit_DDC_fr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_DDC_fr as text
%        str2double(get(hObject,'String')) returns contents of edit_DDC_fr as a double
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.DDC_fr = str2double(get(handles.edit_DDC_fr, 'String'));
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_DDC_fr_Callback(hObject, eventdata, handles)
% hObject    handle to slider_DDC_fr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.DDC_fr = get(handles.slider_DDC_fr, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
function edit_shift_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shift as text
%        str2double(get(hObject,'String')) returns contents of edit_shift as a double
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.Shift = str2double(get(handles.edit_shift, 'String'));
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    
    
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function slider_shift_Callback(hObject, eventdata, handles)
% hObject    handle to slider_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    handles = guidata(hObject); 
    
    conf = LoadConf(handles);
    conf.Shift = get(handles.slider_shift, 'Value');
    StoreConf(handles, conf);
    
    UpdateGUI(handles);
    

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
function UpdateGUI(handles)

    CheckConf(handles);
    conf = LoadConf(handles);
    
    set(handles.slider_IQ_demod_fr, 'Min', conf.IQ_demod_fr_min);
    set(handles.slider_IQ_demod_fr, 'Max', conf.IQ_demod_fr_max);
    
    set(handles.slider_I_DC_offset, 'Min', conf.I_DC_offset_min);
    set(handles.slider_I_DC_offset, 'Max', conf.I_DC_offset_max);
    
    set(handles.slider_Q_DC_offset, 'Min', conf.Q_DC_offset_min);
    set(handles.slider_Q_DC_offset, 'Max', conf.Q_DC_offset_max);

    set(handles.slider_DDC_fr, 'Min', conf.DDC_fr_min);
    set(handles.slider_DDC_fr, 'Max', conf.DDC_fr_max); 
    
    set(handles.slider_shift, 'Min', conf.Shift_min);
    set(handles.slider_shift, 'Max', conf.Shift_max); 
    
    
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
    
    
    temp = dec2hex([ typecast(swapbytes(uint32(conf.IQ_demod_fr)), 'uint8') ...
        typecast(swapbytes(uint16(conf.I_DC_offset)), 'uint8') ...
        typecast(swapbytes(uint16(conf.Q_DC_offset)), 'uint8') ...
        typecast(swapbytes(uint32(conf.DDC_fr)), 'uint8') ...
        uint8(conf.Shift) ], 2);

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
    else
        set(handles.pushbutton_start,'Enable','on');
        set(handles.pushbutton_stop,'Enable','off');
    end
    
    if conf.en_rr == 1
        set(handles.edit_refresh_rate,'Enable','on');
    else
        set(handles.edit_refresh_rate,'Enable','off');
    end
    
    
function CheckConf(handles)

    conf = LoadConf(handles);

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
    
    StoreConf(handles, conf);    

    
function ResetConf(handles)
    conf.running       = 0;

    conf.source        = 0; %0: file, 1: UDP
    conf.file          = 'log.txt';
    conf.IP            = '192.168.1.2';
    conf.port          = 49151;

    conf.en_rr         = 0; %0: disabled, 1: enabled
    conf.refresh_rate  = 10;
    
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
    
    conf.I_DC_offset        = 11; % 14bits signed
    conf.I_DC_offset_min    = -8192; 
    conf.I_DC_offset_max    = 8191;
    conf.I_DC_offset_step   = 1;

    conf.Q_DC_offset        = 11; % 14bits signed
    conf.Q_DC_offset_min    = -8192; 
    conf.Q_DC_offset_max    = 8191;
    conf.Q_DC_offset_step   = 1;
    
    % TODO: Figure out real limits
    conf.DDC_fr             = 5000; % [Hz]
    conf.DDC_fr_step        = 50e6/18/4/2^14; % [Hz]
    conf.DDC_fr_min         = round(-700e3/conf.DDC_fr_step)*conf.DDC_fr_step; % [Hz]
    conf.DDC_fr_max         = round(700e3/conf.DDC_fr_step)*conf.DDC_fr_step; % [Hz]
    
    conf.Shift             = 3;
    conf.Shift_step        = 1;
    conf.Shift_min         = 0;
    conf.Shift_max         = 11;

    StoreConf(handles,conf);

    
function StoreConf(handles, conf)
    setappdata(handles.pushbutton_browse,'ConfigData',conf);

    
function conf = LoadConf(handles)
    conf = getappdata(handles.pushbutton_browse,'ConfigData');
    
