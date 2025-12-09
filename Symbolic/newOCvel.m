function [OCvel]=newOCvel()

global OCdq
global n_OCdq
global OCdqNames

global q  dq  ddq
global n_q n_dq n_ddq
global q_value dq_value ddq_value
global qNames dqNames ddqNames paramNames epsilonNames lambdaNames

variable_name=['OCdq',num2str(n_OCdq+1)];
ise = evalin( 'base', [ 'exist(''',variable_name,''',''var'') == 1' ] );

if not(ise)

    if isKey(OCdqNames,variable_name) || ...
            isKey(dqNames,variable_name) || ...
            isKey(dqNames,variable_name) || ...
            isKey(ddqNames,variable_name) || ...
            isKey(paramNames,variable_name) || ...
            isKey(epsilonNames,variable_name) || ...
            isKey(lambdaNames,variable_name)
        error('Variable name %s already defined, use a different name. To change value use setValue(name,value)',variable_name);
    end

    OCvel=sym(variable_name,'real');

    OCdq=[OCdq;OCvel];
    n_OCdq=length(OCdq);
    OCdqNames(variable_name)=n_OCdq;
    
    assignin('base',variable_name,OCvel);
    
else
    error('Variable %s already defined in the base workspace',variable_name);
end