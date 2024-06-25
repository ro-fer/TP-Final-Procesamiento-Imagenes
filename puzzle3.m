clear all; clc; close all;

% Seleccionar la imagen mediante un diálogo de selección de archivos
[filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Imágenes (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Seleccione una imagen');
if isequal(filename, 0)
    disp('No se seleccionó ninguna imagen.');
    return;
end

imagenRGB = imread(fullfile(pathname, filename));
imagenLAB = rgb2lab(imagenRGB);
[alto, ancho, ~] = size(imagenLAB);

% Calcular el tamaño de cada pieza
alto_pieza = floor(alto / 4);  % Floor para evitar el warning
ancho_pieza = floor(ancho / 4);

% Dividir la imagen en 16 piezas
num_piezas = 4;
piezas = cell(num_piezas, num_piezas);

for i = 1:num_piezas
    for j = 1:num_piezas
        fila_inicio = (i-1) * alto_pieza + 1;
        columna_inicio = (j-1) * ancho_pieza + 1;
        fila_fin = i * alto_pieza;
        columna_fin = j * ancho_pieza;
        piezas{i, j} = imagenLAB(fila_inicio:fila_fin, columna_inicio:columna_fin, :);
    end
end

% Mezclar las piezas sin cambiar la primera pieza
indices_aleatorios = randperm(num_piezas^2 - 1) + 1;
indices_aleatorios = [1 indices_aleatorios]; 

piezas_mezcladas = cell(size(piezas));
index = 1;
for i = 1:num_piezas
    for j = 1:num_piezas
        piezas_mezcladas{i, j} = piezas{ceil(indices_aleatorios(index) / num_piezas), mod(indices_aleatorios(index)-1, num_piezas) + 1};
        index = index + 1;
    end
end

% Creación de la imagen mezclada
imagen_mezclada = zeros(alto, ancho, 3, 'like', imagenLAB);
for i = 1:num_piezas
    for j = 1:num_piezas
        fila_inicio = (i-1) * alto_pieza + 1;
        columna_inicio = (j-1) * ancho_pieza + 1;
        fila_fin = i * alto_pieza;
        columna_fin = j * ancho_pieza;
        imagen_mezclada(fila_inicio:fila_fin, columna_inicio:columna_fin, :) = piezas_mezcladas{i, j};
    end
end

% Orden de las piezas y creación de imagen ordenada
piezas_ordenadas = ordenar_piezas(piezas_mezcladas, alto_pieza, ancho_pieza, num_piezas);
imagen_ordenada = zeros(alto, ancho, 3, 'like', imagenLAB);
for i = 1:num_piezas
    for j = 1:num_piezas
        fila_inicio = (i-1) * alto_pieza + 1;
        columna_inicio = (j-1) * ancho_pieza + 1;
        fila_fin = i * alto_pieza;
        columna_fin = j * ancho_pieza;
        imagen_ordenada(fila_inicio:fila_fin, columna_inicio:columna_fin, :) = piezas_ordenadas{i, j};
    end
end

figure;
subplot(1, 3, 1); imshow(imagenRGB); title('Imagen Original');
subplot(1, 3, 2);imshow(lab2rgb(imagen_mezclada)); title('Imagen Mezclada');
subplot(1, 3, 3); imshow(lab2rgb(imagen_ordenada)); title('Imagen Ordenada');

% Función para ordenar las piezas
function piezas_ordenadas = ordenar_piezas(piezas_mezcladas, alto_pieza, ancho_pieza, num_piezas)
    % Inicializar la matriz de piezas ordenadas
    piezas_ordenadas = cell(num_piezas, num_piezas);
    piezas_ordenadas{1, 1} = piezas_mezcladas{1, 1}; % La primera pieza se mantiene en su lugar

    % Algoritmo para ordenar las piezas
    for i = 1:num_piezas
        for j = 1:num_piezas
            if i == 1 && j == 1
                continue; % Saltar la primera pieza
            end
            
            % Buscar la pieza que coincida con el borde de la pieza anterior
            mejor_coincidencia = [];
            minima_diferencia = inf;
            for x = 1:num_piezas
                for y = 1:num_piezas
                    if isempty(piezas_mezcladas{x, y})
                        continue;
                    end

                    if j > 1
                        % Comparar con el borde derecho de la pieza izquierda
                        borde_izquierdo = piezas_ordenadas{i, j-1}(:, end, :);
                        borde_derecho = piezas_mezcladas{x, y}(:, 1, :);
                        diferencia = sum(abs(borde_izquierdo(:) - borde_derecho(:)));
                    elseif i > 1
                        % Comparar con el borde inferior de la pieza superior
                        borde_superior = piezas_ordenadas{i-1, j}(end, :, :);
                        borde_inferior = piezas_mezcladas{x, y}(1, :, :);
                        diferencia = sum(abs(borde_superior(:) - borde_inferior(:)));
                    end

                    if diferencia < minima_diferencia
                        minima_diferencia = diferencia;
                        mejor_coincidencia = {x, y};
                    end
                end
            end

            % Colocar la mejor coincidencia en la posición actual
            piezas_ordenadas{i, j} = piezas_mezcladas{mejor_coincidencia{1}, mejor_coincidencia{2}};
            piezas_mezcladas{mejor_coincidencia{1}, mejor_coincidencia{2}} = [];
        end
    end
end
