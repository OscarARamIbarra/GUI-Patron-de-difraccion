%      Ramirez Ibarra Oscar Alfredo
%      Laboratorio de instrumentacion optica

function varargout = ProcesamientoDeImagenesGUI(varargin)
% PROCESAMIENTODEIMAGENESGUI MATLAB code for ProcesamientoDeImagenesGUI.fig
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProcesamientoDeImagenesGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ProcesamientoDeImagenesGUI_OutputFcn, ...
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

function ProcesamientoDeImagenesGUI_OpeningFcn(hObject, eventdata, handles, varargin)

%Imagen Original
A = imread('C:\Users\alfre\OneDrive\Escritorio\lap\2023-1-Enero-Junio\Laboratorio-de-instrumentacion-optica\ProcesamientoDeImagenes\Prueba1.bmp');
handles.A=A;

%Transformada de Fourier
B = rgb2gray(A);
E= abs(B);
E1= mat2gray(E);
E2=im2uint8(E1);
F=fft2(E2);
handles.F=F;

%Transformada de Fourier en uint8
E3= abs(F);
E4= mat2gray(E3);
E5=im2uint8(E4);
handles.E5=E5;

%Transformada desplazada
FT=fftshift(F);
handles.FT=FT;

%Transformada desplazada en uint8
ET=abs(FT);
E1T=mat2gray(ET);
E2T=im2uint8(E1T);
handles.E2T = E2T;

%corte vertical
imshow(B)
[xi,yi] = getpts;
y=round(yi);
yp = B(:, y);
handles.y = yp;

%corte horizontal
x= round(xi);
xp = B(x, :);
handles.x= xp;

% transformada logaritmica imagen original
F1=double(A);
LA=log(1+F1);
LA1=mat2gray(LA);
LA2=im2uint8(LA1);
handles.LA2=LA2;

%transformada log
L=log(1+E3);
L1=mat2gray(L);
L2=im2uint8(L1);
handles.L2=L2;

%transformada log desplazada
LT=log(1+double(E2T));
L1T=mat2gray(LT);
L2T=im2uint8(L1T);
handles.L2T=L2T;

%antitransformada
g=ifft2(F);
g1=mat2gray(g);
g2=im2uint8(g1);
handles.g2=g2;

% transformada inversa desplazada
gf=ifft2(FT);
gf1=mat2gray(gf);
gf2=im2uint8(gf1);
handles.gf2=gf2;

handles.accion = handles.A;
imshow(handles.accion)

handles.output = hObject;

guidata(hObject, handles);

function varargout = ProcesamientoDeImagenesGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)

str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'ImagenOriginal'
        handles.CurrentData=imshow(handles.A);
    case 'Transformada'
        handles.CurrentData=imshow(handles.F);
    case 'Transformadauint8'
        handles.CurrentData=imshow(handles.E5);
    case 'TransformadaDesplazada'
        handles.CurrentData=imshow(handles.FT);
    case 'TransformadaDesplazadauint8'
        handles.CurrentData=imshow(handles.E2T);
    case 'CorteVertical'
        handles.CurrentData=plot(handles.y);
    case 'CorteHorizontal'
        handles.CurrentData=plot(handles.x);
    case 'TransformadaLogOriginal'
        handles.CurrentData=imshow(handles.LA2);
    case 'TransformadaLog'
        handles.CurrentData=imshow(handles.L2);
    case 'TransformadaLogDesplazada'
        handles.CurrentData=imshow(handles.L2T);
    case 'TransformadaInversa'
        handles.CurrentData=imshow(handles.g2);
    case 'TransformadaInversaDesplazada'
        handles.CurrentData=imshow(handles.gf2);
end
guidata(hObject, handles)
        
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
