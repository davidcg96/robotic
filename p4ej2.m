% Carga de la toolbox
c = computer;
if(c(1)=='P') % Windows
    addpath('Matlab&VREPProgRob\ScorbotERVlibForMatlab\');
elseif(c(1)=='G') % Linux
    addpath('Matlab&VREPProgRob/ScorbotERVlibForMatlab/');
end

% Borra un posible objeto "Scorbot" previo y crea uno nuevo para el entorno
% simulado (V-REP). Antes de ejecutar esta parte, se debe haber iniciado la
% simulacion en el propio V-REP.

clear s;
fprintf('\n');
disp('-->Inicializando...');
s = Scorbot(Scorbot.MODEVREP); % Crea el objeto Scorbot
s.home; % Mueve el robot al punto de partida (home) por si no lo estuviera
s.changeSpeed(20); % Establece la velocidad del robot en 20 (no se debe exceder)

% Se emplea en este punto la rutina pendant() para abrir la "pistola"
% simulada. De esta forma se puede mover el robot y grabar manualmente
% puntos. En este caso, pediremos dos, uno de recogida de piezas y otro de
% llegada.

fprintf('\n\n');
disp('-->Lleva al robot a la posicion de recogida y pulsa ENTER en la pistola');
recogida = s.pendant(); % devuelve una estructura de datos que representa 
                        % el punto en el que se haya quedado el robot

disp('-->Lleva al robot a la posicion de llegada y pulsa ENTER en la pistola');
llegada = s.pendant();

s.home; % el robot vuelve al punto de partida "home"

% Ahora, este programa supone que hay una pieza en el punto
% "recogida", va a por ella y la deja en "llegada" usando aproximaciones
% intermedias. Luego termina y vuelve a "home".

% En este punto se calculan las aproximaciones intermedias con la rutina 
% changePosXYZ (esto no mueve el robot en absoluto). Dicha rutina toma dos
% argumentos, el punto de partida y un vector de tres elementos (en 
% coordenadas cartesianas X, Y, Z) que representa el punto al que se desea 
% llegar (siempre se refiere a la posicion de la herramienta). En este caso,
% se crean dos posiciones por encima de los puntos recogida y llegada, 
% respectivamente, situados a 1000 unidades por encima de "recogida" en el
% eje Z.

Arecogida = s.changePosXYZ(recogida,[recogida.xyz(1) recogida.xyz(2) recogida.xyz(3)+1000]);
Allegada = s.changePosXYZ(llegada,[llegada.xyz(1) llegada.xyz(2) llegada.xyz(3)+1000]);

%pieza1=[recogida.xyz(1)+0.0075,recogida.xyz(1)-0.075,recogida.xyz(1)-0.0265];
pieza2=[recogida.xyz(1) recogida.xyz(2)-510 recogida.xyz(3)];
%pieza6=[recogida.xyz(1)+0.09,recogida.xyz(1)-0.075,recogida.xyz(1)-0.0265];
%pieza5=[recogida.xyz(1)+0.09,recogida.xyz(1)-0.125,recogida.xyz(1)-0.0265];
%pieza4=[recogida.xyz(1)+0.00825,recogida.xyz(1),recogida.xyz(1)];
bajar=[recogida.xyz(1) recogida.xyz(2) recogida.xyz(3)-500];
s.move(Arecogida,1);
s.changeGripper(1);  % Abre la pinza
pieza1cogida= s.changePosXYZ(recogida,[bajar(1) bajar(2) bajar(3)]);
s.move(pieza1cogida,1);
s.changeGripper(0);  % Cierra la pinza
s.move(Arecogida,1);
s.move(Allegada,1);
dejar=[llegada.xyz(1) llegada.xyz(2) llegada.xyz(3)-500];
pieza1soltada= s.changePosXYZ(llegada,[dejar(1) dejar(2) dejar(3)]);
s.move(pieza1soltada,1);
s.changeGripper(1);  % Abre la pinza
s.move(Allegada,1);
s.changeGripper(0);
%segunda pieza
s.move(Arecogida,1);
pieza2cogida= s.changePosXYZ(recogida,[pieza2(1) pieza2(2) pieza2(3)]);
s.move(pieza2cogida,1);
bajar2=[pieza2(1) pieza2(2) pieza2(3)-500];
pieza2cogida= s.changePosXYZ(recogida,[bajar2(1) bajar2(2) bajar2(3)]);
s.changeGripper(1);
s.move(pieza2cogida,1);
s.changeGripper(0);
s.move(Arecogida,1);
s.move(Allegada,1);
pieza2soltada= s.changePosXYZ(Allegada,[Allegada.xyz(1) Allegada.xyz(2)+500 Allegada.xyz(3)]);
s.move(pieza2soltada,1);
pieza2soltada= s.changePosXYZ(Allegada,[Allegada.xyz(1) Allegada.xyz(2)+500 Allegada.xyz(3)-500]);
s.move(pieza2soltada,1);
s.changeGripper(1);
s.move(Allegada,1);
s.changeGripper(0);
%3 pieza la de arriba
s.move(Arecogida,1);
s.changePosRoll(Arecogida,920);
giro90=s.changePosRoll(Arecogida,920);
s.move(giro90,1);
pieza3recogida=s.changePosXYZ(giro90,[giro90.xyz(1)+100 giro90.xyz(2)+1000 giro90.xyz(3)]);
s.move(pieza3recogida,1);
s.changeGripper(1);
pieza3recogida3=s.changePosXYZ(pieza3recogida,[pieza3recogida.xyz(1)+100 pieza3recogida.xyz(2) pieza3recogida.xyz(3)-1900]);
s.move(pieza3recogida3,1);
s.changeGripper(0);
s.move(Arecogida,1);
s.move(Allegada,1);
giro90s=s.changePosRoll(Allegada,920);
s.move(giro90s,1);
pieza3soltada=s.changePosXYZ(giro90s,[giro90s.xyz(1) giro90s.xyz(2)+100 giro90s.xyz(3)-800]);
s.move(pieza3soltada,1);
s.changeGripper(1);
s.mover(Allegada,1);
s.changeGripper(0);
%pieza 4



