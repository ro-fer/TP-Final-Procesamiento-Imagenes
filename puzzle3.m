clear all
clc

% Seleccionar la imagen mediante un diálogo de selección de archivos
[filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Imágenes (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Seleccione una imagen');
if isequal(filename, 0)
    disp('No se seleccionó ninguna imagen.');
    return;
end

% Leer la imagen seleccionada
imagenRGB = imread(fullfile(pathname, filename));

% Convertir la imagen de RGB a L*a*b*
imagenLAB = rgb2lab(imagenRGB);

% Obtener las dimensiones de la imagen
[alto, ancho, ~] = size(imagenLAB);

% Calcular el tamaño de cada pieza
alto_pieza = floor(alto / 4);
ancho_pieza = floor(ancho / 4);

% Inicializar las celdas para almacenar las piezas
piezas = cell(4, 4);

% Subdividir la imagen en 16 piezas
for i = 1:4
    for j = 1:4
        fila_inicio = (i-1) * alto_pieza + 1;
        fila_fin = i * alto_pieza;
        col_inicio = (j-1) * ancho_pieza + 1;
        col_fin = j * ancho_pieza;
        
        piezas{i, j} = imagenLAB(fila_inicio:fila_fin, col_inicio:col_fin, :);
    end
end

% Crear un arreglo de índices de las piezas y mezclarlo
indices = randperm(16);
piezas_mezcladas = cell(4, 4);

% Reorganizar las piezas en el nuevo orden mezclado
for i = 1:16
    [fila, col] = ind2sub([4, 4], i);
    [fila_mezclada, col_mezclada] = ind2sub([4, 4], indices(i));
    piezas_mezcladas{fila_mezclada, col_mezclada} = piezas{fila, col};
end

% Crear la imagen desordenada
imagen_desordenada = zeros(alto, ancho, 3);
for i = 1:4
    for j = 1:4
        fila_inicio = (i-1) * alto_pieza + 1;
        fila_fin = i * alto_pieza;
        col_inicio = (j-1) * ancho_pieza + 1;
        col_fin = j * ancho_pieza;
        imagen_desordenada(fila_inicio:fila_fin, col_inicio:col_fin, :) = piezas_mezcladas{i, j};
    end
end

% Convertir la imagen desordenada de L*a*b* a RGB
imagen_desordenada_rgb = lab2rgb(imagen_desordenada);

% Inicializar la imagen reconstruida
imagen_reconstruida = zeros(alto, ancho, 3);
imagen_reconstruida(1:alto_pieza, 1:ancho_pieza, :) = piezas_mezcladas{1, 1};

% Array para rastrear qué piezas han sido usadas
usadas = false(4, 4);
usadas(1, 1) = true;

% Unir las piezas restantes en su posición correcta (búsqueda mejorada)
for i = 1:4
    for j = 1:4
        if i == 1 && j == 1
            continue;
        end
        
        mejor_similitud = Inf;
        mejor_pieza = [];
        mejor_k = 0;
        mejor_l = 0;
        
        for k = 1:4
            for l = 1:4
                if usadas(k, l)
                    continue;
                end
                
                % Verificar similitud con la pieza izquierda
                if j > 1
                    pieza_actual = imagen_reconstruida((i-1)*alto_pieza+1:i*alto_pieza, (j-2)*ancho_pieza+1:(j-1)*ancho_pieza, :);
                    similitud = calcularSimilitud(pieza_actual, piezas_mezcladas{k, l}, 'horizontal');
                    if similitud < mejor_similitud
                        mejor_similitud = similitud;
                        mejor_pieza = piezas_mezcladas{k, l};
                        mejor_k = k;
                        mejor_l = l;
                    end
                end
                
                % Verificar similitud con la pieza superior
                if i > 1
                    pieza_actual = imagen_reconstruida((i-2)*alto_pieza+1:(i-1)*alto_pieza, (j-1)*ancho_pieza+1:j*ancho_pieza, :);
                    similitud = calcularSimilitud(pieza_actual, piezas_mezcladas{k, l}, 'vertical');
                    if similitud < mejor_similitud
                        mejor_similitud = similitud;
                        mejor_pieza = piezas_mezcladas{k, l};
                        mejor_k = k;
                        mejor_l = l;
                    end
                end
                
                % Verificar similitud con la pieza derecha
                if j < 4
                    pieza_actual = imagen_reconstruida((i-1)*alto_pieza+1:i*alto_pieza, j*ancho_pieza+1:(j+1)*ancho_pieza, :);
                    similitud = calcularSimilitud(pieza_actual, piezas_mezcladas{k, l}, 'horizontal');
                    if similitud < mejor_similitud
                        mejor_similitud = similitud;
                        mejor_pieza = piezas_mezcladas{k, l};
                        mejor_k = k;
                        mejor_l = l;
                    end
                end
                
                % Verificar similitud con la pieza inferior
                if i < 4
                    pieza_actual = imagen_reconstruida(i*alto_pieza+1:(i+1)*alto_pieza, (j-1)*ancho_pieza+1:j*ancho_pieza, :);
                    similitud = calcularSimilitud(pieza_actual, piezas_mezcladas{k, l}, 'vertical');
                    if similitud < mejor_similitud
                        mejor_similitud = similitud;
                        mejor_pieza = piezas_mezcladas{k, l};
                        mejor_k = k;
                        mejor_l = l;
                    end
                end
            end
        end
        
        % Colocar la mejor pieza encontrada en la posición correcta
        fila_inicio = (i-1) * alto_pieza + 1;
        fila_fin = i * alto_pieza;
        col_inicio = (j-1) * ancho_pieza + 1;
        col_fin = j * ancho_pieza;

        imagen_reconstruida(fila_inicio:fila_fin, col_inicio:col_fin, :) = mejor_pieza;
        
        % Marcar la pieza como usada
        usadas(mejor_k, mejor_l) = true;
    end
end

% Convertir la imagen reconstruida de L*a*b* a RGB
imagen_reconstruida_rgb = lab2rgb(imagen_reconstruida);

% Mostrar la imagen original, la imagen desordenada y la imagen reconstruida
figure;
subplot(1, 3, 1);
imshow(imagenRGB);
title('Imagen Original');

subplot(1, 3, 2);
imshow(imagen_desordenada_rgb);
title('Imagen Desordenada');

subplot(1, 3, 3);
imshow(imagen_reconstruida_rgb);
title('Imagen Reconstruida');

% Función para calcular la similitud entre los bordes de dos piezas
function similarity = calcularSimilitud(pieza1, pieza2, direccion)
    if strcmp(direccion, 'horizontal')
        borde1 = pieza1(:, end, :);
        borde2 = pieza2(:, 1, :);
    elseif strcmp(direccion, 'vertical')
        borde1 = pieza1(end, :, :);
        borde2 = pieza2(1, :, :);
    end
    diferencia = borde1 - borde2;
    similarity = sum(diferencia(:).^2);
end
