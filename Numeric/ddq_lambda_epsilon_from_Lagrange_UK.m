
function [ddq_value,epsilon_value]=ddq_lambda_epsilon_from_Lagrange_UK(q_value, dq_value, t_value, param_value)

% Udwadia & Kabala Direct Dynamics Problem
%
% This script solves the Lagrange+ddPhi equations by first obtainig ddq in
% terms of lambda using the Dynamic eq. Then, using this result, lambda is
% obtained in terms of q and dq using the constraint eqs at the acceleration
% level. Finally, using this result, the accerations are obtained form the
% dynamic equations

global lambda_value

M_qq_value=M_qq_(q_value,t_value,param_value);
delta_q_value=delta_q_(q_value,dq_value,t_value,param_value);

dPhi_dq_value=dPhi_dq_(q_value,t_value,param_value);
gamma_value=gamma_(q_value,dq_value,t_value,param_value);

invM_qq=inv(M_qq_value);
aux=dPhi_dq_value*invM_qq;
inv_aux_dPhi_dq_p=pinv(aux*dPhi_dq_value');

n_ddq=size(q_value,1);

lambda_value=-inv_aux_dPhi_dq_p*(gamma_value-aux*delta_q_value);
ddq_value=-aux'*lambda_value+invM_qq*delta_q_value;

epsilon_value=pinv(-FC_qepsilon_(q_value,t_value,param_value))*dPhi_dq_value'*lambda_value;

% weightpinvdPhi_dq=aux'*inv_aux_dPhi_dq_p;

% %         aux=pinv([M_qq_(q_value,t_value,param_value),-FC_qepsilon_(q_value,t_value,param_value);
% %          M_OCqq_(q_value,t_value,param_value), -FC_OCqepsilon_(q_value,t_value,param_value);
% %          dPhi_dq_value, zeros(n_dPhi,size(epsilon_value,1))])*[delta_q_(q_value,dq_value,t_value,param_value);
% %                                                                delta_OCq_(q_value,dq_value,t_value,param_value);
% %                                                                gamma_value                                         ];
% %         ddq_value=aux(1:n_q,1);
% %         epsilon_value=aux(n_q+1:end,1);

if exist('FC_OCqepsilon_','file')==2
    FC_OCqepsilon_value=FC_OCqepsilon_(q_value,t_value,param_value);
    delta_epsilon_value=pinv(FC_OCqepsilon_value(:,1:n_epsilono))*(M_OCqq_(q_value,t_value,param_value)*ddq_value-delta_OCq_(q_value,dq_value,t_value,param_value)-FC_OCqepsilon_value(:,n_epsilono+1:n_epsilon)*epsilon_value(n_epsilono+1:n_epsilon,1));
    epsilon_value=[delta_epsilon_value;epsilon_value(15:17,1)];
end

