function varargout = radarSimulation(varargin)
% RADARSIMULATION M-file for radarSimulation.fig
%      RADARSIMULATION, by itself, creates a new RADARSIMULATION or raises the existing
%      singleton*.
%
%      H = RADARSIMULATION returns the handle to a new RADARSIMULATION or the handle to
%      the existing singleton*.
%
%      RADARSIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADARSIMULATION.M with the given input
%      arguments.
%
%      RADARSIMULATION('Property','Value',...) creates a new RADARSIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before radarSimulation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to radarSimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help radarSimulation

% Last Modified by GUIDE v2.5 15-Mar-2008 11:30:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @radarSimulation_OpeningFcn, ...
                   'gui_OutputFcn',  @radarSimulation_OutputFcn, ...
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


% --- Executes just before radarSimulation is made visible.
function radarSimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to radarSimulation (see VARARGIN)

% Choose default command line output for radarSimulation
handles.output = hObject;
handles.FOV = [];
handles.mountains = [];
handles.IF_Freq = 3e7;    
handles.currentTime = 0;
handles.targetsFigure = [];
handles.Targets = [];
handles.pulseNum = 0;
handles.plotedTargets = [];
plotDistLines(handles.radarDisplay,10);

PW_Callback(handles.PW, eventdata, handles);    % updating the current PW value

% Update handles structure
guidata(hObject, handles);
reset_Callback(hObject, eventdata, handles)

% UIWAIT makes radarSimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = radarSimulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function PRI_Callback(hObject, eventdata, handles)
% hObject    handle to PRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PRI as text
%        str2double(get(hObject,'String')) returns contents of PRI as a double


% --- Executes during object creation, after setting all properties.
function PRI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ZSA_Callback(hObject, eventdata, handles)
% hObject    handle to ZSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZSA as text
%        str2double(get(hObject,'String')) returns contents of ZSA as a double


% --- Executes during object creation, after setting all properties.
function ZSA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function PW_Callback(hObject, eventdata, handles)
    percent = get(hObject,'value');
    str = ['PW = ' num2str(percent*100) '% of the PRI'];
    set(handles.PWstr,'string',str);
% hObject    handle to PW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function PW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
    switch get(hObject,'string')
        case 'Pause'
            set(hObject,'string', 'Continue','value',0);
            return;
        case  'Start' 
            handles.currentTime = 0;
            handles = createTargets(hObject,handles);
            set(hObject,'string', 'Pause');
            handles.FOV = [];
            handles.persistentPlotHandle = [];
            handles.pulseNum = 1;
            guidata(hObject, handles);
            plotDistLines(handles.radarDisplay,10);
            set(handles.nTargets,'enable','off');
            set(handles.nMountains,'enable','off');
            set(handles.RCS,'enable','off');
%             set(handles.bufferAnalyze,'enable','on');
            handles.numRadarTurn = 0;
        case 'Continue'
            set(hObject,'string', 'Pause','value',1);
    end
    Th_Callback(handles.Th, eventdata, handles);
    PW_Callback(handles.PW, eventdata, handles);   
    runRadarSim_v2(handles);

    
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function bufferSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bufferSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Amp_Callback(hObject, eventdata, handles)
% hObject    handle to Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amp as text
%        str2double(get(hObject,'String')) returns contents of Amp as a double


% --- Executes during object creation, after setting all properties.
function Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Th_Callback(hObject, eventdata, handles)
    Th = get(hObject,'value');
    if get(handles.CFAR,'value')
        str = ['Relative Th = ' num2str(Th)];
    else
        str = ['Absolute Th = ' num2str(10^(Th))];
    end
    set(handles.ThStr,'string',str);
% hObject    handle to Th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Th as text
%        str2double(get(hObject,'String')) returns contents of Th as a double


% --- Executes during object creation, after setting all properties.
function Th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function updateRate_Callback(hObject, eventdata, handles)
% hObject    handle to updateRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of updateRate as text
%        str2double(get(hObject,'String')) returns contents of updateRate as a double


% --- Executes during object creation, after setting all properties.
function updateRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to updateRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in recieveChannelBWType.
function recieveChannelBWType_Callback(hObject, eventdata, handles)
% hObject    handle to recieveChannelBWType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns recieveChannelBWType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from recieveChannelBWType


% --- Executes during object creation, after setting all properties.
function recieveChannelBWType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recieveChannelBWType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function RadarBW_Callback(hObject, eventdata, handles)
% hObject    handle to RadarBW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RadarBW as text
%        str2double(get(hObject,'String')) returns contents of RadarBW as a double


% --- Executes during object creation, after setting all properties.
function RadarBW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RadarBW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end






