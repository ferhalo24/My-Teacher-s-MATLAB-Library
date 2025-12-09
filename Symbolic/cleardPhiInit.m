function cleardPhiInit(eqs,optimize)
global dPhiInit
global n_dPhiInit

global simplify_expressions

if nargin==0
    eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if optimize && (size(eqs,1)>0)
    eqs=simplify(eqs);
end
dPhiInit=eqs;
n_dPhiInit=size(dPhiInit,1);

end