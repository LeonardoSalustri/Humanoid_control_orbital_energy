clc, clear

%syms x0 a0 a2 a4 g v_des xd0 real

syms x0 real;

a0 = 0.9375; a2 = -2; a4 = 30.864; g = 9.81 ; v_des = 0.5; xd0 = 0;

x_star = sqrt(-a2/(2*a4));
z_star = 0.9051;

h = a0 - a2*x0^2 - 3*a4*x0^4;

I = 1/2*a0*x0^2 + 1/4*a2*x0^4 + 1/6*a4*x0^6;

f = a0 + a2*x0^2 + a4*x0^4;

E_des = 1/2*v_des^2*a0^2;

rhs = 1/2*xd0^2*h^2 + g*x0^2*f - 3*g*I;

p = E_des - rhs;

%p = subs(p)

solutions = solve(p,x0);

solutions = double(solutions);

% if unique(abs(solutions)) > x_star
%     f = 0.9051;
%     h = f;
%     I = 1/2*f*x0^2;
%     rhs = 1/2*xd0^2*h^2 + g*x0^2*f - 3*g*I;
%     E_des = 1/2*v_des^2*f^2;
%     p = E_des - rhs;
%     solutions = solve(p,x0);
%     solutions = double(solutions);
% end
