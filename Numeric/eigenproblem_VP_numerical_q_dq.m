function [eigenvalues_q_dq,eigenvectors_q,eigenvectors_dq,A]=eigenproblem_VP_numerical_q_dq()
global q_value dq_value t_value
global q n_q

global has_my_piezewise_functions_in_Phi

if has_my_piezewise_functions_in_Phi
    my_piezewise_functions_in_Phi();
end

[A,err]=jacobianest(@(x)d_q_dq_(t_value,x),[q_value;dq_value]);
[V,D]=eig(A,'nobalance');
eigenvalues_q_dq=diag(D);

eigenvectors_q=V(1:n_q,:);
eigenvectors_dq=V(n_q+1:end,:);

