function loadExtendedState(dynamic_extended_state_mat_file_name)
global q dq ddq t param epsilon lambda lambda_aux
global q_value dq_value ddq_value t_value param_value epsilon_value lambda_value lambda_aux_value
global updateDraws_automatic

S=load(dynamic_extended_state_mat_file_name);

q_value(1:length(S.q_value),1)=S.q_value;
dq_value(1:length(S.q_value),1)=S.dq_value;
ddq_value(1:length(S.q_value),1)=S.ddq_value;
if not(isequal(size(q),size(S.q_value)))
    warning('Loaded q_value, dq_value and ddq_value, shorter than current ones. Just provided values are updated.');
end
t_value=S.t_value;
epsilon_value(1:length(S.epsilon_value),1)=S.epsilon_value;
if not(isequal(size(epsilon),size(S.epsilon_value)))
    warning('Loaded epsilon_value shorter than current one. Just provided values are updated.');
end
lambda_value(1:length(S.lambda_value),1)=S.lambda_value;
if not(isequal(size(lambda),size(S.lambda_value)))
    warning('Loaded lambda_value shorter than current one. Just provided values are updated.');
end
lambda_aux_value(1:length(S.lambda_aux_value),1)=S.lambda_aux_value;
if not(isequal(size(lambda_aux),size(S.lambda_aux_value)))
    warning('Loaded lambda_aux_value shorter than current one. Just provided values are updated.');
end
param_value(1:length(S.param_value),1)=S.param_value;
if not(isequal(size(param),size(S.param_value)))
    warning('Loaded param_value, shorter than current one. Just provided values are updated.');
end

if updateDraws_automatic
    updateDraws;
end
end
