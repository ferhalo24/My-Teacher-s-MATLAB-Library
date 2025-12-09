function [variable_s]=newMass(solid_name,variable_n)
global param
global n_param
global param_value
global qNames dqNames ddqNames paramNames epsilonNames lambdaNames

variable_name=['m_',solid_name];
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



if nargin==1
    variable_n=0;
elseif (not(isequal(size(variable_n),[1,1]))) || (not(isnumeric(variable_n)))
    error('Second argument must be a number');
end

param=[param ; variable_s];
param_value=[param_value;variable_n];
n_param=length(param);

paramNames(variable_name)=n_param;

else
    error('Variable %s already defined in the base workspace',variable_name);
end