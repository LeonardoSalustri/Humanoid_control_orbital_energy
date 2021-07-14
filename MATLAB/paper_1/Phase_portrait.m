
function phase_portrait()
close all 
clc

figure("DefaultAxesFontsize",20);
% Drawing the arrows (gradients)
y1 = linspace(-0.8,0.8,30);
y2 = linspace(-0.8,0.8,30);
[x1,x2] = meshgrid(y1,y2);
e = zeros(size(x1));
v = zeros(size(x1));
t=0;
for i = 1:numel(x1)
    Yprime = Derivatives(t,[x1(i); x2(i)]);
    e(i) = Yprime(1);
    v(i) = Yprime(2);
end
q = quiver(x1,x2,e,v,"Color","#000080","linewidth",2);
set(q,'AutoScaleFactor',12);
xlabel('$x$','interpreter','latex');
ylabel('$\dot{x}$','interpreter','latex');


% Solving the ODE with different initial conditions
% and plotting the Phase Portrait
hold on 
tspan = [-100 100];
for x0 = -0.5:0.05:0.5
    for xdot0 = -1:0.2:1
        
        xinitial = [x0; xdot0];
        
        [tout, stateout] = ode45(@Derivatives, tspan, xinitial)
        
        % Phase plane 
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        
        plot(xout,xdotout,"linewidth",1.5);
        title("Phase Portrait",'interpreter','latex');
        set(gca,'Color','#F8F8FF')
        ylim([-0.7 0.7]);
        xlim([-0.5 0.5]);
        drawnow % live drawing
        
    end  
end
grid;


end


% Computing the dynamic of xdbdot considering a polynomial z=f(x)
function dstatedt = Derivatives(t, state)
  
z0 = 1;
zdot0 = 0;

zf = 1;
g = 9.8;

x = state(1);
xdot = state(2);

% A = [1 0 0 0; 
%      1 x x^2 x^3; 
%      0 1 2*x 3*x^2; 
%      3/2*g*x^2 g*x^3 3/4*g*x^4 3/5*g*x^5];
% 
% k = 0.5*(xdot*z0 - zdot0*x)^2 + g*x^2*z0;
% c = inv(A)*[zf; z0; zdot0/xdot; k];

c = [1;1;1;1];
f_bar = -2*c(4)*x^3-c(3)*x^2+c(1);
f_second = 6*c(4)*x +2*c(3);

u = (g+f_second*xdot^2)/f_bar;


% Same result as if I use matrix A, so all the conditions
% (Including E(x,xdot)=0)

% z =  c(4)*x.^3 + c(3)*x.^2 + c(2)*x + c(1);
% zdot = 3*c(4)*x.^2 + 2*c(3)*x + c(2);
% a = xdot/x;
% b = zdot-a*z;
% u = -7*a^2+(3*zf*a^3-g*a)/b -10*a^3*b/g;

xdbdot = u*x;

dstatedt = [xdot; xdbdot];
end




% % initial conditions for simulation
% x0 = -0.3;
% xdot0 = 1;
% z0 = 1;
% zdot0 = 0;
% 
% zf = 1;
% g = 9.8;
% 
% k = 0.5*(xdot0*z0 - zdot0*x0)^2 + g*x0^2*z0;
% 
% 
% A = [1 0 0 0; 
%     1 x0 x0^2 x0^3; 
%     0 1 2*x0 3*x0^2; 
%     3/2*g*x0^2 g*x0^3 3/4*g*x0^4 3/5*g*x0^5];
% 
% c = inv(A)*[zf; z0; zdot0/xdot0; k];
% 
% x = x0:0.01:0;
% z =  c(4)*x.^3 + c(3)*x.^2 + c(2)*x + c(1);

