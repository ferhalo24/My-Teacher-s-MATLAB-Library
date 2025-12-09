function clearExtra_Dyn_Eq_eq(Extra_Perturbed_Dyn_State_eqs,optimize)
global Extra_Perturbed_Dyn_State_eq
global n_Extra_Perturbed_Dyn_State_eq
global simplify_expressions

if nargin==0
    Extra_Perturbed_Dyn_State_eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if not(isempty(Extra_Perturbed_Dyn_State_eqs)) && optimize
    Extra_Perturbed_Dyn_State_eqs=simplify(Extra_Perturbed_Dyn_State_eqs);
end

Extra_Perturbed_Dyn_State_eq=[Extra_Perturbed_Dyn_State_eqs];
n_Extra_Perturbed_Dyn_State_eq=size(Extra_Perturbed_Dyn_State_eq,1);

end