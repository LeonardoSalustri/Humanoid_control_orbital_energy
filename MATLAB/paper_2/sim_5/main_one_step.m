clear;clc;

delta = 0.00001;
sim_time = 15; 

m = 25;
g = 9.81 ;

%coefficients
a0 = 0.9375; 
a2 = -2; 
a4 = 30.864;

%controller gain
kz = 6; 
bz = 5;

v_des = 1;
dx0 = 1.2;

x0 = get_x0(dx0,v_des)

x_star = sqrt(-a2/(2*a4));
z_star = 0.9051;

z0 = a0;
dz0 = 2*a2*x0 + 4*a4*x0^3;

if abs(x0) >= x_star
    z0 = z_star;
    dz0 = 0;
end

initial_state = [x0;dx0;z0;dz0]; 


for i=1:1:20/delta
    v_des_array(i) = 1;
    if i<=1.4/delta || (i>6.9/delta && i<=8/delta)
        x_des_array(i) = 0.25;
        
    elseif (i>1.4/delta && i<=3.1/delta)
        x_des_array(i) = 0.35;

    elseif (i>3.1/delta && i<=5.4/delta) 
        x_des_array(i) = 0.45;
    elseif i >5.4/delta && i<=6.9/delta
        x_des_array(i) = 0.2;
    elseif i >8/delta
        x_des_array(i) = 0.25;
    end
end

index_xdes = 1;
last_index = 0;
cont=1;
figure("DefaultAxesFontsize",20);
while index_xdes <= sim_time/delta
    v_des = v_des_array(index_xdes);
    initial_state(1) = get_x0(initial_state(2),v_des);

    x_star = sqrt(-a2/(2*a4));
    z_star = 0.9051;

    
    [t,out] = ode45(@differential,[0:0.00001:2],initial_state);
    [tout,out2] = truncate_solution(t,out,z_star,x_des_array(index_xdes:end));

    
    initial_state = out2(end,:);
    last_index = index_xdes;
    index_xdes = index_xdes+length(tout);
    drawnow;
    %-----------------%
    % Plot Orbital Energy values
    x0 = out2(:,1);
    dx0 = out2(:,2);
    h = a0 - a2*x0.^2 - 3*a4*x0.^4;
    if abs(x0)>x_star
        f = z_star;
    else
        f = a0 + a2*x0.^2 + a4*x0.^4;
    end
    
    I = 1/2*a0*x0.^2 + 1/4*a2*x0.^4 + 1/6*a4*x0.^6;
    
    
    
    E_des = 0.5*v_des^2*a0^2;
    
    rhs = 1/2*dx0.*h.^2 + g*x0.^2.*f - 3*g*I;
    
%     plot(tout+last_index*delta,E_des*ones(1,size(tout,1)),":","Linewidth",3,"Color","#00008B")% #6B8E23 
%     
%     plot(tout+last_index*delta,rhs,"Linewidth",3,"Color","#800000")% #6B8E23 
    %-----------------%
    
    % plot things
    plot(tout+last_index*delta,out2(:,3),"Linewidth",3,"Color","#800000")% #6B8E23 
    
    xlim([0 8]);
    grid;
    xlabel("Time (s)",'interpreter','latex');
    ylabel("Vertical Displacement (m)",'interpreter','latex');
    hold on;
end
%plot(0:delta:12-delta,v_des_array,":","Linewidth",2.5,"Color","#00008B");
plot(0:delta:12-delta,x_des_array,":","Linewidth",2.5,"Color","#00008B");
