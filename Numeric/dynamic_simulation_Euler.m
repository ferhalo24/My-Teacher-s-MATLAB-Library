while t_value <=t_end  
    %% Euler improved integration
    % direct_dynamics_problem; %here extendend state is known
    q_value=q_value+Delta_t*(dq_value+0.5*Delta_t*ddq_value);
    dq_value=dq_value+Delta_t*ddq_value;
    
    t_value=t_value+Delta_t;
    
    %% Assembly Problem, used for constraint projection
    assembly_problem;
    
    %% Direct Dynamics
    direct_dynamics_problem;
    
    %% Update Drawing with Delta_t_refresh period
    if t_value-t_refresh > Delta_t_refresh
        updateDraws;
        t_refresh=t_refresh+Delta_t_refresh;
    end
    
    %% Write Extended State
    printf_extended_state(fid);
end
