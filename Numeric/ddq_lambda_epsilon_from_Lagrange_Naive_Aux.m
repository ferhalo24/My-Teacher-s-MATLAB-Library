function [ddq_value,epsilon_value,lambda_value,lambda_aux_value]=ddq_lambda_epsilon_from_Lagrange_Naive(q_value, dq_value, t_value)
% function ddq_lambda_epsilon_from_Lagrange_Naive()

% ddq lambda and epsilon from Lagrange Naive Method
%
% This script solves the Newton-Euler+ddPhi equations by assembling a full
% linear system of equations that is solved using the pseudoinverse.
% This avoids problems associated to dependent/zero constraint equations and
% redundant constraint forces. A minimum norm solution is offered for the
% vector of constraints epsilon

global param_value
global n_q n_dq n_ddq n_epsilon n_lambda n_lambda_aux
global n_PhiAux n_dPhiAux n_ddPhiAux
global n_Phi n_dPhi n_ddPhi

dPhi_dq_value=dPhi_dq_(q_value,t_value,param_value);
dPhiAux_dq_value=dPhiAux_dq_(q_value,t_value,param_value);
coeff_matrix_A=[M_qq_(q_value,t_value,param_value),dPhi_dq_value',dPhiAux_dq_value';
    dPhi_dq_value,zeros(n_ddPhi,n_lambda+n_lambda_aux)
    dPhiAux_dq_value,zeros(n_ddPhiAux,n_lambda+n_lambda_aux)];

indep_term_vector_b=[delta_q_(q_value,dq_value,t_value,param_value);
    gamma_(q_value,dq_value,t_value,param_value)
    gammaAux_(q_value,dq_value,t_value,param_value)];

unknown_vector_x=pinv(coeff_matrix_A)*indep_term_vector_b;

ddq_value=unknown_vector_x(1:n_ddq,1);
lambda_value=unknown_vector_x(n_ddq+1:n_ddq+n_lambda,1);
lambda_aux_value=unknown_vector_x(n_ddq+n_lambda+1:n_ddq+n_lambda+n_lambda_aux,1);

epsilon_value=pinv(-FC_qepsilon_(q_value,t_value,param_value))*dPhi_dq_value'*lambda_value;
