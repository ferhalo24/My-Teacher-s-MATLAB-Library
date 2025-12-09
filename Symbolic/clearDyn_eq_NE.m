function clearDyn_eq_NE(eqs,optimize)
global Dyn_eq_NE
global n_Dyn_eq_NE

global simplify_expressions

if nargin==0
    eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if not(isempty(eqs)) && optimize
    eqs=simplify(eqs);
end

Dyn_eq_NE=[eqs];
n_Dyn_eq_NE=size(Dyn_eq_NE,1);

end