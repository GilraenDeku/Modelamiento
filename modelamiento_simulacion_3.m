
%Gráfico de la salida cardiaca en función de la presión de la arteria derecha

% Parámetros
f = 90;
D = 80;
S = 7;
A = 4;
P = 20;

% Rango de valores de R
R_values = linspace(0, 19.2, 100);

% Cálculo de Q en función de R
Q_values = f * D * (R_values - (S * A / D) - P);
Q_values = max(Q_values, 0); % Reemplaza valores negativos de Q por 0

% Límite superior para Q (para la línea horizontal en la parte superior)
Q_max = 100; % Define el límite superior
Q_values = min(Q_values, Q_max); % Reemplaza valores mayores a Q_max por Q_max

% Gráfico
plot(R_values, Q_values, '-k', 'LineWidth', 2); % Línea negra sólida
xlabel('Presión de la arteria derecha Pra');
ylabel('Salida cardiaca Qc');
title('Gráfico de la salida cardiaca en función de la presión de la arteria derecha');
grid on;

%Unión de los gráficos

% Parámetros
MS = 7;
RV = 0.4;
CA = 0.028;
CV = 0.5;
F = 72;
D = 0.035;
S = 0.0007;
A = 5;
P = 4;

% Rango de valores para RA
RA_values = linspace(0, 19.2, 192);

% Primera ecuación: Cálculo de R
R_values = (MS - RA_values) ./ (RV + (RA_values .* CA) ./ (CA + CV));

% Segunda ecuación: Cálculo de Q
Q_values = F * D * (R_values - (S * A / D) - P);

% Identificar la intersección entre las dos ecuaciones
[~, idx_intersection] = min(abs(R_values - Q_values)); % Encuentra el índice más cercano
RA_intersection = RA_values(idx_intersection);         % Valor de RA en la intersección
R_intersection = R_values(idx_intersection);           % Valor de R en la intersección
Q_intersection = Q_values(idx_intersection);           % Valor de Q en la intersección

% Graficar ambas ecuaciones
figure;
plot(RA_values, R_values, '-k', 'LineWidth', 2, 'DisplayName', 'R en función de RA'); % Línea negra para R
hold on;
plot(RA_values, Q_values, '-r', 'LineWidth', 2, 'DisplayName', 'Q en función de RA'); % Línea roja para Q

% Resaltar la intersección
plot(RA_intersection, R_intersection, 'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b', 'DisplayName', 'Intersección');

% Añadir etiquetas y formato
xlabel('presión de la arteria derecha Pra');
ylabel('Valores de Qr y Qc');
title('Gráfica de Qr y Qc en función de Pra');
legend('show', 'Location', 'Best');
grid on;
hold off;

% Mostrar los valores de la intersección
disp('Intersección:');
disp(['RA = ', num2str(RA_intersection)]);
disp(['R = ', num2str(R_intersection)]);

%Gráfica de la curva de retorno venoso

% Definir los parámetros de la ecuación
MS = 7;
RV = 0.4;
CA = 0.028;
CV = 0.5;

% Crear rangos de valores para cada sección de RA
RA_values_antes = linspace(-5, 0, 50);         % Rango antes de la intersección en el eje Y (RA < 0)
RA_values_curva = linspace(0, MS, 100);        % Rango de la curva entre las intersecciones (0 <= RA <= MS)
RA_values_despues = linspace(MS, MS + 5, 50);  % Rango después de la intersección en el eje X (RA > MS)

% Definir los valores constantes para las secciones horizontales
R_interseccion_y = MS / RV;  % Valor de R en el eje Y cuando RA = 0
R_interseccion_x = 0;        % Valor de R en el eje X cuando R = 0 (RA = MS)

% Parte 1: Línea horizontal antes del eje Y
R_values_antes = ones(size(RA_values_antes)) * R_interseccion_y;

% Parte 2: Curva entre los puntos de intersección (ecuación original)
R_values_curva = (MS - RA_values_curva) ./ (RV + (RA_values_curva .* CA) ./ (CA + CV));

% Parte 3: Línea horizontal después del eje X
R_values_despues = ones(size(RA_values_despues)) * R_interseccion_x;

% Graficar
figure;
plot(RA_values_antes, R_values_antes, 'k-', 'LineWidth', 2); % Línea horizontal antes de la intersección con el eje Y (color negro)
hold on;
plot(RA_values_curva, R_values_curva, 'k-', 'LineWidth', 2);  % Curva principal (color negro)
plot(RA_values_despues, R_values_despues, 'k-', 'LineWidth', 2); % Línea horizontal después de la intersección con el eje X (color negro)

% Resaltar las intersecciones
plot(0, R_interseccion_y, 'ko', 'MarkerSize', 1, 'MarkerFaceColor', 'k'); % Intersección en el eje Y (color negro)
plot(MS, R_interseccion_x, 'ko', 'MarkerSize', 1, 'MarkerFaceColor', 'k'); % Intersección en el eje X (color negro)

% Ajustar límites del eje
xlim([-5, MS+1]); % Limitar eje X
ylim([-5, R_interseccion_y + 5]);  % Limitar eje Y

% Añadir etiquetas y formato
xlabel('Pra');
ylabel('Qr');
title('Curva de retorno venoso');
grid on;

hold off;
