function [variable_s]=newInput(variable_name,variable_value)
global param
global n_param
global param_value
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
    
% if parameter_n<0
%    error('Parameter must be positive ( >=0 )');
% end
variable_s=sym(variable_name,'real');
% assume(parameter_s,'positive');

if nargout==0
   assignin('base',variable_name,variable_s) 
end

param=[param ; variable_s];

if nargin==1
    variable_value=0;
end

param_value=[param_value;variable_value];
n_param=length(param);

paramNames(variable_name)=n_param;

else
    error('Variable %s already defined in the base workspace',variable_name);
end