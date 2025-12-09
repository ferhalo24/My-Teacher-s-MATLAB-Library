function out_n=ddCoord(ddcoord_name,ddcoord_n)
global q qNames
global dq dqNames
global ddq ddqNames
global n_q
global q_value
global dq_value
global ddq_value

if not(isKey(ddqNames,ddcoord_name))
    error('Generalized Acceleration %s is not defined, to define use newCoord(name,value[,dvalue[,ddvalue]])',ddcoord_name);
end
if nargin==2
ddq_value(ddqNames(ddcoord_name))=ddcoord_n;
end;

out_n=[ddq_value(ddqNames(ddcoord_name))];
