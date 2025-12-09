function [FG_Sol,MG_Sol_wrt_point,wrt_point_name]=newGravity_Force_Moment(solid_name,wrt_point_name)
global param paramNames
global Solids
global SolidsNames
global Frames
global FramesNames
global GravityVector;
g=param(paramNames('g'));

m_Sol=Solids(SolidsNames(solid_name)).mass;
d_Sol_O_Sol=Solids(SolidsNames(solid_name)).first_mass_moment;
I_Sol_O_Sol=Solids(SolidsNames(solid_name)).inertia_tensor;

O_Sol=Frames(FramesNames(solid_name)).Point;

FG_Sol=m_Sol*GravityVector;

if nargin==1
    MG_Sol_wrt_point=cross(d_Sol_O_Sol,GravityVector);
    wrt_point_name=O_Sol;
elseif nargin==2
    if strcmp(wrt_point_name,Solids(SolidsNames(solid_name)).G)
        MG_Sol_wrt_point=Vector3D([0,0,0]','xyz');
    elseif strcmp(wrt_point_name,O_Sol)
        MG_Sol_wrt_point=cross(d_Sol_O_Sol,GravityVector);
    else 
        MG_Sol_wrt_point=cross(Pos(wrt_point_name,O_Sol),FG_Sol)+cross(d_Sol_O_Sol,GravityVector);
    end
end

end
