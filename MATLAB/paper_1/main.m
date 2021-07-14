clc,clear,clf

% Initialized initial state
delta = 0.001; % sampling time for integration of the dynamics
x0 = -0.3;
z0 = 1;
xd0 = 0.8;
zd0 = 0;
zf = 1;

g = 9.8;

init_state = [x0,xd0,z0,zd0];

% Plot desired z trajectory

plot(x0,z0,'o');hold on;
plot([x0 0],[z0 0],'o-b','LineWidth',1.0);

xlabel('$x$ [m]','interpreter','latex','FontSize',14)
ylabel('$z$ [m]','interpreter','latex','FontSize',14)


z = [z0];

for x = x0:delta:0
    z(end+1) = retrieve_z_trajectory(init_state,x,zf);
end

% Initialize variables for simulation and plots
hold on;
plot([x0,x0:delta:0],z,'LineWidth',2.0)
daspect([1 1 1])

state = init_state;
x_sequence = [x0];
z_sequence = [z0];
xd_sequence = [xd0];
f_leg_normalized = [];
f_leg_normalized(end+1) = 0;

% Controller simulation
n_iterations = 100000;

for n = 1:n_iterations
   u = cubic_clipped_controller(state,zf);
   qdd = [0, -g]' + [state(1) state(3)]'*u;
   state([2,4]) = state([2,4]) + qdd'*delta;
   state([1,3]) = state([1,3]) + state([2,4])*delta;
   x_sequence(end+1) = state(1);
   z_sequence(end+1) = state(3);
   xd_sequence(end+1) = state(2);
   f_leg_normalized(end+1) = 1/g*u*norm([state(1),state(3)]);
   %plot([state(1) 0],[state(3) 0],'o-r');
   %pause();
end
plot(x_sequence,z_sequence,'r-','Linewidth',2);
grid;

% Plot xd vs x

figure(2) 
daspect([1 1 1])
plot(x_sequence,xd_sequence,'Linewidth',2);
xlabel('$x$ [m]','interpreter','latex','FontSize',14)
ylabel('$\dot{x}$ [m/s]','interpreter','latex','FontSize',14)
grid;

% Plot nomralized leg force normalized
figure(3)
daspect([1 1 1])
plot(x_sequence,f_leg_normalized,'Linewidth',2);
xlabel('$x$ [m]','interpreter','latex','FontSize',14)
ylabel('normalized leg force [-]','interpreter','latex','FontSize',14)
grid;

