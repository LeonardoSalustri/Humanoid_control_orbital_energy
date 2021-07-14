function [state_1] = lip(state,u)

    state_1(1) = state(2);
    state_1(2) = state(1)*u;
    state_1(3) = state(4);
    state_1(4) = state(3)*u-9.81;
    state_1 = state_1';

end
