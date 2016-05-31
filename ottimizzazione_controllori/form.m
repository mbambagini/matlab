function varargout = form(varargin)
% FORM M-file for form.fig
%      FORM, by itself, creates a new FORM or raises the existing
%      singleton*.
%
%      H = FORM returns the handle to a new FORM or the handle to
%      the existing singleton*.
%
%      FORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORM.M with the given input arguments.
%
%      FORM('Property','Value',...) creates a new FORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before form_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to form_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help form
% Last Modified by GUIDE v2.5 09-Mar-2008 13:42:21

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @form_OpeningFcn, ...
                       'gui_OutputFcn',  @form_OutputFcn, ...
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

% --- Executes just before form is made visible.
function form_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to form (see VARARGIN)
% Choose default command line output for form
    handles.output = handles;
% Update handles structure
    guidata(hObject, handles);
% UIWAIT makes form wait for user response (see UIRESUME)
% uiwait(handles.figure1);
    %carico Figura 1 e Figura 2
    boot_immagini(handles);
    %interpreto il parametro in input e lo rendo globale
    global num den plant;
    [num, den] = tfdata(varargin{1},'v');
    plant = varargin{2};
%    global sys_rid;
%    sys_rid = 1;

%--------------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = form_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
    varargout{1} = handles.output;
%    global sys_rid;
%    varargout{2} = sys_rid;

%--------------------------------------------------------------------------

% carica un'immagine, con path indicato da 'file', in 'oggetto'
function carica_immagine ( oggetto, file )
    immagine = imread( file ); %legge l'immagine
    set( oggetto , 'HandleVisibility', 'OFF');
    set( oggetto, 'HandleVisibility', 'ON');
    axes(oggetto);
    image(immagine); %stampa l'immagine a video
    axis equal;
    axis tight;
    axis off;
    set(oggetto,'HandleVisibility','OFF');

%--------------------------------------------------------------------------

% carica le immagini nella gui
function boot_immagini ( handles )
    carica_immagine ( handles.sistema, 'sistema.png' );
    carica_immagine ( handles.formula, 'formula.png' );    
    carica_immagine ( handles.funzione, 'funzione.png' );    

%--------------------------------------------------------------------------

% Effettua il calcolo del minimo
function bottone_calcolo_Callback(hObject, eventdata, handles)
% ############################# Fase di input #############################
    %leggo i valori da cui iniziare la ricerca (a, k, b, c)
    a_ini = str2double(get(handles.edit_a, 'String'));
    k_ini = str2double(get(handles.edit_k, 'String'));
    b_ini = str2double(get(handles.edit_b, 'String'));
    c_ini = str2double(get(handles.edit_c, 'String'));
    %leggo la banda (wn)
    wn = str2double(get(handles.edit_wn, 'String'));
    %leggo i valori di lower e upper bound
    lb = str2double(get(handles.edit_min, 'String'));
    ub = str2double(get(handles.edit_max, 'String'));
    %leggo il numero massimo di iterazioni
    max_iter = str2double(get(handles.edit_cicli, 'String'));
    %leggo il numero massimo di valutazioni
    max_val = str2double(get(handles.edit_val, 'String'));
    %leggo la tolleranza sulle y
    tol_y = str2double(get(handles.edit_toly, 'String'));
    %leggo la tolleranza sulle y
    tol_x = str2double(get(handles.edit_tolx, 'String'));
    %leggo la tolleranza sui vincoli (condizioni)
    tol_con = str2double(get(handles.edit_con, 'String'));
% ######################### Fase di elaborazione #########################
    %rendo visibili num e den della funzione da approssimare
    global num den
    %calcolo i valori di a, k, b, c che minimizzano la funzione obiettivo
    [a, k, b, c, stato] = codice(a_ini, k_ini, b_ini, c_ini, wn, num, den, lb, ub, max_iter, tol_y, tol_x, tol_con, max_val );
    set(handles.ris_alg, 'String', interpreta_stato(stato));
% ############################ Fase di output ############################
    %stampo i valori ottimi
    set(handles.edit_a_opt, 'String', num2str(a));
    set(handles.edit_k_opt, 'String', num2str(k));
    set(handles.edit_b_opt, 'String', num2str(b));
    set(handles.edit_c_opt, 'String', num2str(c));
    %creo la funzione approssimata
    global sys_rid;
    sys_rid = interpreta_risultato (a, k, b, c, lb, ub, str2double(get(handles.edit_appr, 'String')));
    display 'Approssimazione:';
    sys_rid

%--------------------------------------------------------------------------

%crea la funzione approssimata
function sys = interpreta_risultato (a, k, b, c, lb, ub, appr)
    poli = [];
    zeri = [];
    if abs(b-c) >= appr % non sono vicini, oppure non sono entrambi lb o ub
       zeri = [ -b ];
       poli = [ -c ];
    end
    if a ~= ub %se 1/s*a non è trascurabile
       zeri = [  -1/a zeri ];
       poli = [ 0 poli ];
    end
    sys = zpk(zeri, poli, k);

%--------------------------------------------------------------------------

%associa un commento al risultato dell'algoritmo
function messaggio = interpreta_stato ( exitflag )
    switch exitflag
        case 0
            messaggio = '0 : Si è superato il numero massimo di iterazioni o il numero massimo di valutazioni della funzione prima di trovare l''ottimo';
        case 1
            messaggio = '1 : Ottimi trovati e le condizioni del primo ordine rispettano la tolleranza';
        case 2
            messaggio = '2 : La variazione di x è inferiore alla tolleranza specificata (options.TolX)';
        case 3
            messaggio = '3 : La variazione della funzione obiettivo non è più inferiore alla rispettiva tolleranza';
        case 4
            messaggio = '4 : L''ordine di grandezza della direzione di ricerca non è più inferiore alla rispettiva tolleranza e la violazione dei vincoli non è più inferiore alla tolleranza sulle condizioni';
        case 5
            messaggio = '5 : L''ordine di grandezza della direzione derivativa non è più inferiore alla rispettiva tolleranza e la violazione dei vincoli non è più inferiore alla tolleranza sulle condizioni';
        case -1
            messaggio = '-1: L''Algoritmo è terminato per la funzione di output';
        case -2
            messaggio = '-2: Non sono stati trovati punti validi';
    end

%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in siso_orig.
function siso_orig_Callback(hObject, eventdata, handles)
% hObject    handle to siso_orig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global plant num den;
    sisotool(tf(num,den),plant);

% --- Executes on button press in siso_appx.
function siso_appx_Callback(hObject, eventdata, handles)
% hObject    handle to siso_appx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global plant sys_rid;
    sisotool(sys_rid,plant);
