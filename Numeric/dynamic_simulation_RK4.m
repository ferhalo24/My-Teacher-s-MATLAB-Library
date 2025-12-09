while t_value <=t_end
    %% RK4 improved integration
    t_value_0=t_value;
    q_value_0=q_value;
    dq_value_0=dq_value;
    
    % Computing k1
    %direct_dynamics_problem; %here extendend state is known
    q_k1=Delta_t*dq_value;
    dq_k1=Delta_t*ddq_value;
    
    % Computing k2
    
    t_value=t_value_0+Delta_t/2;
    q_value=q_value_0+q_k1/2;
    dq_value=dq_value_0+dq_k1/2;
    
    direct_dynamics_problem;
    
    q_k2=Delta_t*dq_value;
    dq_k2=Delta_t*ddq_value;
    
    % Computing k3
    t_value=t_value_0+Delta_t/2;
    q_value=q_value_0+q_k2/2;
    dq_value=dq_value_0+dq_k2/2;
    
    direct_dynamics_problem;
    
    q_k3=Delta_t*dq_value;
    dq_k3=Delta_t*ddq_value;
    
    % Computing k4
    
    t_value=t_value_0+Delta_t;
    q_value=q_value_0+q_k3;
    dq_value=dq_value_0+dq_k3;
    
    q_k4=Delta_t*dq_value;
    dq_k4=Delta_t*ddq_value;
    
    % Position Actualization
    q_value=q_value_0+1/6*(q_k1+2*q_k2+2*q_k3+q_k4);
    
    % Velocity Actualization
    dq_value=dq_value_0+1/6*(dq_k1+2*dq_k2+2*dq_k3+dq_k4);
    
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
