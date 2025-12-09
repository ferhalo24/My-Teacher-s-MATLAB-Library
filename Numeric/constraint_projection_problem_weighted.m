function [q_value,dq_value]=constraint_projection_problem_weighted(q_value, dq_value, t_value, param_value, W_q_half, W_dq_half )

global updateDraws_automatic
global Geom_Eq_tol Geom_Eq_relax
global has_my_piezewise_functions_in_Phi

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

% Assembly Problem (Coordinate Level)
Phi_num=Phi_(q_value,t_value,param_value);
Phi_q_num=Phi_q_(q_value,t_value,param_value);
weighted_pinv_q=W_q_half*pinv(Phi_q_num*W_q_half);
q_value = q_value - Geom_Eq_relax * weighted_pinv_q * Phi_num;

Phi_num = Phi_(q_value,t_value,param_value);
while norm(Phi_num)> Geom_Eq_tol
    Phi_q_num=Phi_q_(q_value,t_value,param_value);
    weighted_pinv_q=W_q_half*pinv(Phi_q_num*W_q_half);
    q_value = q_value - Geom_Eq_relax * weighted_pinv_q * Phi_num;
    Phi_num = Phi_(q_value,t_value,param_value);
end

% Assembly Problem (Velocity Level)
dPhi_dq_num=dPhi_dq_(q_value,t_value,param_value);
weighted_pinv_dq=W_dq_half*pinv(dPhi_dq_num*W_dq_half);
dq_value=dq_value - weighted_pinv_dq * ( dPhi_dq_num * dq_value - beta_(q_value,t_value,param_value));

if updateDraws_automatic
    updateDraws;
end