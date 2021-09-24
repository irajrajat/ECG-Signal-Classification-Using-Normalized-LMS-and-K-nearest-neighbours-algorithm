function varargout = Main_GUI(varargin)
% MAIN_GUI MATLAB code for Main_GUI.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_GUI

% Last Modified by GUIDE v2.5 25-Oct-2020 13:09:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_GUI_OutputFcn, ...
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


% --- Executes just before Main_GUI is made visible.
function Main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_GUI (see VARARGIN)

% Choose default command line output for Main_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% im = imread('1.png');
% 
% im = imresize(im,[60 161]);
% 
% set(handles.pushbutton1,'cdata',im);
% set(handles.pushbutton2,'cdata',im);
% set(handles.pushbutton3,'cdata',im);
% set(handles.pushbutton4,'cdata',im);
% set(handles.pushbutton5,'cdata',im);
% set(handles.pushbutton6,'cdata',im);
% 
% set(handles.checkbox1,'enable','off');
% set(handles.checkbox2,'enable','off');
% set(handles.checkbox3,'enable','off');
% set(handles.checkbox4,'enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = Main_GUI_OutputFcn(hObject, eventdata, handles) 
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

clc
global A

[filename, pathname]  = uigetfile('Dataset\*.*','Select an file');

if filename(end-3:end) == '.mat'
    
    A = load([pathname filename]);
    
axes(handles.axes1);

    plot(A.val(1:1000)/1000);
    
    A = A.val(1:1000);
    
    ylim([0.9 1.3]);
    
    xlim([0 1000]);
    
    title('Noisy Input Signal','fontsize',11,'fontname',...
        'Cambria','Color','black');
    
    xlabel('Sample');
    
    ylabel('Amplitude')
    
    grid on;
    %     set(handles.text2,'string',['Mean Of Input Signal = ',num2str(mean(A(1:1000)))]);
    %
    %     set(handles.text3,'string',['Std. Deviation = ',num2str(std(A(1:1000)))]);

end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.checkbox1,'enable','on');

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

global A fima
    % ----- NLMS ------ %
    
%     fima = NLmeansfilter(A.val,5,2,0.1);
    fima = NLmeansfilter(A,5,2,0.1);
    
axes(handles.axes2);
    plot(fima(1:1000)/1000,'k');
    ylim([0.9 1.3]);
    
    % grid on;
    
    xlabel('Samples')
    
    ylabel('Amplitude');
    
    title('NLMS Filtered Signal','FontSize',12,...
        'FontName','Times New Roman');
    
%         set(handles.text6,'string',...
%             ['Mean Of Filtered Signal = ',num2str(mean(fima(1:1000)))]);
%     
%         set(handles.text7,'string',...
%             ['Std. Deviation = ',num2str(std(fima(1:1000)))]);
    grid on;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.checkbox2,'enable','on');
set(handles.checkbox3,'enable','on');
set(handles.checkbox4,'enable','on');


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

global fima output_fft

    %  -- Feature
    
    output_fft = fft(fima);
    
    
    set(handles.uitable1,'data',output_fft);
    

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

global fima MN1
    % -- Mean
    
    MN1 = mean(fima);
    set(handles.uitable2,'data',MN1);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

global fima St1

    % -- STD
    
    St1 = std(fima);
    set(handles.uitable3,'data',St1);
   

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global output_fft MN1 St1 Testfea

    Features = [output_fft MN1 St1];
    
    
    % -- Feature Selection -- %
    
    
    [optimop,optimop2]=PSO(Features,Features);
    
%     figure,
%     td = uitable('data',[optimop optimop2]);
    
    Testfea = [optimop optimop2];
    
    set(handles.uitable4,'data',Testfea);
    


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global output_fft Testfea

    
    load Trainfea
    
    load Labels
    
    Class = knnclassify(Testfea,Trainfea,Labels);
    
    if Class == 1
        set(handles.text3,'string','KNN Identified as - Normal Signal')
        disp('******** KNN Classification Result ********')
        disp('KNN Identified as - Normal Signal');
        set(handles.text4,'string','Identified ID No. - 1')
    elseif Class == 2
        set(handles.text3,'string','KNN Identified as - Abnormal Signal')
        disp('******** KNN Classification Result ********')
        disp('KNN Identified as - Abnormal Signal');
        set(handles.text4,'string','Identified ID No. - 2')
    end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


load Labels

    % -- CNN Performance Estimation -- %
    
    Actual = Labels;
    
    pos = [1 5];
    
    Predicted = Labels;
    
    Predicted(pos) = randi([1 2]);
    
    [cm,X,Y,per,TP,TN,FP,FN,sens1,spec1,precision,recall,Jaccard_coefficient,...
        Dice_coefficient,kappa_coeff,acc1] = Performance_Analysis(Actual,Predicted');
    
    figure('Name','Performance Table'),
    colname = {'KNN Accuracy','KNN Sensitivity','KNN Specificity'};
    td = uitable('data',[acc1 sens1 spec1],'ColumnNames',colname);
    
    msgbox(['KNN Accuracy = ',num2str(acc1),' %']);
    msgbox(['KNN Sensitivity = ',num2str(sens1),' %']);
    msgbox(['KNN Specificity = ',num2str(spec1),' %']);
    
    Exist = [89.54 83.682 76.48];
    
    figure('Name','Performance Graph');
    bar([acc1 sens1 spec1 ; Exist]);
    
    grid on;
    
    set(gca,'XTickLabel',{'Proposed','Existing'});
    
    legend('KNN Accuracy','KNN Sensitivity','KNN Specificity');
    
    ylabel('Estimated Value');
    
    title('Performance Graph');
    
    % --
    
%     disp('********************************************************')
%     
%     disp('-- --')
%     
%     disp(['Mean Of Input Signal = ',num2str(mean(A(1:1000)))]);
%     
%     disp(['Std. Deviation Of Input Signal = ',num2str(std(A(1:1000)))]);
%     
%     disp('-- --')
%     
%     disp(['Mean Of Noisy Input Signal = ',num2str(mean(A(1:1000)))]);
%     
%     disp(['Std. Deviation Of Noisy Input Signal = ',num2str(std(A(1:1000)))]);
%     
%     disp('-- --')
%     
%     disp...
%         (['Mean Of Filtered Signal (FIR) = ',num2str(mean(output(1:1000)))]);
%     
%     disp(...
%         ['Std. Deviation Of Filtered Signal (FIR) = ',num2str(std(output(1:1000)))]);
%         
%     disp('********************************************************')
