function [Matriz] = Scorbot(m1, m2, m3, m4, m5)
    theta1 = m1;
    theta2 = -m2;
    theta3 = -m3; 
    theta4 = -m4;
    theta5 = -m5;
    
    Datos = [0 0 0 0 ; 
             0.02 -pi/2 0 theta1 ; 
             0.223 0 0 theta2 ; 
             0.223 0 0 theta3 ; 
             0 -pi/2 0 theta4 ; 
             0 0 0 theta5];
   
    Matriz(1, 1) = 0; 
    Matriz(1, 2) = 0; 
    Matriz(1, 3) = 0; 
    
    T = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 0.31 ; 0 0 0 1];
    
    for i = 2:6
        T = T * hTi(Datos(i-1, 1), Datos(i, 4), Datos(i-1, 2), Datos(i, 3));
        
        aux = T * [0 ; 0 ; 0 ; 1];
        aux = aux(1:3);
        
        Matriz(i, 1) = aux(1);
        Matriz(i, 2) = aux(2);
        Matriz(i, 3) = aux(3);
    end
    
    aux = T * [0 ; 0.0325 ; 0.08 ; 1];
    aux = aux(1:3);
    Matriz(6, 1) = aux(1);
    Matriz(6, 2) = aux(2);
    Matriz(6, 3) = aux(3);
    
    aux = T * [0 ; -0.0325 ; 0.08 ; 1];
    aux = aux(1:3);
    Matriz(7, 1) = aux(1);
    Matriz(7, 2) = aux(2);
    Matriz(7, 3) = aux(3);
    
end

