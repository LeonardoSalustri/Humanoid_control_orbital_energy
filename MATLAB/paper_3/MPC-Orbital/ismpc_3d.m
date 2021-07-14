clear;clc;close;figure;

%% Define walk
foot_distance_x = 0.20;
foot_distance_y = 0.18;
foot_distance_z = 0.05;
S = 30;
D = 20;
N = 100;
Np = 100;
g = 9.81;
h = 0.9051;
omega = sqrt(g/h);
fs_matrix = [0,-foot_distance_y,0;
             foot_distance_x,foot_distance_y,foot_distance_z;
             2*foot_distance_x,-foot_distance_y,0;
             3*foot_distance_x,foot_distance_y,foot_distance_z;
             4*foot_distance_x,-foot_distance_y,0;
             5*foot_distance_x,foot_distance_y,foot_distance_z;
             6*foot_distance_x,-foot_distance_y,0;
             7*foot_distance_x,foot_distance_y,foot_distance_z;
             8*foot_distance_x,-foot_distance_y,0;
             9*foot_distance_x,foot_distance_y,foot_distance_z;
             10*foot_distance_x,-foot_distance_y,0;
             11*foot_distance_x,foot_distance_y,foot_distance_z;
             12*foot_distance_x,-foot_distance_y,0;
             13*foot_distance_x,foot_distance_y,foot_distance_z;
             14*foot_distance_x,-foot_distance_y,0;
             15*foot_distance_x,foot_distance_y,foot_distance_z;
             16*foot_distance_x,-foot_distance_y,0;
             17*foot_distance_x,foot_distance_y,0;
             18*foot_distance_x,-foot_distance_y,0;
             19*foot_distance_x,foot_distance_y,0;
             20*foot_distance_x,-foot_distance_y,0;
             21*foot_distance_x,foot_distance_y,0;
             22*foot_distance_x,-foot_distance_y,0;
             23*foot_distance_x,foot_distance_y,0;
             24*foot_distance_x,-foot_distance_y,0
             25*foot_distance_x,foot_distance_y,0
             26*foot_distance_x,-foot_distance_y,0
             27*foot_distance_x,foot_distance_y,0
             28*foot_distance_x,-foot_distance_y,0];

%% General parameters
delta = 0.01;
w = 0.08/2;

x(1) = 0.0;
xd(1) = 0.0;
zx(1) = 0.0;

y(1) = 0;
yd(1) = 0;
zy(1) = 0;

z(1) = h;
zd(1) = 0;
zz(1) = 0;

%% Compute constraints
f1_y = -foot_distance_y;
f2_y = foot_distance_y;

additionalFirstStepDuration = 100;

fs_sequence_x = zeros(S+D+additionalFirstStepDuration,1);
fs_sequence_y = zeros(S+D+additionalFirstStepDuration,1);
fs_sequence_z = zeros(S+D+additionalFirstStepDuration,1);

