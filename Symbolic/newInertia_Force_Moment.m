function [FI_Sol,MI_Sol_wrt_point,wrt_point_name]=newInertia_Force_Moment(solid_name,wrt_point_name)
global Solids SolidsNames
global Frames FramesNames
global InertialFrame_name
m_Sol=Solids(SolidsNames(solid_name)).mass;
d_Sol_O_Sol=Solids(SolidsNames(solid_name)).first_mass_moment;
I_Sol_O_Sol=Solids(SolidsNames(solid_name)).inertia_tensor;

Om_Sol=Omega(InertialFrame_name,solid_name);
H_Sol_O_Sol=I_Sol_O_Sol*Om_Sol;
Vel_O_Sol=timederivative(Pos(InertialFrame_name,solid_name),InertialFrame_name);
Accel_O_Sol=timederivative(Vel_O_Sol,InertialFrame_name);
cross_Om_Sol_d_Sol_O_Sol=cross(Om_Sol,d_Sol_O_Sol);

FI_Sol=-Accel_O_Sol*m_Sol-timederivative(cross_Om_Sol_d_Sol_O_Sol,InertialFrame_name);
MI_Sol_O_Sol=-(timederivative(H_Sol_O_Sol,InertialFrame_name)+cross(d_Sol_O_Sol,Accel_O_Sol));

O_Sol=Frames(FramesNames(solid_name)).Point;

if nargin==2
    MI_Sol_wrt_point=MI_Sol_O_Sol+cross(Pos(wrt_point_name,O_Sol),FI_Sol);
else
    MI_Sol_wrt_point=MI_Sol_O_Sol;
    wrt_point_name=O_Sol;
end

end
