function u = controller(state,kz,bz,f,df,ddf,m)

    x = state(1); 
    dx = state(2); 
    z = state(3); 
    dz = state(4); 
    
    g = 9.81; 
    
    % u = (kz*(f-z)+bz*(df*dx-dz))+(m*sqrt(x^2+z^2))*(g+ddf*dx^2)/(z-df*x);
    
    u = (kz*(f-z)+bz*(df*dx-dz))/(m*sqrt(x^2+z^2))+(g+ddf*dx^2)/(z-df*x);
end

