%----------------------------
   n_q=n_q_nonaux;
   
   
M_=M(q0,t,param)
C_=C(q0,dq0,t,param)
K_=K(q0,dq0,ddq0,lambda0,t,param)
dPhi_dq_=dPhi_dq(q0,t,param)

    
   dPhi_dq_q_=dPhi_dq_(perm_dphi,1:n_q);
   dPhi_ds_q_=dPhi_dq_(perm_dphi,n_q+1:end);
   dPhi_dq_s_=dPhi_dq_(2,1:n_q);
   dPhi_ds_s_=dPhi_dq_(2,n_q+1:end);
   Beta=-dPhi_ds_s_^-1*dPhi_dq_s_;
   delta_=delta(q,dq,t,param);
   delta_q_=delta_(1:n_q);
   delta_s_=delta_(n_q+1:end);
   
   M_dqdq_=[eye(n_q);Beta]'*M_*[eye(n_q);Beta];
   K_dqdq_=[eye(n_q);Beta]'*K_*[eye(n_q);Beta];
   C_dqdq_=[eye(n_q);Beta]'*C_*[eye(n_q);Beta];
   
   gamma1_=gamma1(q,dq,t,param);
   gamma1_q_=gamma1_(perm_dphi);
   gamma1_s_=gamma1_(2);
   ddqlambda=pinv([M_dqdq_,(dPhi_dq_q_+dPhi_ds_q_*Beta)';(dPhi_dq_q_+dPhi_ds_q_*Beta),zeros(7,7)])*...
       [(delta_q_+Beta'*delta_s_);gamma1_q_-dPhi_ds_q_*dPhi_ds_s_^-1*gamma1_s_];
   n_dPhi_dq_q_=size(dPhi_dq_q_,1);
   n_lambda=n_dPhi_dq_q_;
 A=[M_dqdq_,zeros(n_q,n_q),zeros(n_q,n_lambda);
    zeros(n_dPhi_dq_q_,n_q),zeros(n_dPhi_dq_q_,n_q),zeros(n_dPhi_dq_q_,n_lambda2);
    zeros(n_q,n_q),eye(n_q),zeros(n_q,n_lambda2)]
 B=[-C_dqdq_,-K_dqdq_,-(dPhi_dq_q_+dPhi_ds_q_*Beta)';
   zeros(n_dPhi_dq_q_,n_q),(dPhi_dq_q_+dPhi_ds_q_*Beta),zeros(n_dPhi_dq_q_,n_lambda2);
   eye(n_q),zeros(n_q,n_q),zeros(n_q,n_lambda2)]

[V,D]=eig(B,A)

