function [tout,out] = last_step_first_paper(initial_state,zf)
    syms x0 real
    
    m = 25;
    g = 9.81;
    x0 = initial_state(1);
    z0 = initial_state(3);
    dx0 = initial_state(2);
    dz0 = initial_state(4);
    
    k = 0.5*(dx0*z0-dz0*x0)^2 + g*x0^2*z0;
    
%     A = [1     0     0     0;
%          1    x0   x0^2   x0^3;
%          0     1   2*x0   3*x0^2;
%          1.5*g*x0^2  g*x0^3  3/4*g*x0^4 3/5*g*x0^5];
%      
%      b = [zf; z0; dz0/dx0; k];
%      
%      c = inv(A)*b;
     
     [tout,out] = ode45(@differential_first_paper,[0:0.0001:5],initial_state);
end

