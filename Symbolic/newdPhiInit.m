function newdPhiInit(dphiInit,optimize)
global dPhiInit
global n_dPhiInit
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize  && (size(dphiInit,1)>0)
    dphiInit=simplify(dphiInit);
end

dPhiInit=[dPhiInit;
    dphiInit];
n_dPhiInit=size(dPhiInit,1);

end