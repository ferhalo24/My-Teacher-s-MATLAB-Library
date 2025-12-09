function clearExtra_Dyn_Eq_eq(Extra_Eq_eqs,optimize)
global Extra_Dyn_Eq_eq
global n_Extra_Dyn_Eq_eq

global simplify_expressions

if nargin==0
    Extra_Eq_eqs=sym(zeros(0,1));
end

if nargin<=1
    optimize=simplify_expressions;
end

if not(isempty(Extra_Eq_eqs)) && optimize
    Extra_Eq_eqs=simplify(Extra_Eq_eqs);
end

Extra_Dyn_Eq_eq=[Extra_Eq_eqs];
n_Extra_Dyn_Eq_eq=size(Extra_Dyn_Eq_eq,1);

end