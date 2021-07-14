function [tout,out] = truncate_solution(t,state,z0,v_des_next,changed)
instant = 1;
x_star = 0.18;
    for i=1:1:length(t)
        if abs(state(i,3) - z0)<=1e-3 
            if changed == 0 
                if state(i,1) >= 0.25
                    break; 
                end
            elseif changed==-1
                if state(i,1) >= 0.25
                    break; 
                end
                
            else
                if state(i,2) >= v_des_next + 0.2
                    break;
                end
            end
        end
        instant = instant + 1;
    end
    tout = t(1:instant-1);
    out = state(1:instant-1,:);
end

