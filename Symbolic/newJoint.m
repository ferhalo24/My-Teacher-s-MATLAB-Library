function out=newJoint(point_name, action_solid_name,reaction_solid_name,Joint_Phi,Joint_dPhi_NH)

global Solids
global SolidsNames
global Joints
global Phi dPhi_NH

%Joint is a joint implicit in the parametrization. No constraints are
%required
type=0;

if nargin==3
    Joint_Phi=[];
    Joint_dPhi_NH=[];
elseif nargin==4
    Joint_dPhi_NH=[];
end

n_Joints=length(Joints);
n_Joints=n_Joints+1;
if n_Joints==1
    Joints=Joint(type,point_name,action_solid_name,reaction_solid_name,Joint_Phi,Joint_dPhi_NH);
else
    Joints(n_Joints)=Joint(type,point_name,action_solid_name,reaction_solid_name,Joint_Phi,Joint_dPhi_NH);
end

out=Joints(n_Joints);

Phi=[Phi;
         out.Phi];

dPhi_NH=[dPhi_NH;
         out.dPhi_NH];

end
