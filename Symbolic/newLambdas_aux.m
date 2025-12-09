function newLambdas_aux()
global dPhiAux lambda_aux

n_dPhiAux=size(dPhiAux,1);

if nargin>=1
    warning('The function ''newLambdas_aux'' does not need any argument');
end

if size(lambda_aux,1) < n_dPhiAux
    
    for i=size(lambda_aux,1)+1:n_dPhiAux
        newLambda_aux(['lambda_aux',num2str(i)] ,0);
    end

elseif size(lambda_aux,1) == n_dPhiAux
        warning('The function ''newLambdas_aux'' already called'); 
else
    error('unknown problem ocurred, but length(lambda_aux) >  n_dPhiAux');
end

