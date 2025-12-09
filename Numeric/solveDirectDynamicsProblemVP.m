function direct_dynamics_problem_VP()

global  has_my_contact_forzes updateDraws_automatic
global t_value q_value dq_value ddq_value epsilon_value param_value

if has_my_contact_forzes==true
    my_contact_forzes();
end

% ddq lambda and epsilon from Lagrange Naive
[ddq_value,epsilon_value]=ddq_lambda_epsilon_from_Lagrange_Naive(q_value, dq_value, t_value, param_value);

if updateDraws_automatic
    updateDraws;
end
