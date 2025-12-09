function clearPhi(Phi_eqs,optimize)
global Phi dPhi  ddPhi PhiH dPhiH ddPhiH
global n_Phi n_dPhi n_PhiH n_dPhiH n_ddPhi n_ddPhiH

global simplify_expressions

if nargin==0
    Phi_eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if optimize && (size(Phi_eqs,1)>0)
    Phi_eqs=simplify(Phi_eqs);
end


Phi=Phi_eqs;
PhiH=Phi;
dPhiH=timederivative(Phi);
ddPhiH=timederivative(dPhiH);
dPhi=dPhiH;
ddPhi=ddPhiH;
n_Phi=size(Phi,1);
n_PhiH=n_Phi;
n_dPhiH=size(dPhiH,1);
n_dPhi=n_dPhiH;
n_ddPhiH=size(ddPhiH,1);
n_ddPhi=n_ddPhiH;

end