function phase_portrait()
close all
clc

% Drawing the arrows (gradients)
y1 = linspace(-15,15,20);
y2 = linspace(-15,15,20);
[x1,x2] = meshgrid(y1,y2);
e = zeros(size(x1));
v = zeros(size(x1));
t=0;
for i = 1:numel(x1)
    Yprime = Derivatives(t,[x1(i); x2(i)]);
    e(i) = Yprime(1);
    v(i) = Yprime(2);
end
q = quiver(x1,x2,e,v,'k');
set(q,'AutoScaleFactor',1);
xlabel('$x$','interpreter','latex');
ylabel('$\dot{x}$','interpreter','latex');

% Solving the ODE with different initial conditions
% and plotting the Phase Portrait
hold on 
tspan = [0 10];
for x0 = -5:1:5
    for xdot0 = -5:1:5
        xinitial = [x0; xdot0];
        [tout, stateout] = ode45(@Derivatives, tspan, xinitial)
        %Phase plane 
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        plot(xout,xdotout);
        ylim([-15 15]);
        xlim([-15 15]);
        drawnow % live drawing
    end
    
end
end 

% Computing the dynamic of xdbdot
function dstatedt = Derivatives(t, state)
    
x = state(1);
xdot = state(2);

g = 9.81;
z0 = 1; % constant height
xdbdot = -g/z0*x;

dstatedt = [xdot; xdbdot];
    
end