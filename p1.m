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

magnitude = sqrt(Gx.^2 + Gy.^2);
angle = atan2d(Gy, Gx); % ángulo en grados

magnitude1 = sqrt(Gx1.^2 + Gy1.^2);
angle1 = atan2d(Gy1, Gx1); % ángulo en grados

target_angle = 4.5; % ejemplo: 45 grados
tolerance = 2; % tolerancia de ±10 grados

% Máscara para seleccionar bordes en el rango de ángulos
mask = (angle >= target_angle - tolerance) & (angle <= target_angle + tolerance);

% Máscara para seleccionar bordes en el rango de ángulos
mask1 = (angle1 >= target_angle - tolerance) & (angle1 <= target_angle + tolerance);

% Aplicar la máscara a la magnitud del gradiente
selected_edges = magnitude .* mask;

% Aplicar la máscara a la magnitud del gradiente
selected_edges1 = magnitude1 .* mask1;

O = selected_edges + selected_edges1;

figure;
subplot(3,1,1)
imshow(selected_edges, []);
title(['Bordes en ángulo de ', num2str(target_angle), ' ± ', num2str(tolerance), ' grados']);

subplot(3,1,2)
imshow(selected_edges1, []);
title(['Bordes en ángulo de ', num2str(target_angle), ' ± ', num2str(tolerance), ' grados']);

subplot(3,1,3)
imshow(O, []);
title(['Imagen final']);
