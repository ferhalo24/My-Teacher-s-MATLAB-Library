function newExtra_Dyn_Eq_eq(Extra_eqs,optimize)
global Extra_Dyn_Eq_eq
global n_Extra_Dyn_Eq_eq
global simplify_expressions

if nargin==1
    optimize=simplify_expressions;
end

if optimize
    n_columns=size(Extra_eqs,2);
    if n_columns>1 
        error('Extra_eqs argument must be a column vector')
    end
    Extra_eqs=simplify(Extra_eqs);
end

Extra_Dyn_Eq_eq=[Extra_Dyn_Eq_eq;
    Extra_eqs];
n_Extra_Dyn_Eq_eq=size(Extra_Dyn_Eq_eq,1);

end