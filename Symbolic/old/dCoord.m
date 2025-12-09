function [out_n]=dCoord(dcoord_name,dcoord_n)
global q qNames
global dq dqNames
global ddq ddqNames
global n_q
global q_value
global dq_value
global ddq_value

if not(isKey(dqNames,dcoord_name))
    error('Generalized Velocity %s is not defined, to define use newCoord(name,value[,dvalue[,ddvalue]])',dcoord_name);
end

if nargin==2
dq_value(dqNames(dcoord_name))=dcoord_n;
end

out_n=[dq_value(dqNames(dcoord_name))];
