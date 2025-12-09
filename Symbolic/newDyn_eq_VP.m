function newDyn_eq_VP(VP_eqs,optimize)
global Dyn_eq_VP
global n_Dyn_eq_VP
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize
    VP_eqs=simplify(VP_eqs);
end

Dyn_eq_VP=[Dyn_eq_VP;
     VP_eqs];
n_Dyn_eq_VP=size(Dyn_eq_VP,1);

end