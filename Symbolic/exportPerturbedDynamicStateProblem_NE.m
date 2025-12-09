function Export_Perturbed_Dynamic_State_Problem_NE()
global t q dq ddq epsilon param
global Phi dPhi ddPhi Dyn_eq_NE Perturbed_Dyn_State_eq_NE Extra_Perturbed_Dyn_State_eq
global optimize_matlabFunction
global perturbation_problem_NE_exported
global control

    %% Export Perturbed Dynamic State problem "a la" Newton-Euler
    Perturbed_Dyn_State_eq_NE=[Dyn_eq_NE;
        ddPhi;
        dPhi;
        Phi;
        Extra_Perturbed_Dyn_State_eq];
    
    unk_st_NE=[q;
        dq;
        ddq;
        epsilon];
    
    J_Perturbed_Dyn_State_eq_NE=jacobian(Perturbed_Dyn_State_eq_NE,unk_st_NE);
    
    if isempty(epsilon)
        matlabFunction(Perturbed_Dyn_State_eq_NE,'File','Perturbed_Dyn_State_eq_NE_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
        matlabFunction(J_Perturbed_Dyn_State_eq_NE,'File','J_Perturbed_Dyn_State_eq_NE_','Vars',{q,dq,ddq,t,param},'Optimize',optimize_matlabFunction);
    else
        matlabFunction(Perturbed_Dyn_State_eq_NE,'File','Perturbed_Dyn_State_eq_NE_','Vars',{q,dq,ddq,t,epsilon,param},'Optimize',optimize_matlabFunction);
        matlabFunction(J_Perturbed_Dyn_State_eq_NE,'File','J_Perturbed_Dyn_State_eq_NE_','Vars',{q,dq,ddq,t,epsilon,param},'Optimize',optimize_matlabFunction);
    end
    
    perturbation_problem_NE_exported=true;
    control.perturbation_problem_NE_exported=true;
    