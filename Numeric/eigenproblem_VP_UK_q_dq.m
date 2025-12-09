function [eigenvalues_q_dq,eigenvectors_q,eigenvectors_dq,A]=eigenproblem_VP_UK_q_dq()

global q_value dq_value ddq_value lambda_value lambda_aux_value t_value param_value
global n_q

global has_my_piezewise_functions_in_Phi

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

Phi_q_num=[Phi_q_(q_value,t_value,param_value);
    PhiAux_q_(q_value,t_value,param_value)];

dPhi_dq_num=[dPhi_dq_(q_value,t_value,param_value);
    dPhiAux_dq_(q_value,t_value,param_value)];

M_qq_num=M_qq_(q_value,t_value,param_value);
C_qq_num=C_qq_(q_value,dq_value,t_value,param_value);
K_qq_num=K_qq_(q_value,dq_value,ddq_value,lambda_value,lambda_aux_value,t_value,param_value);

inv_M_qq_num=inv(M_qq_num);
aux=dPhi_dq_num*inv_M_qq_num;

weightpinvdPhi_dq=aux'*pinv(aux*dPhi_dq_num');
PainvM_qq=inv_M_qq_num-weightpinvdPhi_dq*aux;

dPhi_q_num=[dPhi_q_(q_value,dq_value,t_value,param_value);
            dPhiAux_q_(q_value,dq_value,t_value,param_value)];
ddPhi_q_num=[ddPhi_q_(q_value,dq_value,ddq_value,t_value,param_value);
             ddPhiAux_q_(q_value,dq_value,ddq_value,t_value,param_value)];
ddPhi_dq_num=[ddPhi_dq_(q_value,dq_value,t_value,param_value);
              ddPhiAux_dq_(q_value,dq_value,t_value,param_value)];

A=[zeros(n_q,n_q),eye(n_q);
    -PainvM_qq*K_qq_num-weightpinvdPhi_dq*ddPhi_q_num, -PainvM_qq*C_qq_num-weightpinvdPhi_dq*ddPhi_dq_num];

[V,D]=eig(A,'nobalance');
eigenvalues_q_dq=diag(D);

eigenvectors_q=V(1:n_q,:);
eigenvectors_dq=V(n_q+1:end,:);
    
end