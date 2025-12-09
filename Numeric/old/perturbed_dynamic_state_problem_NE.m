
    Perturbed_Dyn_State_eq_NE_num=Perturbed_Dyn_State_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value);
    
    x_value=[q_value;
        dq_value;
        ddq_value;
        epsilon_value];
    
    while norm(Perturbed_Dyn_State_eq_NE_num)> Per_Dyn_State_tol
        x_value=x_value- Per_Dyn_State_relax* pinv( J_Perturbed_Dyn_State_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value) ) * Perturbed_Dyn_State_eq_NE_num;
        q_value=x_value(1:n_q,1);
        dq_value=x_value(n_q+1:2*n_q,1);
        ddq_value=x_value(2*n_q+1:3*n_q,1);
        epsilon_value=x_value(3*n_q+1:end,1);
        Perturbed_Dyn_State_eq_NE_num=Perturbed_Dyn_State_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value);
    end
    
    