for i = 1:28
    f1_x = fs_matrix(i,1);
    f2_x = fs_matrix(i+1,1);
    
    f1_y = fs_matrix(i,2);
    f2_y = fs_matrix(i+1,2);
    
    f1_z = fs_matrix(i,3);
    f2_z = fs_matrix(i+1,3);
    
    fs_sequence_x = [fs_sequence_x; ones(S,1) * f1_x; f1_x + (1:D)'*(f2_x-f1_x)/D];
    fs_sequence_y = [fs_sequence_y; ones(S,1) * f1_y; f1_y + (1:D)'*(f2_y-f1_y)/D];
    fs_sequence_z = [fs_sequence_z; ones(S,1) * f1_z; f1_z + (1:D)'*(f2_z-f1_z)/D];
end

fs_sequence_x(1) = [];
fs_sequence_y(1) = [];
fs_sequence_z(1) = [];

zx_min = fs_sequence_x - w;
zx_max = fs_sequence_x + w;  

zy_min = fs_sequence_y - w;
zy_max = fs_sequence_y + w;

zz_min = fs_sequence_z - w;
zz_max = fs_sequence_z + w;

zy_min(1:S+D+additionalFirstStepDuration-1) = zy_min(1:S+D+additionalFirstStepDuration-1) - foot_distance_y;
zy_max(1:S+D+additionalFirstStepDuration-1) = zy_max(1:S+D+additionalFirstStepDuration-1) + foot_distance_y;

%% Compute matrices
p = ones(N,1);
P = delta*tril(ones(N,N));
A = [P;-P];

%% Compute stability constraint
Aeq = (1-exp(-omega*delta))/omega * exp(-omega*delta*(0:N-1)) - exp(-omega*delta*N) * delta * ones(1,N);

%% Solve
simTime = 1200;
for i = 1:simTime
    QZd = 1;
    QZ = 100;
    
    P = delta*tril(ones(N,N));
    H = QZd*eye(N) + QZ*(P'*P);
    f_x = QZ*P'*(zx(i) - fs_sequence_x(i:i+N-1));
    f_y = QZ*P'*(zy(i) - fs_sequence_y(i:i+N-1));
    f_z = QZ*P'*(zz(i) - fs_sequence_z(i:i+N-1));
    
    b_x = [ zx_max(i:i+N-1) - zx(i); - zx_min(i:i+N-1) + zx(i)];
    b_y = [ zy_max(i:i+N-1) - zy(i); - zy_min(i:i+N-1) + zy(i)];
    b_z = [ zz_max(i:i+N-1) - zz(i); - zz_min(i:i+N-1) + zz(i)];
    
    tail_x = exp(-omega*N*delta)*exp(-omega*delta*(0:Np-1))*(1-exp(-omega*delta))*fs_sequence_x(i+N:i+N+Np-1)...
        + exp(-omega*(N+Np)*delta)*fs_sequence_x(i+(N+Np));
    tail_y = exp(-omega*N*delta)*exp(-omega*delta*(0:Np-1))*(1-exp(-omega*delta))*fs_sequence_y(i+N:i+N+Np-1)...
        + exp(-omega*(N+Np)*delta)*fs_sequence_y(i+(N+Np));
    tail_z = exp(-omega*N*delta)*exp(-omega*delta*(0:Np-1))*(1-exp(-omega*delta))*fs_sequence_z(i+N:i+N+Np-1)...
        + exp(-omega*(N+Np)*delta)*fs_sequence_z(i+(N+Np));
    
    beq_x = x(i) + xd(i)/omega - (1-exp(-omega*N*delta))*zx(i) - tail_x;
    beq_y = y(i) + yd(i)/omega - (1-exp(-omega*N*delta))*zy(i) - tail_y;
    beq_z = z(i) + zd(i)/omega - (1-exp(-omega*N*delta))*zz(i) - tail_z - g/omega^2;
    
    options =  optimset('Display','off');
    zd_x = quadprog(H,f_x,A,b_x,Aeq,beq_x,[],[],[],options);
    zd_y = quadprog(H,f_y,A,b_y,Aeq,beq_y,[],[],[],options);
    zd_z = quadprog(H,f_z,A,b_z,Aeq,beq_z,[],[],[],options);
    
    z_pred_x = P*zd_x + zx(i);
    z_pred_y = P*zd_y + zy(i);
    z_pred_z = P*zd_z + zz(i);
    
    ch = cosh(omega*delta);
    sh = sinh(omega*delta);
    A_upd = [ch, sh/omega, 1-ch; omega*sh, ch, -omega*sh; 0, 0, 1];
    B_upd = [delta-sh/omega; 1-ch; delta];
    
    x_updated = A_upd*[x(i); xd(i); zx(i)] + B_upd*zd_x(1);
    y_updated = A_upd*[y(i); yd(i); zy(i)] + B_upd*zd_y(1);
    z_updated = A_upd*[z(i); zd(i); zz(i) + g/omega^2] + B_upd*zd_z(1) - [0; 0; g/omega^2];

    x(i+1) = x_updated(1);
    xd(i+1) = x_updated(2);
    zx(i+1) = x_updated(3);
    
    y(i+1) = y_updated(1);
    yd(i+1) = y_updated(2);
    zy(i+1) = y_updated(3);
    
    z(i+1) = z_updated(1);
    zd(i+1) = z_updated(2);
    zz(i+1) = z_updated(3);
    
    clf
    
%     subplot(3,1,1)
%     hold on
%     plot(zx_max,'m','lineWidth',1);
%     plot(fs_sequence_x,'y','lineWidth',1);
%     plot(zx_min,'m','lineWidth',1);
%     plot(x,'r','lineWidth',2);
%     plot(zx,'b','lineWidth',2);
%     plot(i:i+N-1,z_pred_x,'g','lineWidth',2);
%     plot(i+N:i+N+Np-1,fs_sequence_x(i+N:i+N+Np-1),'k','lineWidth',2);
%     grid on
% 
%     
%     subplot(3,1,2)
%     hold on
%     plot(zy_max,'m','lineWidth',1);
%     plot(fs_sequence_y,'y','lineWidth',1);
%     plot(zy_min,'m','lineWidth',1);
%     plot(y,'r','lineWidth',2);
%     plot(zy,'b','lineWidth',2);
%     plot(i:i+N-1,z_pred_y,'g','lineWidth',2);
%     plot(i+N:i+N+Np-1,fs_sequence_y(i+N:i+N+Np-1),'k','lineWidth',2);
%     grid on
% 
%         
%     subplot(3,1,3)
%     hold on
%     plot(zz_max,'m','lineWidth',1);
%     plot(fs_sequence_z,'y','lineWidth',1);
%     plot(zz_min,'m','lineWidth',1);
%     plot(z,'r','lineWidth',2);
%     plot(zz,'b','lineWidth',2);
%     plot(i:i+N-1,z_pred_z,'g','lineWidth',2);
%     plot(i+N:i+N+Np-1,fs_sequence_z(i+N:i+N+Np-1),'k','lineWidth',2);
%     grid on
% 
%     drawnow
i
end
