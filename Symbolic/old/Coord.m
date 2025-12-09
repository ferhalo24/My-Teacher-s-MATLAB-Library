function [out_n]=Coord(coord_name,coord_n,dcoord_n,ddcoord_n)
global q qNames
global dq dqNames
global ddq ddqNames
global n_q
global q_value
global dq_value
global ddq_value

if not(isKey(qNames,coord_name))
    error('Coordinate not defined, to define use newCoord(name,value...)');
end

dcoord_name=['d',coord_name];
ddcoord_name=['dd',coord_name];

if nargin==4
    q_value(qNames(coord_name))=coord_n;
    dq_value(dqNames(dcoord_name))=dcoord_n;
    ddq_value(ddqNames(ddcoord_name))=ddcoord_n;
elseif nargin==3
    q_value(qNames(coord_name))=coord_n;
    dq_value(dqNames(dcoord_name))=dcoord_n;
elseif nargin==2
    q_value(qNames(coord_name))=coord_n;
end

out_n=[q_value(qNames(coord_name))];
