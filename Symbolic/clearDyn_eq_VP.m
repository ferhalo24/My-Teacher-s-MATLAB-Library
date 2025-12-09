function clearDyn_eq_VP(VP_eqs,optimize)
global Dyn_eq_VP
global n_Dyn_eq_VP
global lambda_value
global lambda lambda_value n_lambda lambdaNames 

global simplify_expressions

if nargin==0
    VP_eqs=sym(zeros(0,1));
end
if nargin==1
    optimize=simplify_expressions;
end

if not(isempty(VP_eqs)) && optimize
    VP_eqs=simplify(VP_eqs);
end

Dyn_eq_VP=[VP_eqs];
n_Dyn_eq_VP=size(Dyn_eq_VP,1);

clearLambdas();

end