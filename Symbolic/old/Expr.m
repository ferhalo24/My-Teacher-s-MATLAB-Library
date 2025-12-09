function out=Expr(in)

global t t_value
global q q_value
global dq dq_value
global ddq ddq_value
global param param_value
global epsilon epsilon_value
global lambda lambda_value

out=double(subs(in,[q;dq;ddq;t;param;epsilon;sym(pi)],[q_value;dq_value;ddq_value;t_value;param_value;epsilon_value;double(pi)]));
end