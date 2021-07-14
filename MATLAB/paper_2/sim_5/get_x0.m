function [x0_true] = get_x0(dx0,v_des)
    syms x0 real;
    
    %coefficients
    a0 = 0.9375; 
    a2 = -2; 
    a4 = 30.864; 
    
    x_star = sqrt(-a2/(2*a4));
    z_star = 0.9051;
    
    g = 9.81;


    h = a0 - a2*x0^2 - 3*a4*x0^4;
    
    I = 1/2*a0*x0^2 + 1/4*a2*x0^4 + 1/6*a4*x0^6;
    
    f = a0 + a2*x0^2 + a4*x0^4;
    
    E_des = 0.5*v_des^2*a0^2;
    
    rhs = 1/2*dx0^2*h^2 + g*x0^2*f - 3*g*I;
    
    
    solutions = double(solve(E_des == rhs,x0));
    cont = 1;
    for i = 1:1:length(solutions)
        if solutions(i) < 0 % && solutions(i)<-x_star
            solutions_1(cont) = solutions(i);
            cont = cont+1;
        end
    end
    
    x0_true = max(solutions_1);
    if abs(x0_true)>=x_star
        h = z_star;
    
        I = z_star*x0^2/2;

        f = z_star;

        E_des = 0.5*v_des^2*a0^2;

        rhs = 1/2*dx0^2*h^2 + g*x0^2*f - 3*g*I;
        
        solutions = double(solve(E_des == rhs,x0));
        cont = 1;
        for i = 1:1:length(solutions)
            if solutions(i) < 0 
                solutions_2(cont) = solutions(i);
                cont = cont+1;
            end
        end
        x0_true = max(solutions_2);
    end
end


