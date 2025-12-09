%% Export Initial Possition Velocity Problem

n_PhiInit=size(PhiInit,1);

PhiInit_q=jacobian(PhiInit, q);
matlabFunction(PhiInit,'File','PhiInit_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);

matlabFunction(PhiInit_q,'File','PhiInit_q_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);


n_dPhiInit=size(dPhiInit,1);

dPhiInit_dq=jacobian(dPhiInit,dq);
betaInit=-subs(dPhiInit,dq,zeros(size(dq)));

matlabFunction(betaInit,'File','betaInit_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);

matlabFunction(dPhiInit_dq,'File','dPhiInit_dq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);


%initial_assembly_problem_exported=true;
setControl('initial_assembly_problem_exported',true);