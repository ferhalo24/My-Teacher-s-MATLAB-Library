function newLambdas()
global dPhiH dPhiNH lambda

n_dPhi=size(dPhiH,1)+size(dPhiNH,1);

if nargin>=1
    warning('The function ''newLambdas'' does not need any argument');
end

if size(lambda,1) < n_dPhi
    
    for i=size(lambda,1)+1:n_dPhi
        newLambda(['lambda',num2str(i)] ,0);
    end
    
elseif size(lambda,1) == n_dPhi
    if n_dPhi>=1
        error('lamda vector must be empty 0x1');
    end
else
    error('unknown problem ocurred, but length(lambda) >  n_dPhi');
end