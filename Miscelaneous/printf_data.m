function out=printf_data(fid,data_)

global q_value
global dq_value
global ddq_value
global t_value
global epsilon_value
global lambda_value
global lambda_aux_value
global param_value

format_str=[];
data=data_(q_value,dq_value,ddq_value,t_value,param_value);
for i=1:length(data)-1
    format_str=[format_str,'%9.7e  '];
end
format_str=[format_str,'%9.7e\n'];

out=fprintf(fid,format_str,data);