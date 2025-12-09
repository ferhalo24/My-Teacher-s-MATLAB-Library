function newdPhiNH(dphiNH_eqs,optimize)
global dPhi ddPhi dPhiH ddPhiH dPhiNH ddPhiNH
global n_dPhi n_ddPhi n_dPhiNH n_ddPhiNH
global simplify_expressions

dphiNH_eqs=[[];dphiNH_eqs];
ddphiNH=timederivative(dphiNH_eqs);

if nargin==1
    optimize=simplify_expressions;
end

if optimize && (size(dphiNH_eqs,1)>0)
    dphiNH_eqs=simplify(dphiNH_eqs);
    ddphiNH=simplify(ddphiNH);
end

dPhiNH=[dPhiNH;
    dphiNH_eqs];
n_dPhiNH=size(dPhiNH,1);
ddPhiNH=[ddPhiNH;
    ddphiNH];
n_ddPhiNH=size(ddPhiNH,1);
dPhi=[dPhiH;
      dphiNH_eqs];
n_dPhi=size(dPhi,1);
ddPhi=[ddPhiH;
      ddphiNH];
n_ddPhi=size(ddPhi,1);

end