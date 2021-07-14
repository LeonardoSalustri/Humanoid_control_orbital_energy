clc, clear

% Plot basin of attraction

g = 9.8;
zf = 1;

[X,Xd,Z]=meshgrid(-0.8:0.01:0.8,-1.5:0.01:1.5,0:0.01:2);

ineq1 = (Xd./X < 0);
ineq2 = (7*g + 20*(Xd./X).*(- Xd./X.*Z) + sqrt(9*g^2+120*(Xd./X).^2*g*zf)) <= 0;

all = ineq1 & ineq2;
colors = zeros(size(X))+all;
sizes = 3 * all;
scatter3(X(all),Xd(all),Z(all),3,'b','filled')
xlabel('$x_0$','interpreter','latex')
ylabel('$\dot{x}_0$','interpreter','latex')
zlabel('$z_0$','interpreter','latex')
daspect([1 1 1])