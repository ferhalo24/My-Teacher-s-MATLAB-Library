%% Export Assembly Problem

n_Phi=size(Phi,1);
Phi_q=jacobian(Phi,q);

matlabFunction(Phi,'File','Phi_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(Phi_q,'File','Phi_q_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);


dPhi=[dPhiH;
    dPhiNH];
n_dPhi=size(dPhi,1);
dPhi_dq=jacobian(dPhi,dq);
beta=-subs(dPhi,dq,zeros(size(dq)));

matlabFunction(beta,'File','beta_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(dPhi_dq,'File','dPhi_dq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);

ddPhi=[ddPhiH;
       ddPhiNH];
n_ddPhi=size(ddPhi,1);
%ddPhi_ddq=jacobian(ddPhi,ddq); %EQUAL TO dPhi_dq !!!
gamma=-subs(ddPhi,ddq,zeros(size(ddq))); %gamma=simplify(gamma);

matlabFunction(gamma,'File','gamma_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);

%% Export Auxiliar Assembly Problem

n_PhiAux=size(PhiAux,1);
PhiAux_q=jacobian(PhiAux,q);

matlabFunction(PhiAux,'File','PhiAux_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(PhiAux_q,'File','PhiAux_q_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);

n_dPhiAux=size(dPhiAux,1);
dPhiAux_dq=jacobian(dPhiAux,dq);
betaAux=-subs(dPhiAux,dq,zeros(size(dq))); %betaAux=simplify(betaAux);

matlabFunction(betaAux,'File','betaAux_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);
matlabFunction(dPhiAux_dq,'File','dPhiAux_dq_','Vars',{q,t,param},'Optimize',optimize_matlabFunction);

n_ddPhiAux=size(ddPhiAux,1);
%ddPhiAux_ddq=jacobian(ddPhiAux,ddq); %EQUAL TO dPhiAux_dq !!!
gammaAux=-subs(ddPhiAux,ddq,zeros(size(ddq))); %gammaAux=simplify(gamma_aux);

matlabFunction(gammaAux,'File','gammaAux_','Vars',{q,dq,t,param},'Optimize',optimize_matlabFunction);

%assembly_problem_exported=true;
% control.assembly_problem_exported=true;
setControl('assembly_problem_exported',true);
