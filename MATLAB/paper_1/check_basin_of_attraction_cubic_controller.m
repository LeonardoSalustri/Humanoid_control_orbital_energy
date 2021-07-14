function check = check_basin_of_attraction_cubic_controller(init_state,zf)
    % Check if initial state belongs to the basin of attraction, return
    % true or false.
    
    
    x0 = init_state(1);
    xd0 = init_state(2);
    z0 = init_state(3);
    zd0 = init_state(4);
    
    a0 = xd0/x0;
    b0 = zd0 - a0*z0;
    
    g = 9.8;
    
    check = (a0<0) && ((7*g + 20*a0*b0 + sqrt(9*g^2+120*a0^2*g*zf))<=0);    
end