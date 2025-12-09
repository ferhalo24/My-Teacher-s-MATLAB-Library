function series=expr_extended_state_series(expr,extended_state_series)
global optimize_matlabFunction
global t q dq ddq epsilon lambda lambda_aux param

matlabFunction(expr,'file','func_name','Vars',{[t,q',dq',ddq',epsilon',lambda',lambda_aux',param']},'Optimize',optimize_matlabFunction);
fhandle = str2func('func_name');
func_series=zeros(size(extended_state_series,1),size(expr,1));
for k=1:size(extended_state_series,1)
    series(k,:)=fhandle(extended_state_series(k,:));
end
