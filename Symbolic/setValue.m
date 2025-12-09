function    out=setValue(variable_name,variable_value)

global param n_param param_value paramNames
global epsilon n_epsilon epsilon_value epsilonNames
global lambda n_lambda lambda_value lambdaNames
global lambda_aux lambda_aux_value lambda_auxNames
global q n_q q_value qNames
global dq dq_value dqNames
global ddq ddq_value ddqNames
global t t_value
global updateDraws_automatic

if nargin==2

    if isa(variable_name,'string') || isa(variable_name,'char')
        variable_name=str2sym(variable_name);
    end

    if isa(variable_value,'sym')
        variable_value=getValue(variable_value);
    end

    [n_sym,m_sym]=size(variable_name);
    [n_num,m_num]=size(variable_value);

    if (n_sym==n_num) && (m_sym==m_num)
        for i=1:n_sym
            for j=1:m_sym
                if isa(variable_name,'sym')
                    variable_string=sprintf('%s',variable_name(i,j));
                end
                if isequal('t',variable_string)
                    t_value=variable_value(i,j);
                elseif isKey(qNames,variable_string)
                    q_value(qNames(variable_string))=variable_value(i,j);
                elseif isKey(dqNames,variable_string)
                    dq_value(dqNames(variable_string))=variable_value(i,j);
                elseif isKey(ddqNames,variable_string)
                    ddq_value(ddqNames(variable_string))=variable_value(i,j);
                elseif isKey(paramNames,variable_string)
                    param_value(paramNames(variable_string))=variable_value(i,j);
                elseif isKey(epsilonNames,variable_string)
                    epsilon_value(epsilonNames(variable_string))=variable_value(i,j);
                elseif isKey(lambdaNames,variable_string)
                    lambda_value(lambdaNames(variable_string))=variable_value(i,j);
                elseif isKey(lambda_auxNames,variable_string)
                    lambda_aux_value(lambda_auxNames(variable_string))=variable_value(i,j);
                else
                    error('Variable not found %s', variable_string);
                end
            end
        end
        out=variable_value;
    end


    if updateDraws_automatic
        updateDraws;
    end

end

