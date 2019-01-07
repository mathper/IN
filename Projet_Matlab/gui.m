function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 06-Jan-2019 16:40:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;


handles.mpic=uimenu('Label','Images','Callback', {@Open_Images_Callback});
handles.mpic=uimenu('Label','Références','Callback', {@Open_Masks_Callback});

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Open_Images.
function Open_Images_Callback(hObject, eventdata, handles)
% hObject    handle to Open_Images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles=guidata(hObject);

% Open file selection dialog box
[Filename,PathName]=uigetfile('../images/*.png','Sélectionner une image');

if (Filename ~= 0)
    set(handles.save,'Enable','off');
    
    handles.file='image';
    
    clear handles.Images;
    
    % Reset plot
    cla(handles.c1c2c3_img,'reset');
    cla(handles.seg_img,'reset');
    cla(handles.bounding_rec,'reset');
    cla(handles.mask,'reset');
    
    set(handles.c1c2c3_img,'visible','off');
    set(handles.seg_img,'visible','off');
    set(handles.bounding_rec,'visible','off');
    set(handles.mask,'visible','off');
    
    set(handles.nb_detection, 'String', ['']);
    set(handles.w_detection, 'String', ['']);
    set(handles.n_detection, 'String', ['']);
    
    % Display
    handles.Images.Original=imread(fullfile(PathName, Filename));
    
    handles.f_size = 1000/size(handles.Images.Original,1);
    imshow(imresize(handles.Images.Original, handles.f_size),'Parent',handles.orig_img);
    title(handles.orig_img, 'Image aérienne');
    
    handles.filename=Filename(1:end-4);

    set(handles.start,'Enable','on');
    
end

guidata(hObject,handles);

% --- Executes on button press in Open_Images.
function Open_Masks_Callback(hObject, eventdata, handles)
% hObject    handle to Open_Images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles=guidata(hObject);

% Open file selection dialog box
[Filename,PathName]=uigetfile('../references/*.png','Sélectionner une image de référence');

if (Filename ~= 0)
    set(handles.save,'Enable','off');
    
    %Verifie si l'image selectionnée est bien une image de référence
    if(isfile(['../references/masks/' Filename(1:end-4) '_m.png']))
    
        clear handles.Images;

        handles.file='ref';

        % Reset plot
        cla(handles.c1c2c3_img,'reset');
        cla(handles.seg_img,'reset');
        cla(handles.bounding_rec,'reset');
        cla(handles.mask,'reset');

        set(handles.c1c2c3_img,'visible','off');
        set(handles.seg_img,'visible','off');
        set(handles.bounding_rec,'visible','off');
        set(handles.mask,'visible','off');

        set(handles.nb_detection, 'String', ['']);
        set(handles.w_detection, 'String', ['']);
        set(handles.n_detection, 'String', ['']);

        % Display
        handles.Images.Original=imread(['../images/' Filename]);
        ref_img=imread(['../references/' Filename]);
        handles.Images.ref_mask=imread(['../references/masks/' Filename(1:end-4) '_m.png']);

        handles.f_size = 1000/size(handles.Images.Original,1);
        imshow(imresize(handles.Images.Original, handles.f_size),'Parent',handles.orig_img);
        title(handles.orig_img, 'Image originale');

        imshow(imresize(ref_img, handles.f_size),'Parent',handles.c1c2c3_img);
        title(handles.c1c2c3_img, 'Image de référence');

        imshow(imresize(handles.Images.ref_mask, handles.f_size),'Parent',handles.mask);
        title(handles.mask, 'Masque de référence');

        set(handles.start,'Enable','on');
    
    else
        f = msgbox('L''image selectionnée n''est pas une image de référence.');
    end
end

guidata(hObject,handles);


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(strcmp(handles.file,'image'))
    start_process(hObject);
    set(handles.save,'Enable','on');
else
    checkWithReference(hObject);
end
    


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fid = fopen(['bounding_boxes/' handles.filename '.txt'], 'wt');
for i=1:size(handles.boxes,1)
    fprintf(fid, '%d %d %d %d\n', handles.boxes(i).BoundingBox);
end
fclose(fid);
set(handles.save,'Enable','off');