function [variable_s]=newEpsilon(variable_name,variable_value)
global epsilon
global n_epsilon
global epsilon_value
global qNames dqNames ddqNames paramNames epsilonNames lambdaNames

ise = evalin( 'base', ['exist(''',variable_name,''',''var'') == 1'] );

if not(ise)
    
    if isKey(qNames,variable_name) || ...
            isKey(dqNames,variable_name) || ...
            isKey(ddqNames,variable_name) || ...
            isKey(paramNames,variable_name) || ...
            isKey(epsilonNames,variable_name) || ...
            isKey(lambdaNames,variable_name)
        error('Variable name %s already defined, use a different name. To change value use setValue(name,value)',variable_name);
    end
    
    variable_s=sym(variable_name,'real');
    
    epsilon=[epsilon;variable_s];
    
    if nargin==1
        variable_value=0;
    end
    
%     if nargout==0
        assignin('base',variable_name,variable_s)
%     end
    
    epsilon_value=[epsilon_value;variable_value];
    n_epsilon=length(epsilon);
    
    epsilonNames(variable_name)=n_epsilon;
    
else
    error('Variable %s already defined in the base workspace',variable_name);
end
