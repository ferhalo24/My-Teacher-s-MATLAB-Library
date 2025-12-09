
if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

Dyn_Eq_eq_NE_num=Dyn_Eq_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value);

x_value=[q_value;
    dq_value;
    ddq_value;
    epsilon_value];

while norm(Dyn_Eq_eq_NE_num)> Dyn_Eq_tol
    x_value=x_value- Dyn_Eq_relax* pinv( J_Dyn_Eq_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value) ) * Dyn_Eq_eq_NE_num;
    q_value=x_value(1:n_q,1);
    dq_value=x_value(n_q+1:2*n_q,1);
    ddq_value=x_value(2*n_q+1:3*n_q,1);
    epsilon_value=x_value(3*n_q+1:end,1);

    if has_my_piezewise_functions_in_Phi
        my_piezewise_functions_in_Phi();
    end

    Dyn_Eq_eq_NE_num=Dyn_Eq_eq_NE_(q_value,dq_value,ddq_value,t_value,epsilon_value,param_value);
end


if updateDraws_automatic
    updateDraws;
end