function [variable_s]=newLambda_aux(variable_name,variable_value)
global lambda_aux
global n_lambda_aux
global lambda_aux_value
global qNames dqNames ddqNames paramNames epsilonNames lambdaNames lambda_auxNames

ise = evalin( 'base', ['exist(''',variable_name,''',''var'') == 1'] );

if not(ise)
    
    if isKey(qNames,variable_name) || ...
            isKey(dqNames,variable_name) || ...
            isKey(ddqNames,variable_name) || ...
            isKey(paramNames,variable_name) || ...
            isKey(epsilonNames,variable_name) || ...
            isKey(lambdaNames,variable_name) || ...
            isKey(lambda_auxNames,variable_name)
        error('Variable name %s already defined, use a different name. To change value use setValue(name,value)',variable_name);
    end
    
    variable_s=sym(variable_name,'real');
    
    lambda_aux=[lambda_aux;variable_s];
    
    if nargin==1
        variable_value=0;
    end
    
    if nargout==0
        assignin('base',variable_name,variable_s)
    end
    
    lambda_aux_value=[lambda_aux_value;variable_value];
    n_lambda_aux=length(lambda_aux);
    
    lambda_auxNames(variable_name)=n_lambda_aux;
    
else
     error('Variable %s already defined in the base workspace',variable_name);
end