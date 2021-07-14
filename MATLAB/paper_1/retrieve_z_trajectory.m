function [z, c] = retrieve_z_trajectory(init_state,x,zf)
% Pass the initial state as a vector state = [x0,z0,zd0,xd0]
% Pass the state as a vector state = [x,xd,z,zd]

x0 = init_state(1);
z0 = init_state(3);
xd0 = init_state(2);
zd0 = init_state(4);

g = 9.8;

A = [1,             0,      0,          0;
     1,             x0,     x0^2,       x0^3;
     0,             1,      2*x0,       3*x0^2;
     3/2*g*x0^2,    g*x0^3, 3/4*g*x0^4,  3/5*g*x0^5];
 
k = 1/2*(xd0*z0 - zd0*x0)^2 + g*x0^2*z0;
 
b = [zf; z0; zd0/xd0; k];

c = A\b;

z = 0;

for i = 0:3
    z = z + c(i+1)*x^i;
end

end


