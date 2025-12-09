function d_z_dz=d_z_dz_(t,z_dz,perm_d_z,n_d,perm_dd_dz,n_dd)
global t_value q_value dq_value ddq_value epsilon_value lambda_value param_value
global has_my_piezewise_functions_in_Phi

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end


n_z=length(q_value)-n_d;

n_dz=length(dq_value)-n_dd;

%% Extended state saved, becuse it is going to be changed to solve for accelerations and they are global
q_value_saved=q_value;
dq_value_saved=dq_value;
ddq_value_saved=ddq_value;
epsilon_value_saved=epsilon_value;
lambda_value_saved=lambda_value;
t_value_saved=t_value;

t_value=t;
n_q=length(q_value);

%% Set only the independent part of vectors q and dq
q_value(perm_d_z(n_d+1:end))=z_dz(1:n_z);
dq_value(perm_dd_dz(n_dd+1:end))=z_dz(n_z+1:end);

%% The remaining component of q and dq are determined using the weighted projection problem trick
W_q(perm_d_z)=[ones(1,n_d),zeros(1,n_z)];
W_dq(perm_dd_dz)=[ones(1,n_dd),zeros(1,n_dz)];

[q_value,dq_value]=constraint_projection_problem_weighted(q_value, dq_value, t_value, param_value, diag(W_q), diag(W_dq) );

%% Now ddq epsilon and lambda are computed 
solveDirectDynamicsProblem;
%% State on independent coordinates and velocities is assembled again
d_z_dz=[dq_value(perm_d_z(n_d+1:end));ddq_value(perm_dd_dz(n_dd+1:end))];

%% global t, q, dq, epsilon and lambda values are restored
q_value=q_value_saved;
dq_value=dq_value_saved;
ddq_value=ddq_value_saved;
epsilon_value=epsilon_value_saved;
lambda_value=lambda_value_saved;
t_value=t_value_saved;
end