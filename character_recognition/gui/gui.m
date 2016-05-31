function varargout = gui(varargin)
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
  handles.output = hObject;
  guidata(hObject, handles);
  global immOriginal; %this variable conteins the original loaded image
  global immWork; %this variable conteins the 'work in progress' image
  global immNN; %this variable conteins the image for the neural network
  global net netOk; %variables according to neural network
  global NNfolder; %folder with neural network files
  global fileNet fileImage; %that variables indicate the actual image and 
                            %network files that are used
  NNfolder='./nns/';
  fileNet='';
  fileImage='';
  immOriginal=0;
  immWork=0;
  immNN=0;
  netOk=0;
  file_list=getFileList( NNfolder );
  set(handles.netList, 'String', file_list);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
  varargout{1} = handles.output;

% --- Showes immWork and immNN in the axes areas
function printImage(handles)
  global immWork immNN;
  set(handles.pixelText, 'String', [num2str(size(immWork,1)),'x',num2str(size(immWork,2)),' pixels']);
  axes(handles.imageAxes);
  imshow(immWork);
  immNN=im2bw(immWork,0.4);
  immNN=imresize(immNN, [7, 5]);
  axes(handles.elaboratedAxes);
  imshow(immNN);

function printTitle(handle, fileName, networkName)
  global fileNet fileImage;
  if ~strcmp('', fileName)
      fileImage=fileName;
  end
  if ~strcmp('', networkName)
      fileNet=networkName;
  end
  set(handle, 'Name', ['Character recognition - ', fileNet, ' - ', fileImage]);

% --- Executes on button press in loadButton.
% --- Loads an image
function loadButton_Callback(hObject, eventdata, handles)
  global immOriginal immWork;
  [filename, dirname] = uigetfile({'*.jpg;*.tif;*.png;*.gif'},'Load a character image');
  if filename==0
      return;
  end
  immOriginal=imread([dirname, filename]);
  immWork=immOriginal;
  printImage(handles);
  printTitle(handles.figure1, filename, '');

% --- Executes on button press in cropRowButton
% --- Crops the rows
function cropRowButton_Callback(hObject, eventdata, handles)
  global immWork;
  if isscalar(immWork)
      errordlg('First you must load an image')
      return
  end
  x_min = cropCheckRows(1, size(immWork,1), 1);
  height= cropCheckRows(size(immWork,1), 1, -1) - x_min;
  cropDo(handles, 1, x_min, size(immWork,2), height);

% --- Executes on button press in cropColumnButton
% --- Crops the columns
function cropColumnButton_Callback(hObject, eventdata, handles)
  global immWork;
  if isscalar(immWork)
      errordlg('First you must load an image')
      return
  end
  y_min = cropCheckColumns(1, size(immWork,2), 1);
  width = cropCheckColumns(size(immWork,2), 1, -1) - y_min;
  cropDo(handles, y_min, 1, width, size(immWork,1));

% --- Checks the rows for crop
function j = cropCheckRows(j_in, j_fin, pass)
  global immWork;
  for j=j_in:pass:j_fin
      for i=1:size(immWork,2)
          if immWork(j,i)<=150
             return
          end
      end
  end

% --- Checks the columns for crop
function j = cropCheckColumns(j_in, j_fin, pass)
  global immWork;
  for j=j_in:pass:j_fin
      for i=1:size(immWork,1)
          if immWork(i,j)<=150
             return
          end
      end
  end
  
% --- Modifies the image with crop
function cropDo(handles, y, x, width, height)
  global immWork;
  imm=imcrop(immWork, [y, x, width, height]);
  immWork=imresize(imm, [size(immWork,1), size(immWork,2)]);
  printImage(handles);

% --- Executes on button press in restoreButton.
function restoreButton_Callback(hObject, eventdata, handles)

  global immOriginal immWork;
  if isscalar(immWork)
      errordlg('First you must load an image')
      return
  end
  immWork=immOriginal;
  printImage(handles);

% --- Executes on button press in noiseButton.
% --- Adds noise to the immage
function noiseButton_Callback(hObject, eventdata, handles)
  global immWork;
  if isscalar(immWork)
      errordlg('First you must load an image')
      return
  end
  string_list = get(handles.noiseList,'String');
  string_val = string_list{ get(handles.noiseList,'Value') };
  immWork=addNoise(immWork, str2num(string_val));%imnoise(immNN, 'salt & pepper', str2num(string_val) );
  printImage(handles);

% --- Executes on button press in networkButton.
% --- Loads the selected neural network
function networkButton_Callback(hObject, eventdata, handles)
  global net NNfolder netOk;
  string_list = get(handles.netList,'String');
  string_val = string_list{ get(handles.netList,'Value') };
  app=load([NNfolder,string_val]);
  net=app.net;
  warndlg('The neural networn has been loaded');
  netOk=1;
  set(handles.neuText, 'String', ['Neuron numbers: ', num2str(size(net.IW{1},1))]);
  if strcmp(net.adaptFcn, 'trains')
      set(handles.nnText, 'String', 'Network: backprop');
  else
      set(handles.nnText, 'String', 'Network: rbfn');
  end
  set(handles.trainText, 'String', ['Training function: ', net.trainFcn]);
  set(handles.errorText, 'String', ['Perform function: ', net.performFcn]);
  printTitle(handles.figure1, '', string_val);


% --- Executes on button press in simButton.
% --- Simulates the neural network
function simButton_Callback(hObject, eventdata, handles)
   global net immNN netOk;
   if netOk==0
       errordlg('Please, you must load a neural network')
       return
   end
   if isscalar(immNN)
       errordlg('First you must load an image')
       return
   end
   pos=find( compet( sim(net, (reshape(immNN, 35, 1)+0) ) ) ==1 );
   set(handles.resultEdit, 'String', char(pos+64));
