function Export_Perturbed_Dynamic_State_Problem_VP()
global t q dq ddq epsilon lambda lambda_aux param
global Phi dPhi ddPhi Dyn_eq_VP Dyn_eq_L dPhi_dq Perturbed_Dyn_State_eq_VP Extra_Perturbed_Dyn_State_eq
global optimize_matlabFunction
global perturbation_problem_VP_exported
global control

%% Export Perturbed Dynamic State problem "a la" Virtual Power or Lagrange
Dyn_eq_VP_open=subs(Dyn_eq_VP,epsilon,sym(zeros(size(epsilon)))); %Dyn_eq_VP_open=simplify(Dyn_eq_VP_open);
Dyn_eq_L=Dyn_eq_VP_open+dPhi_dq'*lambda;
Perturbed_Dyn_State_eq_VP=[Dyn_eq_L;
        ddPhi;
        dPhi;
        Phi;
        Extra_Perturbed_Dyn_State_eq];
    
unk_st_VP=[q;
    dq;
    ddq;
    lambda];

J_Perturbed_Dyn_State_eq_VP=jacobian(Perturbed_Dyn_State_eq_VP,unk_st_VP);

if isempty(lambda)
    matlabFunction(Perturbed_Dyn_State_eq_VP,'File','Perturbed_Dyn_State_eq_VP_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
    matlabFunction(J_Perturbed_Dyn_State_eq_VP,'File','J_Perturbed_Dyn_State_eq_VP_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
else
    matlabFunction(Perturbed_Dyn_State_eq_VP,'File','Perturbed_Dyn_State_eq_VP_','Vars',{q,dq,ddq,t,lambda,param},'Optimize',optimize_matlabFunction);
    matlabFunction(J_Perturbed_Dyn_State_eq_VP,'File','J_Perturbed_Dyn_State_eq_VP_','Vars',{q,dq,ddq,t,lambda,param},'Optimize',optimize_matlabFunction);
end

perturbation_problem_VP_exported=true;
control.perturbation_problem_VP_exported=true;