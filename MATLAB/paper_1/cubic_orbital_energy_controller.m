function u = cubic_orbital_energy_controller(state,zf)
% Return the controller input.
% Pass the state as a vector state = [x,xd,z,zd]

g = 9.8;

x = state(1);
xd = state(2);
z = state(3);
zd = state(4);

a = xd / x;
b = zd - a * z;
u = -7 * a^2 + (3 * zf * a^3 - g * a) / b - (10 * a^3 * b) / g;

end

