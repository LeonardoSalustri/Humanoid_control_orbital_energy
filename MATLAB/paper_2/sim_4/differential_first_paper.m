function [dstate] = differential_first_paper(t,state)
    zf=0.9375;
    u = controller_first_paper(state,zf);
    dstate = lip(state,u);
end

