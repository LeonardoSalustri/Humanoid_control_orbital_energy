%% Last step

% syms x0 real
% 
% m = 25;
% g = 9.81;
% 
% zf = 0;
% z0 = initial_state(3);
% dx0 = initial_state(2);
% dz0 = initial_state(4);
% 
% k = 0.5*(dx0*z0-dz0*x0)^2 + g*x0^2*z0;
% 
% A = [1     0     0     0;
%      1    x0   x0^2   x0^3;
%      0     1   2*x0   3*x0^2;
%      1.5*g*x0^2  g*x0^3  3/4*g*x0^4 3/5*g*x0^5];
%  
%  b = [zf; z0; dz0/dx0; k];
%  
%  c = inv(A)*b;
 
 
syms x0 real

% coefficients
a0 = 0.9375; 
a2 = -2; 
a4 = 30.864; 

g = 9.81;
    
h = a0 - a2*x0^2 - 3*a4*x0^4;

rhs = -2*g*(1/2*a0*x0^2 - 1/4*a2*x0^4 - 3/6*a4*x0^6);

dx0 = initial_state(2);

solutions = double(solve(-dx0^2*h^2 == rhs,x0))
cont = 1;
for i = 1:1:length(solutions)
    if solutions(i) < 0 
        solutions_1(cont) = solutions(i);
        cont = cont+1;
    end
end
x0_true = max(solutions_1);

if abs(x0_true)>=x_star
    
    h = z_star;
    
    rhs = -2*g*(1/2*a0*x0^2 - 1/4*a2*x0^4 - 3/6*a4*x0^6);

    solutions = double(solve(-dx0^2*h^2 == rhs,x0));
    cont = 1;
    for i = 1:1:length(solutions)
        if solutions(i) < 0 
            solutions_1(cont) = solutions(i);
            cont = cont+1;
        end
    end
    x0_true = max(solutions_1);
end
initial_state(1) = x0_true;

[t,out] = ode45(@differential,[0:0.0001:1],initial_state);
plot(t+last_index*delta,out(:,2),"Linewidth",2,"Color","b");
grid;
hold on;






