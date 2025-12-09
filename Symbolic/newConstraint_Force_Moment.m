function [F3D,M3D,wrt_point_name]=newConstraint_Force_Moment(t,r,wrt_point_name,base_name,action_solid_name,reaction_solid_name)

global Solids
global SolidsNames
if nargin==5
    reaction_solid_name='Ext';
end
for i=1:3
    if not(t(i)==0)
      variable_name=strcat('FC_',reaction_solid_name,'_',action_solid_name,'_',int2str(i));
      F(i,1)=newEpsilon(variable_name,0);
      assignin('base',variable_name,F(i,1));
    else
      F(i,1)=sym(0);
    end
end
for i=1:3
    if not(r(i)==0)
      variable_name=strcat('MC_',reaction_solid_name,'_',action_solid_name,'_',int2str(i));
      M(i,1)=newEpsilon(variable_name,0);
      assignin('base',variable_name,F(i,1));
    else
      M(i,1)=sym(0);
    end
end    
F3D=Vector3D(F,base_name);
M3D=Vector3D(M,base_name);
    
