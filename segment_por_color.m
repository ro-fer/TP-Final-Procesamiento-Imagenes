%Ejercicio 4

clc; close all;

%Generamos una imagen RGB de 1000x1000
iptsetpref('ImshowBorder','tight');
I = zeros(1000,1000,3); %creo inicialmente una imagen totalmente negra (x estar llena de ceros)
    I = double(I); %la convierto en double para posteriormente poder manipularla 
   
   % Le doy los valores necesarios para que el fondo tome el color amarillo
   % En Rgb el color amarillo tiene el código 110
  
    I(:,:,1)=1;
    I(:,:,2)=1;
    I(:,:,3)=0;
    
    imshow(I);

  %Agregamos las figuras correspondientes con 'rectangle' 
    %selecciona espacio en el recuadro, y segun los valores brindados a sus
        %caracteristicas genera figuras. 
    %Curvature redondea los bordes si le pongo 1, sino lo deja cuadrado.
        %acepta valores entre 0 y 1
    % Face color y edge color: selecciona color de relleno y bordes

% Generamos circulos verdes 
    rectangle('Position', [42, 100, 64, 410],   'Curvature', [1 1], 'FaceColor', 'green', 'EdgeColor', 'green');
    rectangle('Position', [80, 5, 120, 20],     'Curvature', [1 1], 'FaceColor', 'green', 'EdgeColor', 'green');
    rectangle('Position', [660, 20, 70, 20],    'Curvature', [1 1], 'FaceColor', 'green', 'EdgeColor', 'green');
    rectangle('Position', [302, 50, 550, 200],  'Curvature', [1,1], 'FaceColor', 'green', 'EdgeColor', 'green');
    rectangle('Position', [52, 700, 20,100],    'Curvature', [1,1], 'FaceColor', 'green', 'EdgeColor', 'green');
    %rectangle('Position', [80, 350, 150,20],   'Curvature', [1,1], 'FaceColor', 'green', 'EdgeColor', 'green');

% Generamos cuadrados azules 
    rectangle('Position', [216, 54, 10, 20],    'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [80, 90, 28, 20],     'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [888, 300, 30, 20],   'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [730, 940, 50, 50],   'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [409, 450, 100, 100], 'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [650, 590, 45, 45],   'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [65, 500, 61, 60],    'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [801, 450, 42, 45],   'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    rectangle('Position', [250, 300, 35, 45],   'Curvature', [0 0], 'FaceColor', 'blue', 'EdgeColor', 'blue');
    %rectangle('Position', [500, 510, 15, 10],  'Curvature', [1 1], 'FaceColor', 'blue', 'EdgeColor', 'blue');

% Generamos circulos negros
    rectangle('Position', [800, 800, 90, 90],   'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
    rectangle('Position', [290, 280, 100, 200], 'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
    rectangle('Position', [200, 770, 130, 100], 'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
    rectangle('Position', [670, 500, 400, 120], 'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
%     rectangle('Position', [320, 427, 50, 25], 'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
%     rectangle('Position', [800, 279, 30, 50], 'Curvature', [1 1], 'FaceColor', 'black', 'EdgeColor', 'black');
    
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
    
% Se guarda la imagen con el nombre de "FORMAS"
saveas(gcf,'FORMAS.png')
   
 %Luego de guargar la imagen procedemos a trabajar con ella 
 [file,dir]=uigetfile('*.png');% seleccionar la imagen formas 
 filename=[dir,file];
 I = imread(filename);
   delete('FORMAS.png'); 
   iptsetpref('ImshowBorder','loose');
  Imagen_Lab= rgb2lab(I); % convierto de RGB a imagen tipo LAB
  
% Separación cada uno de los espacios de color 
    
    L_valores = Imagen_Lab(:,:,1);
    A_valores = Imagen_Lab(:,:,2);
    B_valores = Imagen_Lab(:,:,3);
    
% Definimos colores segun LAB
rojo     = (A_valores >= 60 & B_valores >= 0);
verde    = (A_valores <= -60);
negro    = (A_valores == 0 & B_valores == 0);
amarillo = (B_valores >= 60);
azul     = (B_valores <= -60);


% bwlabel hace el conteo de cada uno de los colores. Le tengo que pasar la
% caracteristica que quiero contar 
    % n_color cuenta cuantos elementos de ese color hay
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

% Rellenamos las imágenes con los objetos de cada color
    % repmat replica matrices: se construye imagen 'imagen_color' donde
    % solo los px que corresponden a dicho color de la imagen original se
    % mantienen, el resto va en blanco (xq 'imagen_color' es una matriz de
    % unos, es decir, todo blanco).
    
    % Se le pasa [1, 1, 3] replica en 3D, es decir, hace una mascara
imagen_rojo(repmat(rojo, [1, 1, 3]))   = I(repmat(rojo, [1, 1, 3]));
imagen_verde(repmat(verde, [1, 1, 3])) = I(repmat(verde, [1, 1, 3]));
imagen_negro(repmat(negro, [1, 1, 3])) = I(repmat(negro, [1, 1, 3]));
imagen_azul(repmat(azul, [1, 1, 3]))   = I(repmat(azul, [1, 1, 3]));

% Graficamos segmentando figuras según color
figure();
subplot(3,3,[1 2 4 5]); imshow(I);            title('Imagen original');
subplot(333); imshow(imagen_rojo);  title(strcat('#Objetos rojos : ', num2str(n_rojo)));
subplot(336); imshow(imagen_verde); title(strcat('#Objetos verdes: ', num2str(n_verde)));
subplot(338); imshow(imagen_negro); title(strcat('#Objetos negros: ', num2str(n_negro)));
subplot(339); imshow(imagen_azul);  title(strcat('#Objetos azules: ', num2str(n_azul)));

%% ESTE ANDA PERO NO SE SI PUEDO USAR ESAS FUNCIONES
% Buscamos que el fondo quede blanco. Esto genera matrices de colores
% (colormaps)
% objetos_rojos  = uint8([255 255 255 ; 255  0   0]);   % Blanco  y rojo
% objetos_verdes = uint8([255 255 255 ; 0   255  0]);   % Blanco y verde
% objetos_negros = uint8([255 255 255 ; 0    0   0]);   % Blanco y negro
% objetos_azules = uint8([255 255 255 ; 0    0   255]); % Blanco y azul
% 
% % Graficamos segmentando figuras segun color
% figure();
% subplot(3,3,1:3); imshow(I);                     title('Imagen original');
% subplot(332); imshow(rojo, objetos_rojos);   title(strcat(' #Objetos rojos =  ', num2str(n_rojo)));
% subplot(333); imshow(verde, objetos_verdes); title(strcat(' #Objetos verdes =  ', num2str(n_verde)));
% subplot(334); imshow(negro, objetos_negros); title(strcat(' #Objetos negros =  ', num2str(n_negro)));
% subplot(335); imshow(azul, objetos_azules);  title(strcat(' #Objetos azules =  ', num2str(n_azul)));
 

