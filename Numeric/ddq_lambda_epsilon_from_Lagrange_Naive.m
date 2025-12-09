function [ddq_value,epsilon_value]=ddq_lambda_epsilon_from_Lagrange_Naive(q_value, dq_value, t_value)
% function ddq_lambda_epsilon_from_Lagrange_Naive()

% ddq lambda and epsilon from Lagrange Naive Method
%
% This script solves the Newton-Euler+ddPhi equations by assembling a full
% linear system of equations that is solved using the pseudoinverse.
% This avoids problems associated to dependent/zero constraint equations and
% redundant constraint forces. A minimum norm solution is offered for the
% vector of constraints epsilon

global param_value
global lambda_value
global  n_ddq  
global n_dPhi  n_ddPhi

dPhi_dq_value=dPhi_dq_(q_value,t_value,param_value);
coeff_matrix_A=[M_qq_(q_value,t_value,param_value),dPhi_dq_value';
    dPhi_dq_value,zeros(n_ddPhi,n_dPhi)];

indep_term_vector_b=[delta_q_(q_value,dq_value,t_value,param_value);
    gamma_(q_value,dq_value,t_value,param_value)];

unknown_vector_x=pinv(coeff_matrix_A)*indep_term_vector_b;

ddq_value=unknown_vector_x(1:n_ddq,1);
lambda_value=unknown_vector_x(n_ddq+1:n_ddq+n_lambda,1);

epsilon_value=pinv(-FC_qepsilon_(q_value,t_value,param_value))*dPhi_dq_value'*lambda_value;
