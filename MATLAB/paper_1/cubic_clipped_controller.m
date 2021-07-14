function u =  cubic_clipped_controller(state,zf)
    % Return the controller input.
    % Pass the state as a vector state = [x,xd,z,zd]
    u = max(cubic_orbital_energy_controller(state,zf),0);
end