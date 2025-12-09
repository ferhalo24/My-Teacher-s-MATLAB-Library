while t_value <=t_end
    %% RK4 improved integration
    coeff_matrix_A=[M_(q_value,t_value,param_value),V_(q_value,t_value,param_value);
    dPhi_dq_(q_value,t_value,param_value),zeros(n_dPhi,n_epsilon)];
    
    indep_term_vector_b=[delta_(q_value,dq_value,t_value,param_value);gamma_(q_value,dq_value,t_value,param_value)];
    
    unknown_vector_x=inv(coeff_matrix_A)*indep_term_vector_b;
    
    ddq_value=unknown_vector_x(1:n_q,1);
    epsilon_value=unknown_vector_x(n_q+1:end,1);
    
    
    q_k1=Delta_t*dq_value;
    dq_k1=Delta_t*ddq_value;
    
    % Computing k2
    
    t_value=t_value+Delta_t/2;
    
    q2=q_value+q_k1/2;
    dq2=dq_value+dq_k1/2;
    
    coeff_matrix_A=[M_(q2,t_value,param_value),V_(q2,t_value,param_value);
        dPhi_dq_(q2,t_value,param_value),zeros(n_dPhi,n_epsilon)];
    
    indep_term_vector_b=[delta_(q2,dq2,t_value,param_value);gamma_(q2,dq2,t_value,param_value)];
    
    unknown_vector_x=inv(coeff_matrix_A)*indep_term_vector_b;
    
    ddq_value=unknown_vector_x(1:n_q,1);
    epsilon_value=unknown_vector_x(n_q+1:end,1);
    
    q_k2=Delta_t*dq2;
    dq_k2=Delta_t*ddq_value;
    
    % Computing k3
    
    q3=q_value+q_k2/2;
    dq3=dq_value+dq_k2/2;
    
    coeff_matrix_A=[M_(q3,t_value,param_value),V_(q3,t_value,param_value);
        dPhi_dq_(q3,t_value,param_value),zeros(n_dPhi,n_epsilon)];
    
    indep_term_vector_b=[delta_(q3,dq3,t_value,param_value);gamma_(q3,dq3,t_value,param_value)];
    
    unknown_vector_x=inv(coeff_matrix_A)*indep_term_vector_b;
    
    ddq_value=unknown_vector_x(1:n_q,1);
    epsilon_value=unknown_vector_x(n_q+1:end,1);
    
    q_k3=Delta_t*dq3;
    dq_k3=Delta_t*ddq_value;
    
    
    % Computing k4
    
    t_value=t_value+Delta_t/2
    
    q4=q_value+q_k3;
    dq4=dq_value+dq_k3;
    
    coeff_matrix_A=[M_(q4,t_value,param_value),V_(q4,t_value,param_value);
        dPhi_dq_(q4,t_value,param_value),zeros(n_dPhi,n_epsilon)];
    
    indep_term_vector_b=[delta_(q4,dq4,t_value,param_value);gamma_(q4,dq4,t_value,param_value)];
    
    unknown_vector_x=inv(coeff_matrix_A)*indep_term_vector_b;
    
    ddq_value=unknown_vector_x(1:n_q,1);
    epsilon_value=unknown_vector_x(n_q+1:end,1);
    
    q_k4=Delta_t*dq4;
    dq_k4=Delta_t*ddq_value;
    
    
    % Position Actualization
    
    q_value=q_value+1/6*(q_k1+2*q_k2+2*q_k3+q_k4);
    
    
    % Velocity Actualization
    
    dq_value=dq_value+1/6*(dq_k1+2*dq_k2+2*dq_k3+dq_k4);
    
    % t_value=t_value+Delta_t;
    
    %% Assembly Problem
    % used for constraint projection
    assembly_problem;
    
    %% Update Drawing with Delta_t_refresh period
    if t_value-t_refresh > Delta_t_refresh
        updateDraws;
        t_refresh=t_refresh+Delta_t_refresh;
    end
    
    %% Write Extended State
    printf_extended_state(fid);
end


