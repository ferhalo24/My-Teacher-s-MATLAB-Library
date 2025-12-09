function clearPhiInit(eqs,optimize)
global PhiInit
global n_PhiInit

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

PhiInit=eqs;
n_PhiInit=size(PhiInit,1);

end