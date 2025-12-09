function newExtra_Perturbed_Dyn_State_eq(Extra_eqs,optimize)
global Extra_Perturbed_Dyn_State_eq
global n_Extra_Perturbed_Dyn_State_eq
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize
    Extra_eqs=simplify(Extra_eqs);
end

Extra_Perturbed_Dyn_State_eq=[Extra_Perturbed_Dyn_State_eq;
    Extra_eqs];
n_Extra_Perturbed_Dyn_State_eq=size(Extra_Perturbed_Dyn_State_eq,1);

end