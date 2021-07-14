function [tout1,out1] = truncate_last_step(tout,out,zf)
    flag=1;
    j = 1;
    while flag == 1
        if (abs(out(j,3)-zf)<1e-3 && abs(out(j,1))<1e-3 && abs(out(j,2))<1e-3) || j+1==length(out(:,1))
            tout1 = tout(1:j-1);
            out1 = out(1:j-1,:);
            break;
        end
        j=j+1;
    end

end

