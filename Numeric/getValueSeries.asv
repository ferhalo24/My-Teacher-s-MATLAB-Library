function func_series=getValueSeries(func_expr,extended_state_series)
global optimize_matlabFunction
global t q dq ddq epsilon lambda lambda_aux param
% getValueSeries evaluates a symbolic expression over a series of extended states.
%
% Syntax:
%   func_series = getValueSeries(func_expr, extended_state_series)
%
% Inputs:
%   func_expr - A symbolic expression (scalar or column vector) that 
%               represents the function to be evaluated.
%   extended_state_series - A matrix where each row corresponds to the 
%               extended state computed in a simulation.
%
% Outputs:
%   func_series - A matrix where each row contains the evaluated values 
%                 of func_expr for the corresponding row in 
%                 extended_state_series. The number of columns in 
%                 func_series matches the dimension of vector func_expr.
%
% Example:
%   syms t q dq ddq epsilon lambda lambda_aux param
%   func_expr = [t + q; dq^2 + ddq]; % Example symbolic expression
%   extended_state_series = [0, 1, 2, 3; 4, 5, 6, 7]; % Example input series
%   result = getValueSeries(func_expr, extended_state_series);
%
% Note:
%   This function uses the global variables optimize_matlabFunction, 
%   t, q, dq, ddq, epsilon, lambda, lambda_aux, and param. Ensure 
%   these variables are defined in the workspace before calling this function.
matlabFunction(func_expr,'file','func_name','Vars',{[t,q',dq',ddq',epsilon',lambda',lambda_aux',param']},'Optimize',optimize_matlabFunction);
fhandle = str2func('func_name');
func_series=zeros(size(extended_state_series,1),size(func_expr,1));
for k=1:size(extended_state_series,1)
    func_series(k,:)=fhandle(extended_state_series(k,:));
end
end