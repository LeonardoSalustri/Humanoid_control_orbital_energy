sim_time = 12;
delta = 0.01;
time_interval = [0:delta:sim_time];
stance = 30;
swing = 20;
initial_dummy = 150;
t = [0:delta:0.49];
t_samp = [1:1:0.3/delta];
last_time = 0;
last_index = 0;


%%CoM
%x
figure();
plot(time_interval,x,"r",'LineWidth',2);
hold on;
plot(time_interval,xd,"g","LineWidth",2);
hold on;
plot(time_interval,zx,"b",'LineWidth',2);
xlim([0 12])
xlabel("Time[s]","FontSize",15,'interpreter','latex');
ylabel("$x/\dot{x}/x_{zmp}[m]$","FontSize",15,'interpreter','latex');
legend("$x$","$\dot{x}$","$x_{zmp}$",'interpreter','latex');
grid;
%y
% figure();
% plot(time_interval,y,"r",'LineWidth',2);
% hold on;
% plot(time_interval,yd,"g","LineWidth",2);
% hold on;
% plot(time_interval,zy,"b",'LineWidth',2);
% xlim([0 12])
% legend("$y$","$\dot{y}$","$y_{zmp}$",'interpreter','latex');
% xlabel("Time[s]","FontSize",15,'interpreter','latex');
% ylabel("$y/\dot{y}/y_{zmp}$[m]","FontSize",15,'interpreter','latex');
% grid;
%z
figure();
plot(time_interval,z,"r",'LineWidth',2);
hold on;
plot(time_interval,zd,"g","LineWidth",2);
hold on;
plot(time_interval,zz,"b",'LineWidth',2);
xlim([0 12])
legend("$z$","$\dot{z}$","$z_{zmp}$",'interpreter','latex');
xlabel("Time[s]","FontSize",15,'interpreter','latex');
ylabel("$z/\dot{z}/z_{zmp}$[m]","FontSize",15,'interpreter','latex');
grid;




% %%ZMP
% %x
% figure();
% plot(time_interval,zx,"g",'LineWidth',2);
% legend("$x_{zmp}$",'interpreter','latex');
% xlabel("Time[s]","FontSize",15,'interpreter','latex');
% ylabel("$x_{zmp}$[m]","FontSize",15,'interpreter','latex');
% xlim([0 5.14])
% %y
% figure();
% plot(time_interval,zy,"g",'LineWidth',2);
% legend("$y_{zmp}$",'interpreter','latex');
% xlabel("Time[s]","FontSize",15,'interpreter','latex');
% ylabel("$y_{zmp}$[m]","FontSize",15,'interpreter','latex');
% 
% xlim([0 5.14])
% %z
% figure();
% plot(time_interval,zz,"g",'LineWidth',2);
% legend("$z_{zmp}$",'interpreter','latex');
% xlabel("Time[s]","FontSize",15,'interpreter','latex');
% ylabel("$z_{zmp}$[m]","FontSize",15,'interpreter','latex');
% 
% xlim([0 5.14])