function samplingRate_Callback(hObject, eventdata, handles)
% hObject    handle to samplingRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingRate as text
%        str2double(get(hObject,'String')) returns contents of samplingRate as a double


% --- Executes during object creation, after setting all properties.
function samplingRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function antenaAperture_Callback(hObject, eventdata, handles)
% hObject    handle to antenaAperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antenaAperture as text
%        str2double(get(hObject,'String')) returns contents of antenaAperture as a double


% --- Executes during object creation, after setting all properties.
function antenaAperture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antenaAperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function antenaMode_Callback(hObject, eventdata, handles)
% hObject    handle to antenaMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antenaMode as text
%        str2double(get(hObject,'String')) returns contents of antenaMode as a double


% --- Executes during object creation, after setting all properties.
function antenaMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antenaMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function edit9_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
    set(handles.run,'value',0);
    set(handles.run,'string','Start');
    h = findobj(handles.radarDisplay,'type','line');
    if ishandle(h) delete(h); end
    h = findobj(handles.radarDisplay,'type','text');
    if ishandle(h) delete(h); end
    handles.mountains = [];
    handles.foundTargets = createTargetObj( {},{},{},{},{},{},{},{},{},{} );  % creating an empty object
    guidata(hObject,handles);
    handleRadarControlls(handles,'on');
    set(handles.nTargets,'enable','on');
    set(handles.nMountains,'enable','on');
%     set(handles.bufferAnalyze,'enable','off');
%     set(handles.bufferAnalyze,'value',0);
    set(handles.RCS,'enable','on');
    set(handles.soundOn,'value',0);
    soundOn_Callback(handles.soundOn, eventdata, handles)
    set(handles.scopeDisplay,'value',0);
    scopeDisplay_Callback(handles.scopeDisplay, eventdata, handles)
    ind = get(handles.backgrundColor,'value');
    color = zeros(1,3);
    color(ind+1) = 0.502;
    set(handles.radarDisplay,'color',color);
    set(gca,'xlim',[-100 100]*1e3, 'ylim', [-100 100]*1e3);    
    grid on;
    
    plotDistLines(handles.radarDisplay,10);
    
    
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nTargets_Callback(hObject, eventdata, handles)
% hObject    handle to nTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nTargets as text
%        str2double(get(hObject,'String')) returns contents of nTargets as a double


% --- Executes during object creation, after setting all properties.
function nTargets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in RCS.
function RCS_Callback(hObject, eventdata, handles)
% hObject    handle to RCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RCS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RCS


% --- Executes during object creation, after setting all properties.
function RCS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in useMatchFilter.
function useMatchFilter_Callback(hObject, eventdata, handles)
% hObject    handle to useMatchFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of useMatchFilter


% --- Executes during object creation, after setting all properties.
function useMatchFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to useMatchFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes during object creation, after setting all properties.
function radarDisplay_CreateFcn(hObject, eventdata, handles)
    grid on;
% hObject    handle to radarDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate radarDisplay




% --- Executes on button press in placeMaountins.
function placeMaountins_Callback(hObject, eventdata, handles)
    if get(hObject,'value') %placing mountains
        set(handles.run,'visible','off');
        set(handles.bufferAnalyze,'visible','off');
        set(hObject,'FontWeight','bold','FontSize',10);
        title(handles.radarDisplay,'click on display to place mountains');
        hold on;
        set(gcf,'userdata',handles);
        str = ['temp = get(gca,''CurrentPoint''); h=placeClutter(get(gcf,''userdata''),temp(1,1:2)); ' ...
        'set(gcf,''userdata'',h); plot(temp(1,1),temp(1,2),''*k'',''MarkerSize'',10,''tag'',''mountain'');'];
        set(handles.radarDisplay,'buttondownfcn',str);
    else    % finished placing mountains
        set(handles.run,'visible','on');
        set(handles.bufferAnalyze,'visible','on');
        hold off;
         set(hObject,'FontWeight','normal','FontSize',8);
        title(handles.radarDisplay,[]);
        h = findobj(handles.radarDisplay,'tag','mountain');
        delete(h);
        set(handles.radarDisplay,'buttondownfcn',[]);
        guidata(hObject, handles);
        
    end
        
% hObject    handle to placeMaountins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of placeMaountins





% --- Executes on button press in useMTI.
function useMTI_Callback(hObject, eventdata, handles)



% --- Executes on button press in displayTargets.
function displayTargets_Callback(hObject, eventdata, handles)
    displayTargets(handles,'in diffrent figure')
% hObject    handle to displayTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of displayTargets





function digitizerNoiseLevel_Callback(hObject, eventdata, handles)
% hObject    handle to digitizerNoiseLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of digitizerNoiseLevel as text
%        str2double(get(hObject,'String')) returns contents of digitizerNoiseLevel as a double


