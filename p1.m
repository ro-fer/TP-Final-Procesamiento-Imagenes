
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
