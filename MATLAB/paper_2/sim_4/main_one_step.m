clear;clc;

delta = 0.0001;
sim_time = 15; 

m = 25.1;
g = 9.81 ;

%coefficients
a0 = 0.9375; 
a2 = -2; 
a4 = 30.864;

%controller gain
kz = 6;
bz = 5; %---> eigenvalues in -3,-2

v_des = 0.5;
x0 = 0;
dx0 = 0.05;

x_star = sqrt(-a2/(2*a4));
z_star = 0.9051;
zf = 0.9375;
z0 = a0;
dz0 = 2*a2*x0 + 4*a4*x0^3;

if abs(x0) >= x_star
    z0 = z_star;
    dz0 = 0;
end

initial_state = [x0;dx0;z0;dz0]; 

figure("DefaultAxesFontsize",20);

out_tot = [zeros(1,4)];

for i=1:1:sim_time/delta
    
    if i<=3/delta || (i >10.5/delta && i<=11.5/delta)
        v_des_array(i) =  0.5;
    elseif (i>3/delta && i<=4.5/delta) || (i >8/delta && i<=10.5/delta)
        v_des_array(i) = 1;
    elseif (i>4.5/delta && i<=8/delta) 
        v_des_array(i) = 1.5;
    elseif i >10.5/delta && i < 10.6/delta
        v_des_array(i) = 0.5;
    elseif i >= 11.5/delta
        v_des_array(i) = 0;
    end
    
end

index_vdes = 1;
last_index = 1;
changed = 0;
cont = 1;

flag = 0; % first step variable flag

while index_vdes <= sim_time/delta
    
    v_des = v_des_array(index_vdes);
    
    if v_des == 0
        hold on;
        last_index = index_vdes;
        initial_state(1) = get_x0(initial_state(2),0,0);
        [tout1,out] = last_step_first_paper(initial_state,zf);
        [tout1,out1] = truncate_last_step(tout1,out,zf);
        plot(last_index*delta+tout1,out1(:,2),"Linewidth",3,"Color","#800000");
        plot(0:delta:sim_time-delta,v_des_array,":","Linewidth",2.5,"Color","#00008B");
        
        grid;
        break;
    end
    
    if v_des_array(index_vdes) < v_des_array(index_vdes+(index_vdes-last_index))
        changed = 1;
    elseif v_des_array(index_vdes) > v_des_array(index_vdes+(index_vdes-last_index))
        changed = -1;
    else
        changed = 0;
    end
    if flag ==1
        initial_state(1) = get_x0(initial_state(2),v_des,changed);
    end

    x_star = sqrt(-a2/(2*a4));
    z_star = 0.9051;
    
    
    [t,out] = ode45(@differential,[0:0.0001:2],initial_state);

    [tout,out2] = truncate_solution(t,out,z_star,v_des_array(index_vdes+(index_vdes-last_index)),changed);
    out_tot = [out_tot;out2];
    
    initial_state = out2(end,:);
    last_index = index_vdes;
    index_vdes = index_vdes+length(tout);
    tout_tot = [0:delta:last_index*delta+tout(end)];
    drawnow;
    plot(tout+last_index*delta,out2(:,2),"Linewidth",3,"Color","#800000")
    xlabel("Time (s)",'interpreter','latex');
    ylabel("Velocity (m)",'interpreter','latex');
  
    hold on;
    flag=1;
%     if cont==2
%         break
%     end
%     cont=cont+1;
end
