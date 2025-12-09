function out=getValue(in,base_name)
% getValue  
%   out = getValue(in) eval symbolic scalar expresion to a number
%
%   out = getValue(in,base_name) eval Vector3D to a matrix of numbers in
%   base basename
%
%   See also setValue.
global NamesBases

global t t_value
global q q_value
global dq dq_value
global ddq ddq_value
global param param_value
global epsilon epsilon_value
global lambda lambda_value
global lambda_aux lambda_aux_value

global  paramNames
global  epsilonNames
global  lambdaNames
global  lambda_auxNames
global  qNames
global  dqNames
global  ddqNames

if not(isa(in,'Vector3D'))
    if isa(in,'sym')
        out=double(subs(in,[q;dq;ddq;t;param;epsilon;lambda;lambda_aux;sym(pi)],[q_value;dq_value;ddq_value;t_value;param_value;epsilon_value;lambda_value;lambda_aux_value;double(pi)]));
    else
        
        in=subs(str2sym(in));
        out=double(subs(in,[q;dq;ddq;t;param;epsilon;lambda;lambda_aux;sym(pi)],[q_value;dq_value;ddq_value;t_value;param_value;epsilon_value;lambda_value;lambda_aux_value;double(pi)]));

        % variable_name=sprintf('%s',in);
        % if isequal('t',variable_name)
        %     out=t_value;
        % elseif isKey(qNames,variable_name)
        %     out=q_value(qNames(variable_name));
        % elseif isKey(dqNames,variable_name)
        %     out=dq_value(dqNames(variable_name));
        % elseif isKey(ddqNames,variable_name)
        %     out=ddq_value(ddqNames(variable_name));
        % elseif isKey(paramNames,variable_name)
        %     out=param_value(paramNames(variable_name));
        % elseif isKey(epsilonNames,variable_name)
        %     out=epsilon_value(epsilonNames(variable_name));
        % elseif isKey(lambdaNames,variable_name)
        %     out=lambda_value(lambdaNames(variable_name));
        % elseif isKey(lambda_auxNames,variable_name)
        %     out=lambda_aux_value(lambda_auxNames(variable_name));
        % else
        %     error('Expression %s is not symbolic', variable_name);
        % end
    end
else
    if nargin==1
        out.Comps=getValue(in.Value);
        if in.Base==0
            out.Base_name='xyz';
        else
            out.Base_name=NamesBases(in.Base).Base_name;
        end
    elseif nargin==2
        in=in.inBase(base_name);
        out=getValue(in.Value);
    else
        error('To get the value of a Vector3D: getValue(Vector3D,''base_name''');
    end
end
end