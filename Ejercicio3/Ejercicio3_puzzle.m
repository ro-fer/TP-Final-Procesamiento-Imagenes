close all
clear all
clc
%Funcion que lee la imagen, genera las piezas, las mezclas y vuelve a
%ordenarlas.
function img_ordenada_rgb = puzzle (img)

% Función para calcular la diferencia de borde entre dos piezas
diff_borde = @(p1, p2, dir) sum((p1(:) - p2(:)).^2, 'all');


% Obtener las dimensiones de la imagen
[rows, cols, ~] = size(img);

%  Subdividir la imagen en 16 piezas
n = 4; % Dividir en 4x4
block_size = [rows/n, cols/n];
piezas = mat2cell(img, repmat(block_size(1), 1, n), repmat(block_size(2), 1, n), 3);

% Mezclar las piezas
indices = randperm(numel(piezas));
piezas_mezcladas = piezas(indices);

% Generar la imagen con las piezas mezcladas
img_mezclada = cell2mat(reshape(piezas_mezcladas, n, n));

%  Convertir a L*a*b* para una mejor comparación de bordes
lab_img = rgb2lab(img);
lab_piezas = mat2cell(lab_img, repmat(block_size(1), 1, n), repmat(block_size(2), 1, n), 3);

% Inicializar la estructura para guardar las piezas ordenadas
orden = cell(n, n);
usado = false(n^2, 1);

% Ordeno las piezas
% Buscar la primera pieza correcta según los criterios de borde
primer_pieza = lab_piezas{1}; % Iniciar con la primera pieza
orden{1, 1} = primer_pieza;
usado(1) = true;

for i = 1:n
    for j = 1:n
        if i == 1 && j == 1
            continue; % Saltar la esquina superior izquierda, ya está colocada
        end
        % Inicializo las variables 
        mejor_diff = inf;
        mejor_pieza = [];
        mejor_indice = 0;
        
        for k = 1:numel(lab_piezas) % Recorro lab_piezas
            if usado(k)
                continue; % Saltar las piezas ya colocadas
            end
            
            pieza_actual = lab_piezas{k}; % asigno a la pieza actual
            
            if j > 1 % Comparar con la pieza izquierda
                diff = diff_borde(orden{i, j-1}(:, end, :), pieza_actual(:, 1, :), 'horizontal');
                if diff < mejor_diff
                    mejor_diff = diff;
                    mejor_pieza = pieza_actual;
                    mejor_indice = k;
                end
            end
            
            if i > 1 % Comparar con la pieza de arriba
                diff = diff_borde(orden{i-1, j}(end, :, :), pieza_actual(1, :, :), 'vertical');
                if diff < mejor_diff
                    mejor_diff = diff;
                    mejor_pieza = pieza_actual;
                    mejor_indice = k;
                end
            end
        end
        
        orden{i, j} = mejor_pieza;
        usado(mejor_indice) = true;
    end
end

% Reconstruir la imagen ordenada
img_ordenada_lab = cell2mat(orden);
img_ordenada_rgb = lab2rgb(img_ordenada_lab);

% Mostrar las imágenes en una figura con subplots
figure;

% Subplot 1: Imagen original
subplot(1, 3, 1);
imshow(img);
title('Imagen Original');

% Subplot 2: Imagen con las piezas mezcladas
subplot(1, 3, 2);
imshow(img_mezclada);
title('Imagen con Piezas Mezcladas');

% Subplot 3: Imagen ordenada
subplot(1, 3, 3);
imshow(img_ordenada_rgb);
title('Imagen Ordenada');

sgtitle('Comparación de Imágenes');

end


%Pruebas : 

%Prueba uno : 'perro.jpg'
% Seleccionar una imagen a color
img_perro = imread('perro.jpg');
img_ordenada_rgb_perro = puzzle (img_perro) ; 
% Guardar la imagen ordenada en un archivo
imwrite(img_ordenada_rgb_perro, 'imagen_ordenada_perro.jpg');
%Prueba dos : 'paloma.jpg'
% Seleccionar una imagen a color
img_paloma = imread('paloma.jpg');
img_ordenada_rgb_paloma = puzzle (img_paloma) ; 
% Guardar la imagen ordenada en un archivo
imwrite(img_ordenada_rgb_paloma, 'imagen_ordenada_paloma.jpg');
%Prueba tres : 'leopardo.jpg'
% Seleccionar una imagen a color 
img_leopardo= imread('leopardo.jpg');
img_ordenada_rgb_leopardo = puzzle (img_leopardo) ; 
% Guardar la imagen ordenada en un archivo
imwrite(img_ordenada_rgb_leopardo, 'imagen_ordenada_leopardo.jpg');

% Prueba cuatro : imagen ingresada por usuario 
% Seleccionar la imagen mediante un diálogo de selección de archivos
[filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Imágenes (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Seleccione una imagen');
if isequal(filename, 0)
    disp('No se seleccionó ninguna imagen.');
    return;
end

img = imread(fullfile(pathname, filename));
img_ordenada_rgb= puzzle (img) ; 
% Guardar la imagen ordenada en un archivo
imwrite(img_ordenada_rgb, 'imagen_ordenada.jpg');