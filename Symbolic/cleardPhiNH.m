function cleardPhiNH(dPhiNH_eqs,optimize)
global dPhiNH ddPhiNH
global n_dPhiNH n_ddPhiNH

global simplify_expressions

if nargin==0
    dPhiNH_eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if optimize && (size(dPhiNH_eqs,1)>0)
    dPhiNH_eqs=simplify(dPhiNH_eqs);
end

dPhiNH=dPhiNH_eqs;
ddPhiNH=timederivative(dPhiNH);
n_dPhiNH=size(dPhiNH,1);
n_ddPhiNH=size(ddPhiNH,1);

end