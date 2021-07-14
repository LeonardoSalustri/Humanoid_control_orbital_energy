function [dstate] = differential(t,state)

    m = 25;
    g = 9.81;
    
    %coefficients
    a0 = 0.9375; 
    a2 = -2; 
    a4 = 30.864; 
    
    %controller gain
    kz = 6; 
    bz = 5;
    
    
    x_star = sqrt(-a2/(2*a4));
    z_star = 0.9051;
    
    if abs(state(1)) < x_star
        f = a0 + a2*state(1)^2 + a4*state(1)^4;
        df = 2*a2*state(1) + 4*a4*state(1)^3;
        ddf = 2*a2 + 12*a4*state(1)^2;
    else
        f = z_star;
        df = 0;
        ddf = 0;
    end
    
    u = controller(state,kz,bz,f,df,ddf,m);
    dstate = lip(state,u);
end

