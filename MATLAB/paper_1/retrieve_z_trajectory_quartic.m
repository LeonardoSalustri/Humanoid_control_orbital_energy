function z = retrieve_z_trajectory_quartic(state)

    x = state(1);
    a0 = 0.9375;
    a2 = -2.0;
    a4 = 30.864;
    x_star = sqrt(-a2/(2*a4));
    
    if abs(x) < x_star
        z = a0 + a2*x^2 + a4*x^4;
    else
        z = 0.9051;

end