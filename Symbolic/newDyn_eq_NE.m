function newDyn_eq_NE(NE_eqs,optimize)
global Dyn_eq_NE
global n_Dyn_eq_NE
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize
    NE_eqs=simplify(NE_eqs);
end

Dyn_eq_NE=[Dyn_eq_NE;
    NE_eqs];
n_Dyn_eq_NE=size(Dyn_eq_NE,1);

end