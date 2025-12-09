function [coord,dcoord,ddcoord]=newPhi(Phi_eqs,optimize)
global Phi dPhi ddPhi dPhiH ddPhiH
global n_Phi n_dPhi n_ddPhi n_dPhiH n_ddPhiH
global simplify_expressions
dPhi_eqs=timederivative(Phi_eqs);
ddPhi_eqs=timederivative(dPhi_eqs);
if nargin==1
    optimize=simplify_expressions;
end
if optimize && (size(Phi_eqs,1)>0)
    Phi_eqs=simplify(Phi_eqs);
    dPhi_eqs=simplify(dPhi_eqs);
    ddPhi_eqs=simplify(ddPhi_eqs);
end
Phi=[Phi;
     Phi_eqs];
n_Phi=size(Phi,1);
dPhi=[dPhi;
      dPhi_eqs];
n_dPhi=size(dPhi,1);
dPhiH=dPhi;
n_dPhiH=n_dPhi;
ddPhi=[ddPhi;
      ddPhi_eqs];
n_ddPhi=size(ddPhi,1);
ddPhiH=ddPhi;
n_ddPhiH=n_ddPhi;
newLambdas(); %Define Lagrange multipliers
end