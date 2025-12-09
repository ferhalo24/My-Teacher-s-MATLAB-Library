function saveExtendedState(dynamic_extended_state_mat_file_name)
global q_value dq_value ddq_value t_value param_value epsilon_value lambda_value  lambda_aux_value
save(dynamic_extended_state_mat_file_name, 'q_value', 'dq_value', 'ddq_value', 't_value', 'param_value', 'epsilon_value', 'lambda_value', 'lambda_aux_value', 'param_value');

end