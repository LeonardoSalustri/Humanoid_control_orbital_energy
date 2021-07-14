clc,clear,clf

% Initialized initial state

x0 = -0.3;
z0 = 1;
xd0 = 0.8;
zd0 = 0.;
zf = 1;

g = 9.8;

init_state = [x0,xd0,z0,zd0];

figure("DefaultAxesFontSize",15)

% Plot desired z trajectory
subplot(2,2,[1,3]);
grid on
plot(x0,z0,'o');hold on;
plot([x0 0],[z0 0],'o-b','LineWidth',1.0);

xlabel('$x$ [m]','interpreter','latex')
ylabel('$z$ [m]','interpreter','latex')

z = [z0];

for x = x0:0.001:0
    z(end+1) = retrieve_z_trajectory(init_state,x,zf);
end

% Initialize variables for simulation and plots
hold on;
d = plot([x0,x0:0.001:0],z,'LineWidth',2.0)
daspect([1 1 1])

state = init_state;
x_sequence = [x0];
z_sequence = [z0];
xd_sequence = [xd0];
f_leg_normalized = [];
f_leg_normalized(end+1) = 0;

% Controller simulation

dt = 0.001;
n_iterations = 100000;

for n = 1:n_iterations
   u = cubic_clipped_controller(state,zf);
   qdd = [0, -g]' + [state(1) state(3)]'*u;
   state([2,4]) = state([2,4]) + qdd'*dt;
   state([1,3]) = state([1,3]) + state([2,4])*dt;
   x_sequence(end+1) = state(1);
   z_sequence(end+1) = state(3);
   xd_sequence(end+1) = state(2);
   f_leg_normalized(end+1) = 1/g*u*norm([state(1),state(3)]);
%    plot([state(1) 0],[state(3) 0]);
   %drawnow
   %pause();
end
f = plot(x_sequence,z_sequence,'-r','LineWidth',2.0);
grid on
% legend([d f],'Desired Trajectory','Followed Trajectory','FontSize',10)

% Plot xd vs x

subplot(2,2,2);
grid on
daspect([1 1 1])
plot(x_sequence,xd_sequence,'LineWidth',2.0);
grid on
xlabel('$x$ [m]','interpreter','latex')
ylabel('$\dot{x}$ [m/s]','interpreter','latex')

% Plot nomralized leg force normalized
subplot(2,2,4);
daspect([1 1 1])
plot(x_sequence,f_leg_normalized,'LineWidth',2.0);
grid on
xlabel('$x$ [m]','interpreter','latex')
ylabel('normalized leg force [-]','interpreter','latex')

greater_than_zero = f_leg_normalized > 0;
greater_than_zero_bool = find(greater_than_zero); 
first_greater_than_zero_index = greater_than_zero_bool(1);
x_triggered_controller = x_sequence(first_greater_than_zero_index);
xline(x_triggered_controller,'--','LineWidth',2.0)

subplot(2,2,[1,3]);
hold on;
xline(x_triggered_controller,'--','LineWidth',2.0)

subplot(2,2,2);
hold on;
xline(x_triggered_controller,'--','LineWidth',2.0)
