function out=readExtendedStateHeader(fid)

global q_value
global dq_value
global ddq_value
global t_value
global epsilon_value
global lambda_value
global lambda_aux_value
global param_value

data=[t_value;q_value;dq_value;ddq_value;epsilon_value;lambda_value;lambda_aux_value;param_value];
out=[fscanf(fid,'%s',1)];
for i=2:length(data)
    out=[out,[' ',fscanf(fid,'%s',1)]];
end
