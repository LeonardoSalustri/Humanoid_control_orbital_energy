%%takes the horizontal displacement of the orbital energy approach and
%%transforms everything into a world frame, 

%%TO RUN AFTER THE SCRIPTS WITH THE ORBITAL ENERGY APPROACH

out = out_tot;
da_sommare = 0;
da_sommare1 = 0;
flag=0;
len = size(tout_tot/delta);
for i=1:1:len(2)-1
    out(i,1) = out(i,1)+abs(da_sommare1)+da_sommare;
    if out(i,1)>0 && out(i+1,1)<0 && flag==0
        flag=1;
        da_sommare = out(i,1);
        da_sommare1 = out(i+1,1);
    elseif out(i,1)>0 && out(i+1,1)>0 && flag==1
        flag=0;
    end
end

%x_com
figure()
plot(tout_tot,out(:,1),"r","LineWidth",2);
xlabel("Time[s]","FontSize",15,'interpreter','latex');
ylabel("$x[m]$","FontSize",15,'interpreter','latex');
legend("$x$",'interpreter','latex');
xlim([0 5.5])
grid;
