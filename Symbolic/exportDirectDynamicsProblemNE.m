function Export_Direct_Dynamics_Problem_NE()
%% Export Direct Dynamics Problem Newton-Euler
global t q dq ddq epsilon param
global Dyn_eq_NE  FC_vepsilon
global M_vq delta_v
global optimize_matlabFunction
global direct_dynamics_problem_NE_exported
global control

%% Export Direct Dynamics Problem Newton-Euler
M_vq=jacobian(Dyn_eq_NE,ddq);

delta_v=subs(Dyn_eq_NE,epsilon,sym(zeros(size(epsilon))));
delta_v=-subs(delta_v,ddq,zeros(size(ddq))); %delta=simplify(delta_q)
FC_vepsilon=-jacobian(Dyn_eq_NE,epsilon); %FC_vepsilon=simplify(FC_vepsilon);

matlabFunction(FC_vepsilon,'File','FC_vepsilon_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(M_vq,'File','M_vq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(delta_v,'File','delta_v_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);


% direct_dynamics_problem_NE_exported=true;
% control.direct_dynamics_problem_NE_exported=true;
setControl('direct_dynamics_problem_NE_exported',true);
end