% --- Executes during object creation, after setting all properties.
function digitizerNoiseLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to digitizerNoiseLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in bufferAnalyze.
function bufferAnalyze_Callback(hObject, eventdata, handles)
    set(handles.run,'value',1);
    run_Callback(handles.run, eventdata, handles)
% hObject    handle to bufferAnalyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in waitForTarget.
function waitForTarget_Callback(hObject, eventdata, handles)
% hObject    handle to waitForTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of waitForTarget




% --- Executes on selection change in backgrundColor.
function backgrundColor_Callback(hObject, eventdata, handles)
% hObject    handle to backgrundColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns backgrundColor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from backgrundColor


% --- Executes during object creation, after setting all properties.
function backgrundColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backgrundColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on selection change in RFnoise.
function RFnoise_Callback(hObject, eventdata, handles)
% hObject    handle to RFnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RFnoise contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RFnoise


% --- Executes during object creation, after setting all properties.
function RFnoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in CFAR.
function CFAR_Callback(hObject, eventdata, handles)
    if get(hObject,'value')
        % using relative threshold
        set(handles.Th,'min',1.1,'max',10,'value',2);
        Th_Callback(handles.Th, eventdata, handles);
    else
        % using absolute threshold
        set(handles.Th,'min',-20,'max',-1,'value',-9);
        Th_Callback(handles.Th, eventdata, handles);
    end


% --- Executes on selection change in nMountains.
function nMountains_Callback(hObject, eventdata, handles)
% hObject    handle to nMountains (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns nMountains contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nMountains


% --- Executes during object creation, after setting all properties.
function nMountains_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nMountains (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on selection change in stagger.
function stagger_Callback(hObject, eventdata, handles)
% hObject    handle to stagger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stagger contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stagger


% --- Executes during object creation, after setting all properties.
function stagger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stagger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



% --- Executes on button press in playSound.
function playSound_Callback(hObject, eventdata, handles)
% hObject    handle to playSound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of playSound


% --- Executes on button press in soundOn.
function soundOn_Callback(hObject, eventdata, handles)
    val = get(hObject,'value');
    if val
        field = 'soundOnIcon';
    else
        field = 'soundOffIcon';
    end
    icon = getappdata(hObject,field);
    set(hObject,'units','pixels');
    pos = get(hObject,'position');
    set(hObject,'units','normalized');
    icon = imresize( icon,[pos(4) pos(3)] );
    set( hObject,'cdata',icon );
    
% hObject    handle to soundOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of soundOn




% --- Executes during object creation, after setting all properties.
function soundOn_CreateFcn(hObject, eventdata, handles)
    if exist('soundOn.jpg','file') & exist('soundOff.jpg','file');
        % both icon files exist
        soundOnIcon = imread('soundOn.jpg');
        soundOffIcon = imread('soundOff.jpg');
        setappdata(hObject,'soundOnIcon',soundOnIcon);
        setappdata(hObject,'soundOffIcon',soundOffIcon);
        set(hObject,'cdata',soundOffIcon, 'value',0);
        soundOn_Callback(hObject, eventdata, handles)
    else
        set(hObject,'enable','off');
    end
% hObject    handle to soundOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in scopeDisplay.
function scopeDisplay_Callback(hObject, eventdata, handles)
    val = get(hObject,'value');
    if val
        field = 'scopeOnIcon';
    else
        field = 'scopeOffIcon';
    end
    icon = getappdata(hObject,field);
    set(hObject,'units','pixels');
    pos = get(hObject,'position');
    set(hObject,'units','normalized');
    icon = imresize( icon,[pos(4) pos(3)] );
    set( hObject,'cdata',icon );
% hObject    handle to scopeDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of scopeDisplay


% --- Executes during object creation, after setting all properties.
function scopeDisplay_CreateFcn(hObject, eventdata, handles)
    if exist('ociloscopeOn.jpg','file') & exist('ociloscopeOff.jpg','file');
        % both icon files exist
        scopeOnIcon = imread('ociloscopeOn.jpg');
        scopeOffIcon = imread('ociloscopeOff.jpg');
        setappdata(hObject,'scopeOnIcon',scopeOnIcon);
        setappdata(hObject,'scopeOffIcon',scopeOffIcon);
        set(hObject,'cdata',scopeOffIcon, 'value',0);
        scopeDisplay_Callback(hObject, eventdata, handles)
    else
        set(hObject,'enable','off');
    end
% hObject    handle to scopeDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in persistentDisplay.
function persistentDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to persistentDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of persistentDisplay




% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


