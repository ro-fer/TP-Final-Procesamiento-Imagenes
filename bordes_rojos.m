close all; clear; clc
% leo una imagen y la convierto a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); %filtro para archivos bmp, jpg y png
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

Hx=fspecial('sobel'); %S
Hy=rot90(Hx); %E 
Hx1=rot90(Hx,2);
Hy1=rot90(Hx,3);

% Gradiente en x e y usando filtro Sobel
Gx = imfilter(double(I), Hx);
Gy = imfilter(double(I), Hy);

% Gradiente en x e y usando filtro Sobel
Gx1 = imfilter(double(I), Hx1);
Gy1 = imfilter(double(I), Hy1);

magnitud = sqrt(Gx.^2 + Gy.^2);
angulo = atan2d(Gy, Gx); % ángulo en grados

magnitud1 = sqrt(Gx1.^2 + Gy1.^2);
angulo1 = atan2d(Gy1, Gx1); % ángulo en grados

angulo_rojo = 4.5; % ejemplo: 45 grados
tolerancia = 2; % tolerancia de ±10 grados

% Máscara para seleccionar bordes en el rango de ángulos
mascara = (angulo >= angulo_rojo - tolerancia) & (angulo <= angulo_rojo + tolerancia);

% Máscara para seleccionar bordes en el rango de ángulos
mascara1 = (angulo1 >= angulo_rojo - tolerancia) & (angulo1 <= angulo_rojo + tolerancia);

% Aplicar la máscara a la magnitud del gradiente
bordes_sur = magnitud .* mascara;

% Aplicar la máscara a la magnitud del gradiente
bordes_norte = magnitud1 .* mascara1;

O = bordes_sur + bordes_norte;

figure;
% subplot(3,1,1)
imshow(bordes_sur);
title(['Bordes en ángulo de ', num2str(angulo_rojo), ' ± ', num2str(tolerancia), ' grados']);

figure (2);
% subplot(3,1,2)
imshow(bordes_norte);
title(['Bordes en ángulo de ', num2str(angulo_rojo), ' ± ', num2str(tolerancia), ' grados']);

figure (3);
% subplot(3,1,3)
imshow(O);
title('Imagen final');
