clc, clear

% Plot basin of attraction
figure("DefaultAxesFontSize",25)

g = 9.8;
zf = 1;
z0 = 1;

[X,Xd]=meshgrid(-0.8:0.001:0.8,-1.5:0.001:1.5);

ineq1 = (Xd./X < 0);
ineq2 = (7*g + 20*(Xd./X).*(- Xd./X.*z0) + sqrt(9*g^2+120*(Xd./X).^2*g*zf)) <= 0;

all = ineq1 & ineq2;
scatter(X(all),Xd(all),3,[0.8500 0.3250 0.0980],'filled')
xlabel('$x_0$','interpreter','latex')
ylabel('$\dot{x}_0$','interpreter','latex')
grid on

%z_crit = z0 - (g*X^2)/(2*Xd^2)
ineq3 = ( z0 - (g*X.^2)./(2*Xd.^2) > 0 );
clipped = xor(all,ineq3) & ineq1;
hold on
scatter(X(clipped),Xd(clipped),3,'r','filled')
hold on;
l1 = line([-2*sqrt(zf/g) 2*sqrt(zf/g)],[2 -2]);
set(l1,"linewidth",2.5,"color",'k');

l2 = line([-1 1],[sqrt(g/2) -sqrt(g/2)]);
set(l2,"linewidth",2.5,"color",'b');


xlim([-0.8 0.8]);
ylim([-1.5, 1.5]);
LEGEND = legend("States covered by both controllers","Additional region covered by clipped controller","$x_{0}$+$\sqrt{\frac{z_{f}}{g}}\dot{x}_{0}=0$","$z_{crit}(x_{0})=0$")
set(LEGEND,"Interpreter","Latex");




