% Ejercicio 4: Segmentación por color

clc; close all;

%Generamos una imagen RGB de 1000x1000

iptsetpref('ImshowBorder','tight');
I = zeros(1000,1000,3); 
I = double(I);  
   
% Le doy los valores necesarios para que el fondo tome el color amarillo (110)
  
I(:,:,1)=1;
I(:,:,2)=1;
I(:,:,3)=0;
imshow(I);

%% Generación de objetos

% Generamos circulos verdes 
    rectangle('Position', [42, 100, 64, 410],   'Curvature', [1 1], 'FaceColor', 'g', 'EdgeColor', 'g');
    rectangle('Position', [80, 5, 120, 20],     'Curvature', [1 1], 'FaceColor', 'g', 'EdgeColor', 'g');
    rectangle('Position', [660, 20, 70, 20],    'Curvature', [1 1], 'FaceColor', 'g', 'EdgeColor', 'g');
    rectangle('Position', [302, 50, 550, 200],  'Curvature', [1,1], 'FaceColor', 'g', 'EdgeColor', 'g');
    rectangle('Position', [52, 700, 20,100],    'Curvature', [1,1], 'FaceColor', 'g', 'EdgeColor', 'g');
    rectangle('Position', [500, 750, 200,100],  'Curvature', [1,1], 'FaceColor', 'g', 'EdgeColor', 'g');

% Generamos cuadrados azules 
    rectangle('Position', [216, 54, 10, 20],    'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [80, 90, 28, 20],     'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [888, 300, 30, 20],   'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [730, 940, 50, 50],   'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [409, 450, 100, 100], 'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [650, 590, 45, 45],   'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [65, 500, 61, 60],    'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [801, 450, 42, 45],   'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');
    rectangle('Position', [250, 300, 35, 45],   'Curvature', [0 0], 'FaceColor', 'b', 'EdgeColor', 'b');

% Generamos circulos negros
    rectangle('Position', [800, 800, 90, 90],   'Curvature', [1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [290, 280, 100, 200], 'Curvature', [1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [200, 770, 130, 100], 'Curvature', [1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [670, 500, 200, 120], 'Curvature', [1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    
% Generamos circulos rojos
    rectangle('Position', [880, 72, 50, 50],    'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [500, 600, 50, 50],   'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [500, 300, 50, 50],   'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [20, 700, 10, 10],    'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [100, 700, 35, 35],   'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [22, 750, 15, 12],    'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [100, 900, 40, 45],   'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [800, 750, 150, 12],  'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
    rectangle('Position', [900, 900, 100, 45],  'Curvature', [1 1], 'FaceColor', 'r', 'EdgeColor', 'r');
  
%% Guardado y apertura de imagen
saveas(gcf,'FORMAS.png')
I = imread('FORMAS.png');
delete('FORMAS.png');   
iptsetpref('ImshowBorder','loose'); 
Imagen_Lab= rgb2lab(I);
  

%% Separación cada uno de los espacios de color 
    
L_valores = Imagen_Lab(:,:,1);
A_valores = Imagen_Lab(:,:,2);
B_valores = Imagen_Lab(:,:,3);
    
% Definición colores segun LAB
rojo     = (A_valores >= 60 & B_valores >= 0);
verde    = (A_valores <= -60);
negro    = (L_valores <= 30 & A_valores >= -5 & A_valores <= 5 & B_valores >= -5 & B_valores <= 5); 
amarillo = (B_valores >= 60);
azul     = (B_valores <= -60);


%% Conteo de objetos del mismo color

[L_rojo, n_rojo]   = bwlabel(rojo);
[L_verde, n_verde] = bwlabel(verde);
[L_negro, n_negro] = bwlabel(negro);
[L_azul, n_azul]   = bwlabel(azul);

%%
% Creamos imágenes con fondo blanco para cada color
% genero matriz de unos
imagen_rojo  = uint8(255 * ones(size(I)));
imagen_verde = uint8(255 * ones(size(I)));
imagen_negro = uint8(255 * ones(size(I)));
imagen_azul  = uint8(255 * ones(size(I)));

% Máscara y relleno de las imágenes con los objetos de cada color

imagen_rojo(repmat(rojo, [1, 1, 3]))   = I(repmat(rojo, [1, 1, 3]));
imagen_verde(repmat(verde, [1, 1, 3])) = I(repmat(verde, [1, 1, 3]));
imagen_negro(repmat(negro, [1, 1, 3])) = I(repmat(negro, [1, 1, 3]));
imagen_azul(repmat(azul, [1, 1, 3]))   = I(repmat(azul, [1, 1, 3]));

% Graficamos segmentando figuras según color
figure();
subplot(2,4,[1 2 5 6]); imshow(I);            title('Imagen original');
subplot(243);           imshow(imagen_rojo);  title(strcat('#Objetos rojos : ', num2str(n_rojo)));
subplot(244);           imshow(imagen_verde); title(strcat('#Objetos verdes: ', num2str(n_verde)));
subplot(247);           imshow(imagen_negro); title(strcat('#Objetos negros: ', num2str(n_negro)));
subplot(248);           imshow(imagen_azul);  title(strcat('#Objetos azules: ', num2str(n_azul)));
