function [u] = controller_first_paper(state,zf)
    g = 9.81;
    a = state(2)/state(1);
    b = state(4)-a*state(3);
    u = -7*a^2+(3*zf*a^3-g*a)/b - (10*a^3*b)/g;
end

