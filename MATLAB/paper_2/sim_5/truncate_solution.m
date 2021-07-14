function [tout,out] = truncate_solution(t,state,z0,x_des_array)
instant = 1;

    for i=1:1:length(t)
        if state(i,3) - z0 <= 1e-3 && abs(state(i,1)-x_des_array(i))<=1e-3
            break;
        end
        instant=instant+1;
    end
    tout = t(1:instant-1);
    out = state(1:instant-1,:);
end

