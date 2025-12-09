function [out_n]=Param(parameter_name,parameter_n)
global param
global n_param
global param_value
global paramNames

if not(isKey(paramNames,parameter_name))
    error('Parameter not defined, to define use newParam(name,value)');
end

if nargin==2
    param_value(paramNames(parameter_name))=parameter_n;
end

out_n=param_value(paramNames(parameter_name));