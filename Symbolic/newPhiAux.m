function [coord,dcoord,ddcoord]=newPhiAux(phi,optimize)
global PhiAux dPhiAux ddPhiAux
global n_PhiAux n_dPhiAux n_ddPhiAux

global Phi dPhi ddPhi dPhiH ddPhiH
global n_Phi n_dPhi n_ddPhi n_dPhiH n_ddPhiH
dphi=timederivative(phi);
ddphi=timederivative(dphi);
if nargin==1
    optimize=false;
end
if optimize
    phi=simplify(phi);
    dphi=simplify(dphi);
    ddphi=simplify(ddphi);
end
PhiAux=[PhiAux;
     phi];
n_PhiAux=size(PhiAux,1);

dPhiAux=[dPhiAux;
      dphi];
n_dPhiAux=size(dPhiAux,1);

ddPhiAux=[ddPhiAux;
      ddphi];
n_ddPhiAux=size(ddPhiAux,1);

newLambdas_aux(); %Define Auxiliar Lagrange multipliers
end