function [ddq_value,epsilon_value,lambda_value,lambda_aux_value]=ddq_epsilon_from_Newton_Euler_Naive(q_value, dq_value, t_value)
% function ddq_epsilon_from_Newton_Euler_Naive()

%ddq and epsilon from Newton Euler Naive Method
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

lambda_value=zeros(n_lambda,1);
lambda_aux_value=zeros(n_lambda_aux,1);

dPhiAux_dq_value=dPhiAux_dq_(q_value,t_value,param_value);
FC_vepsilon_value=FC_vepsilon_(q_value,t_value,param_value);
coeff_matrix_A=[M_vq_(q_value,t_value,param_value),-FC_vepsilon_value;
    dPhi_dq_(q_value,t_value,param_value),zeros(n_dPhi,n_epsilon);
    dPhiAux_dq_value,zeros(n_ddPhiAux,n_epsilon)];

indep_term_vector_b=[delta_v_(q_value,dq_value,t_value,param_value);
    gamma_(q_value,dq_value,t_value,param_value);
    gammaAux_(q_value,dq_value,t_value,param_value)];

unknown_vector_x=pinv(coeff_matrix_A)*indep_term_vector_b;

ddq_value=unknown_vector_x(1:n_ddq,1);
epsilon_value=unknown_vector_x(n_ddq+1:n_ddq+n_epsilon,1);

