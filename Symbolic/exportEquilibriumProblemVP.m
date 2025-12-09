function Export_Equilibrium_Problem_VP()
global t q dq ddq epsilon lambda lambda_aux param
global Phi dPhi ddPhi
global PhiAux dPhiAux ddPhiAux
global dPhi_dq Dyn_eq_VP Dyn_eq_L Dyn_Eq_eq_VP Extra_Dyn_Eq_eq
global optimize_matlabFunction
global equilibrium_problem_VP_exported
global control

%% Export Dynamic Equilibrium Problem  "a la" Virtual Power or Lagrange
Dyn_eq_VP_open=subs(Dyn_eq_VP,epsilon,sym(zeros(size(epsilon)))); %Dyn_eq_VP_open=simplify(Dyn_eq_VP_open);
Dyn_eq_L=Dyn_eq_VP_open+dPhi_dq'*lambda;
Dyn_Eq_eq_VP=[Dyn_eq_L;
        ddPhi;
        ddPhiAux;
        dPhi;
        dPhiAux;
        Phi;
        PhiAux;
        Extra_Dyn_Eq_eq];
    
unk_eq_VP=[q;
    dq;
    ddq;
    lambda];

J_Dyn_Eq_eq_VP=jacobian(Dyn_Eq_eq_VP,unk_eq_VP);

matlabFunction(Dyn_Eq_eq_VP,'File','Dyn_Eq_eq_VP_','Vars',{q,dq,ddq,t,lambda,param},'Optimize',optimize_matlabFunction);
matlabFunction(J_Dyn_Eq_eq_VP,'File','J_Dyn_Eq_eq_VP_','Vars',{q,dq,ddq,t,lambda,param},'Optimize',optimize_matlabFunction);

equilibrium_problem_VP_exported=true;
control.equilibrium_problem_VP_exported=true;
end