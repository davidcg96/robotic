clc; clear; %close all; format compact;

% Carga de la toolbox
c = computer;
if(c(1)=='P') % Windows
    addpath('Matlab&VREPProgRob\ScorbotERVlibForMatlab\');
elseif(c(1)=='G') % Linux
    addpath('Matlab&VREPProgRob/ScorbotERVlibForMatlab/');
end

% Se crea el objeto Scorbot y se mueve el robot al punto de partida (home)
s = Scorbot(Scorbot.MODEVREP);
s.home;
s.changeSpeed(20);

% Se mueve el robot a la posición de origen con una altura segura
inicio = struct ('joints', [-18 1842 -1544 0 0],...
                 'xyz', [4050 -30 2000],...
                 'pitch', -440,...
                 'roll', 0 );
s.move(inicio,1);


% Se baja hacia el camino a seguir
xyz = inicio.xyz + [0 0 -800];
inicio = s.changePosXYZ(inicio, xyz);
s.move(inicio,1);

x=0:0.0008:0.2266;
x2=x*10000;
y=0.07*sin(28.5599.*x)*10000;%ecuacion que sigue el recorrido
%giro45=s.changePosRoll(inicio,-350);%entramos con 35 grados en el seno hasta el pmax
%s.move(giro45,1);
%[C,I]=max(y);
dy=0.07*28.5599*cos(28.5599.*x);
ro=round(-900+10*atan(dy)*180/pi);
%for i=1:I
 %   mover = s.changePosXYZ(giro45,round([giro45.xyz(1)+x2(i) giro45.xyz(2)+y(i) giro45.xyz(3)]));
  %  s.move(mover,1);
%end
for i=1:length(x2)
  
  mover = s.changePosXYZ(inicio,round([inicio.xyz(1)+x2(i) inicio.xyz(2)+y(i) inicio.xyz(3)]));
  mover=s.changePosRoll(mover,ro(i));
   s.move(mover,1);
end


