function dx=d_q_dq_kinematics_(t,x)
global t_value q_value dq_value ddq_value epsilon_value lambda_value param_value
q_value_saved=q_value;
dq_value_saved=dq_value;
ddq_value_saved=ddq_value;
epsilon_value_saved=epsilon_value;
% lambda_value_saved=lambda_value;
t_value_saved=t_value;

t_value=t;
n_q=size(q_value,1);
q_value=x(1:n_q);
dq_value=x(n_q+1:end);

% assembly_problem;
% constraint_projection_problem(q_value, dq_value, t_value, param_value )
% [ddq_value,epsilon_value]=ddq_lambda_epsilon_from_Lagrange_Naive(q_value, dq_value, t_value, param_value);
assembly_problem_accel;
dx=[dq_value;ddq_value];

q_value=q_value_saved;
dq_value=dq_value_saved;
ddq_value=ddq_value_saved;
epsilon_value=epsilon_value_saved;
% lambda_value=lambda_value_saved;
t_value=t_value_saved;
end