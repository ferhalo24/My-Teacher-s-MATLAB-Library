function [I_Sol_P_Sol,P_Sol_point_name]=inertia_tensor(Sol_solid_name,P_Sol_point_name)
global Solids SolidsNames
global Frames FramesNames

if nargin==1
    P_Sol_point_name=Frames(FramesNames(Sol_solid_name)).Point
end

V_Sol_P_Sol=simplify(Vel(Sol_solid_name,P_Sol_point_name));

if not(isSolid(Sol_solid_name))
   error([Sol_solid_name,'is not a solid name']); 
end
if not(isPoint(P_Sol_point_name))
   error([Sol_solid_name,'is not a solid name']); 
end
if not(isZero(V_Sol_P_Sol))
   error(['Point ',P_Sol_point_name,'does not belong to solid ',Sol_solid_name]);
end

m_Sol=Solids(SolidsNames(Sol_solid_name)).mass;
d_Sol_O_Sol=Solids(SolidsNames(Sol_solid_name)).first_mass_moment;
I_Sol_O_Sol=Solids(SolidsNames(Sol_solid_name)).inertia_tensor;

gravity_center_point_name=['G_',Sol_solid_name];
O_Sol_G_Sol=skew(1/m_Sol*d_Sol_O_Sol);
P_Sol_G_Sol=skew(Pos(P_Sol_point_name,gravity_center_point_name));

I_Sol_P_Sol=I_Sol_O_Sol+simplify(-(-m_Sol*O_Sol_G_Sol*O_Sol_G_Sol)+(-m_Sol*P_Sol_G_Sol*P_Sol_G_Sol));

end