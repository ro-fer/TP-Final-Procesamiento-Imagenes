% Ejercicio 1: Detección de bordes rojos. 

close all; clear; clc

% Lectura de imagen y conversión a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); 
filename = [dir,file];
info = imfinfo(filename);

switch info.ColorType
    case 'indexed'
        [Iorig,map] = imread(filename);
        I = ind2gray(Iorig,map); %convierto de indexada a escala de grises
    case 'grayscale'
        I = imread(filename);
    case 'truecolor'
        Iorig = imread(filename);
        I = rgb2gray(Iorig); %convierto de RGB a escala de grises       
end

I = im2double(I);

Hx  = fspecial('sobel'); 
Hy  = rot90(Hx);  
Hx1 = rot90(Hx,2);
Hy1 = rot90(Hx,3);

% Gradiente en x e y usando filtro Sobel
Gx = imfilter(double(I), Hx);
Gy = imfilter(double(I), Hy);

% Gradiente en x e y usando filtro Sobel
Gx1 = imfilter(I, Hx1);
Gy1 = imfilter(I, Hy1);

magnitud = sqrt(Gx.^2 + Gy.^2);
angulo = atan2d(Gy, Gx); 

magnitud1 = sqrt(Gx1.^2 + Gy1.^2);
angulo1 = atan2d(Gy1, Gx1); 

angulo_rojo = 4.5; % ejemplo: 45 grados
tolerancia = 1; % tolerancia de ±10 grados

% Máscara para seleccionar bordes en el rango de ángulos
mascara = (angulo >= angulo_rojo - tolerancia) & (angulo <= angulo_rojo + tolerancia);

% Máscara para seleccionar bordes en el rango de ángulos
mascara1 = (angulo1 >= angulo_rojo - tolerancia) & (angulo1 <= angulo_rojo + tolerancia);

% Aplicar la máscara a la magnitud del gradiente
bordes_sur = magnitud .* mascara;

% Aplicar la máscara a la magnitud del gradiente
bordes_norte = magnitud1 .* mascara1;

O = bordes_sur + bordes_norte;

figure (3);
imshow(O);
title('Imagen final');

BW = imbinarize(O);

paleta = uint8( [0 0 0;255 0 0] ); % negro // rojo

figure (4);
imshow(BW,paleta)
title('Imagen final');
