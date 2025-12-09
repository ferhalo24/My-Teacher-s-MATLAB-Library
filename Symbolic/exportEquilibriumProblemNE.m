function Export_Equilibrium_Problem_NE()
global t q dq ddq epsilon  param
global Phi dPhi ddPhi
global PhiAux dPhiAux ddPhiAux
global Dyn_eq_NE Dyn_Eq_eq_NE Extra_Dyn_Eq_eq
global optimize_matlabFunction

%% Export Equilibrium problem "a la" Newton-Euler
Dyn_Eq_eq_NE=[Dyn_eq_NE;
        ddPhi;
        ddPhiAux;
        dPhi;
        dPhiAux;
        Phi;
        PhiAux;
        Extra_Dyn_Eq_eq];

unk_eq_NE=[q;
    dq;
    ddq;
    epsilon];

J_Dyn_Eq_eq_NE=jacobian(Dyn_Eq_eq_NE,unk_eq_NE);

matlabFunction(Dyn_Eq_eq_NE,'File','Dyn_Eq_eq_NE_','Vars',{q,dq,ddq,t,epsilon,param},'Optimize',optimize_matlabFunction);
matlabFunction(J_Dyn_Eq_eq_NE,'File','J_Dyn_Eq_eq_NE_','Vars',{q,dq,ddq,t,epsilon,param},'Optimize',optimize_matlabFunction);

end