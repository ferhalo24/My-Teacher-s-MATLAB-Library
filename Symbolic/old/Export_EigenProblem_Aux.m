function Export_EigenProblem(dyn_equations_type)
global t q dq ddq epsilon lambda lambda_aux param
global delta_v delta_q
global dPhi dPhi_dq ddPhi
global dPhiAux dPhiAux_dq ddPhiAux
global Dyn_eq_VP Dyn_eq_L
global optimize_matlabFunction
global eigen_problem_VP_exported
global control
global K_qq C_qq

%% Export Eigenvalue Problem
dPhi_q=jacobian(dPhi,q);
ddPhi_q=jacobian(ddPhi,q);
ddPhi_dq=jacobian(ddPhi,dq);

matlabFunction(dPhi_q,'File','dPhi_q_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(ddPhi_q,'File','ddPhi_q_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(ddPhi_dq,'File','ddPhi_dq_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);

dPhiAux_q=jacobian(dPhiAux,q);
ddPhiAux_q=jacobian(ddPhiAux,q);
ddPhiAux_dq=jacobian(ddPhiAux,dq);


matlabFunction(dPhiAux_q,'File','dPhiAux_q_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(ddPhiAux_q,'File','ddPhiAux_q_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(ddPhiAux_dq,'File','ddPhiAux_dq_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);

Dyn_eq_VP_open=subs(Dyn_eq_VP,epsilon,sym(zeros(size(epsilon)))); %Dyn_eq_VP_open=simplify(Dyn_eq_VP_open);

dPhiAux_dq=jacobian(dPhiAux,dq);
Dyn_eq_L=Dyn_eq_VP_open+[dPhi_dq;dPhiAux_dq]'*[lambda;lambda_aux];
    
K_qq=jacobian(Dyn_eq_L,q); %K=simplify(K);
C_qq=jacobian(Dyn_eq_L,dq); %C=simplify(C);

matlabFunction(K_qq,'File','K_qq_','Vars',{q,dq,ddq,lambda,lambda_aux,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(C_qq,'File','C_qq_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);

eigen_problem_VP_exported=true;
control.eigen_problem_VP_exported=true;
