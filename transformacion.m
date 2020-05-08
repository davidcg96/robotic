
%thetai= eje i
%alpaia= eje i-1
%di= eje i
%aia = eje i-1
%punto a transformar respecto del antetior 4T5 en fila
function [Ta] = transformacion(thetai,alpaia,di,aia,punto)
T=[cos(thetai) -sin(thetai) 0 aia;
   cos(alpaia)*sin(thetai) cos(thetai)*sin(alpaia) -sin(alpaia) -sin(alpaia)*di;
   sin(alpaia)*sin(thetai) cos(thetai)*sin(alpaia) cos(alpaia) cos(alpaia)*di;
   0 0 0 1];
Ta=T*(punto)';
end

